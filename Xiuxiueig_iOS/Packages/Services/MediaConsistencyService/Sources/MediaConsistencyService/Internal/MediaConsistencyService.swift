// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XCoordinator
import MediaFileSystem
import XRepositories

class MediaConsistencyService {

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

    func manage(entity: XRepositories.LectureDataEntity) {
        if let unmanagedFile = fileSystem.unmanagedFiles().first(where: { $0.id == entity.id.uuidString}) {
            _ = fileSystem.manageFile(file: unmanagedFile)
        }
    }

    func archive(entity: XRepositories.LectureDataEntity) {
        if let managedFile = fileSystem.managedFiles().first(where: { $0.id == entity.id.uuidString}) {
            _ = fileSystem.archiveFile(file: managedFile)
        }
    }

    func delete(entity: XRepositories.LectureDataEntity) {
        let files: [MediaFile] = fileSystem.unmanagedFiles() + fileSystem.managedFiles()
        if let file = files.first(where: { $0.id == entity.id.uuidString}) {
            _ = fileSystem.deleteFile(file: file)
        }
    }
}

// MARK: - Scan for new files

extension MediaConsistencyService {

    // MARK: - New files and entities

    /// This method will scan for new files and create entities for the ones that
    /// do not have.
    func scanForNewFiles() {

        Task {
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
                }
            }
            // 4. Finally save the changes
            try await self.repository.persist()
        }
    }

    /// This method will check that all entities in the DB have a valid file
    /// in the file system
    func checkNewFilesEntitiesConsistency() {

        Task {
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
                }
            }
            // 4. Finally save the changes
            try await self.repository.persist()
        }
    }

    // MARK: - Managed files and entities

    func checkManagedFilesConsistency() {

        Task {
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
                }
            }
        }
    }

    func checkManagedEntitiesConsistency() {

        Task {
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
                }
            }
        }
    }

    // MARK: - Archived files and entities

    func checkArchivedFilesConsistency() {

        Task {
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
                }
            }
        }
    }

    func checkArchivedEntitiesConsistency() {

        Task {
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
                }
            }
        }
    }
}
