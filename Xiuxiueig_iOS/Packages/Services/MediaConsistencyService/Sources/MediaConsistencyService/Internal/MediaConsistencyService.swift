// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XCoordinator
import MediaFileSystem
import XRepositories
import XToolKit

class MediaConsistencyService {

    let logger = XLog.logger(category: "MediaConsistencyService")

    var coordinator: XCoordinationRequestProtocol?

    var fileSystem: MediaFileSystemInteface
    var repository: LectureRepositoryInteface

    // All request to the MCS will be perform sequencialy in a serial queue to avoid collisions
    // on accessing the file system
    let processorSerialQueue = DispatchQueue(label: "com.xiuxiueig.mediaConsistencyService")

    init(fileSystem: MediaFileSystemInteface,
         repository: LectureRepositoryInteface,
         coordinator: XCoordinationRequestProtocol? = nil) {
        self.coordinator = coordinator
        self.fileSystem = fileSystem
        self.repository = repository
    }
}

// MARK: - MediaConsistencyServiceInterface

extension MediaConsistencyService: MediaConsistencyServiceInterface {

    func update(entity: LectureDataEntity) throws -> LectureDataEntity {

        var resultingEntity: LectureDataEntity

        // Whenever this method is called we want to added to the queue
        // to avoid interfearances with the consistency check. But that will
        // make the call async, So we force it to be sync since we understand
        // that will be called in a background thread. Anyway the signature of
        // the method already informs that is sync, it is just that now it might
        // take longer.
        resultingEntity = try processorSerialQueue.sync {
            logger.debug("MCS Update Entity Start -> ")
            // Get the file entity by the url.
            guard var mediaFile = fileSystem.file(from: entity.mediaURL) else {
                logger.warning("On Update, no existing file for entity \(entity.title)")
                throw MediaConsistencyServiceError.noMediaFileForGivenEntity
            }

            var needUpdate = false
            // Change the ID if needed
            if mediaFile.id != entity.id.uuidString {
                mediaFile.id = entity.id.uuidString
                needUpdate = true
            }

            // change the name if needed
            let newValidFileName = validFileName(from: entity.title)
            if mediaFile.name != newValidFileName {
                mediaFile.name = newValidFileName
                needUpdate = true
            }

            // Check the state and update the file system if needed
            var updatedMediaFile: MediaFile?
            switch (entity.state, mediaFile.isNew) {
            case (.new, true): // No change in new state
                if needUpdate {
                    updatedMediaFile = fileSystem.updateFile(file: mediaFile)
                }
            case (.new, false): throw MediaConsistencyServiceError.movingToNewIsNotAllowed
            case (.managed, _): // No matter the previous value, it needs to manage.
                // Manage (independently if it needs update)
                // Notice that archive will also update taking into accoun the changes in ID or name.
                updatedMediaFile = try manage(unmanagedFile: mediaFile)
            case (.archived, _): // No matter the previous value, it needs to archive.
                // Archive (independently if it needs update)
                // Notice that archive will also update taking into accoun the changes in ID or name.
                updatedMediaFile = try archive(managedFile: mediaFile)
            }

            // After all changes are done in the
            // Update entity with media file and return it.

            if let mediaFile = updatedMediaFile {
                var modifiedEntity = entity
                modifiedEntity.mediaURL = mediaFile.url
                return modifiedEntity
            } else {
                return entity
            }
        }

        logger.debug("<- MCS Update Entity Start")
        return resultingEntity
    }

    /// Generate a valid macOS name from a string.
    /// - Parameter title: The input string
    /// - Returns: based on the input string a value macOS file name.
    private func validFileName(from title: String) -> String {
        let invalidCharacters = CharacterSet(charactersIn: ":/\\?%*|\"<>")
        let maxLength = 255

        let sanitizedTitle = title
            .components(separatedBy: invalidCharacters)
            .joined(separator: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)

        let fileName = sanitizedTitle.prefix(maxLength)

        return fileName.isEmpty ? "untitled" : String(fileName)
    }

    private func manage(unmanagedFile: MediaFile) throws -> MediaFile {
        if let mediaFile = fileSystem.manageFile(file: unmanagedFile) {
            logger.debug("MCS managed file: \(unmanagedFile.name)")
            return mediaFile
        } else {
            logger.error("MCS not possible to manage file: \(unmanagedFile.name)")
            throw MediaConsistencyServiceError.notPossibleToManageMediaFile
        }
    }

    private func archive(managedFile: MediaFile) throws -> MediaFile {
        if let mediaFile = fileSystem.archiveFile(file: managedFile) {
            logger.debug("MCS archived file: \(managedFile.name)")
            return mediaFile
        } else {
            logger.error("MCS not possible to archive file: \(managedFile.name)")
            throw MediaConsistencyServiceError.notPossibleToArchiveMediaFile
        }
    }

    public func delete(entity: LectureDataEntity) throws {
        let files: [MediaFile] = fileSystem.unmanagedFiles() + fileSystem.managedFiles()
        // We do not use the id to check the file because unmanaged files do not have id.
        if let file = files.first(where: { $0.url == entity.mediaURL}) {
            logger.debug("MCS request to delete file: \(entity.title)")
            fileSystem.deleteFile(file: file)
        } else {
            logger.error("MCS no media file for entity: \(entity.title)")
            throw MediaConsistencyServiceError.noMediaFileForGivenEntity
        }
    }
}

// MARK: - Scan for new files

extension MediaConsistencyService {

    // MARK: - New files and entities

    /// This method will scan for new files and create entities for the ones that
    /// do not have.
    func scanForNewFiles() async throws {
        // 1. Get all new files from the file system
        let newFiles = self.fileSystem.unmanagedFiles()

        // 2. Get all new files from the repo
        let newEntities = try? await self.repository.lectures().filter({ $0.state == .new })

        // 3. For every file...
        for file in newFiles {
            // If there is no entity?
            if let entities = newEntities,
               !(entities.contains(where: { $0.title == file.name })) {
                // Create one.
                let newEntity = LectureDataEntity(
                    id: UUID(),
                    title: file.name,
                    category: nil,
                    mediaURL: file.url,
                    imageURL: nil,
                    queuePosition: nil,
                    playPosition: nil,
                    played: [],
                    state: .new
                )
                try? await self.repository.add(lecture: newEntity)
                logger.debug("MCS add new entity for new file: \(newEntity.title)")
            }
        }
        // 4. Finally save the changes
        try await self.repository.persist()
    }

    /// This method will check that all entities in the DB have a valid file
    /// in the file system
    func checkNewFilesEntitiesConsistency() async throws {

        // 1. Get all new files from the file system
        let newFiles = self.fileSystem.unmanagedFiles()

        // 2. Get all new files from the repo
        let newEntities = (try? await self.repository.lectures().filter({ $0.state == .new })) ?? []

        // 3. For every entity...
        for entity in newEntities {
            // find a file with matching URL
            let fileExist = newFiles.contains(where: { $0.url == entity.mediaURL })
            if !fileExist {
                // If none is found, delete the entity:
                try await self.repository.deleteLecture(withId: entity.id)
                logger.warning("MCS delete new entity: \(entity.title), file is not there")
            }
        }
        // 4. Finally save the changes
        try await self.repository.persist()
    }

    // MARK: - Managed files and entities

    func checkManagedFilesConsistency() async throws {

        // 1. Get all managed files
        let managedFiles = self.fileSystem.managedFiles()

        // 3. For every file, there should be a matching entity
        for managedFile in managedFiles {
            if let fileID =  managedFile.id, // file has and id...
               let uuid = UUID(uuidString: fileID), // that is a uuid...
               let lecture = try? await self.repository.lecture(withId: uuid),
               lecture.state == .managed {
                /* matchingEntity exist so nothing to do */
            } else {
                // Otherwise discard the file.
                _ = self.fileSystem.discardFile(file: managedFile)
                logger.warning("MCS discard managed file: \(managedFile.name) no lecture found")
            }
        }
    }

    func checkManagedEntitiesConsistency() async throws {

        // 1. Get all managed Entities
        let managedEntities: [LectureDataEntity] =
        (try? await self.repository.lectures().filter({ $0.state == .managed })) ?? []

        // 2. Get all managed files
        let managedFiles = self.fileSystem.managedFiles()

        // 3. For every Entity, there should be a matching File
        for entity in managedEntities {
            let file = managedFiles.first(where: { $0.id == entity.id.uuidString })
            if file == nil {
                try await self.repository.deleteLecture(withId: entity.id)
                logger.warning("MCS delete managed entity: \(entity.title) no file found")
            }
        }
    }

    // MARK: - Archived files and entities

    func checkArchivedFilesConsistency() async throws {

        // 1. Get all archived files
        let archivedFiles = self.fileSystem.archivedFiles()

        // 3. For every file, there should be a matching entity
        for archivedFile in archivedFiles {
            if let fileID =  archivedFile.id, // file has and id...
               let uuid = UUID(uuidString: fileID), // that is a uuid...
               let lecture = try? await self.repository.lecture(withId: uuid),
               lecture.state == .archived {
                /* matchingEntity exist so nothing to do */
            } else {
                // Otherwise discard the file.
                _ = self.fileSystem.discardFile(file: archivedFile)
                logger.warning("MCS discard archived file: \(archivedFile.name) no entity found")
            }
        }
    }

    func checkArchivedEntitiesConsistency() async throws {

        // 1. Get all archived Entities
        let archivedEntities: [LectureDataEntity] =
        (try? await self.repository.lectures().filter({ $0.state == .archived })) ?? []

        // 2. Get all arvhived files
        let archivedFiles = self.fileSystem.archivedFiles()

        // 3. For every Entity, there should be a matching File
        for entity in archivedEntities {
            let archive = archivedFiles.first(where: { $0.id == entity.id.uuidString })
            if archive == nil {
                try await self.repository.deleteLecture(withId: entity.id)
                logger.warning("MCS delete archived entity: \(entity.title) no file found")
            }
        }
    }
}
