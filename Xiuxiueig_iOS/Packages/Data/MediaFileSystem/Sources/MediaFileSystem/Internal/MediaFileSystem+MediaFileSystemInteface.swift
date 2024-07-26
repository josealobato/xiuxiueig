// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XToolKit

extension MediaFileSystem: MediaFileSystemInteface {

    private func documentsURL() throws -> URL {
        let fileMng = FileManager.default
        let docsURL = try fileMng.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false)
        return docsURL
    }

    private func inboxFolder() throws -> URL {
        return try documentsURL().appendingPathComponent(Constants.inboxFolderName)
    }

    private func managedFolder() throws -> URL {
        return try documentsURL().appendingPathComponent(Constants.managedFolderName)
    }

    private func archivedFolder() throws -> URL {
        return try documentsURL().appendingPathComponent(Constants.archivedFolderName)
    }

    private func discardedFolder() throws -> URL {
        return try documentsURL().appendingPathComponent(Constants.discardedFolderName)
    }

    private func mediaFilesInFolder(folderURL: URL, isManaged: Bool) throws -> [MediaFile] {
        let fileMng = FileManager.default
        let fileURLs = try fileMng.contentsOfDirectory(at: folderURL,
                                                       includingPropertiesForKeys: nil)
        let mediaFiles = fileURLs.compactMap { MediaFile.init(url: $0, isNew: !isManaged) }

        return mediaFiles
    }

    // MARK: - MediaFileSystemInteface implementation

    func managedFiles() -> [MediaFile] {

        do {
            let managedFolder = try managedFolder()
            return try mediaFilesInFolder(folderURL: managedFolder, isManaged: true)
        } catch { logger.error("Error getting the managed files \(error)") }
        return []
    }

    func unmanagedFiles() -> [MediaFile] {

        do {
            let inboxFolder = try inboxFolder()
            return try mediaFilesInFolder(folderURL: inboxFolder, isManaged: false)
        } catch { logger.error("Error getting the managed files \(error)") }
        return []
    }

    func archivedFiles() -> [MediaFile] {

        do {
            let archivedFolder = try archivedFolder()
            return try mediaFilesInFolder(folderURL: archivedFolder, isManaged: true)
        } catch { logger.error("Error getting the archived files \(error)") }
        return []
    }

    func discardedFiles() -> [MediaFile] {

        do {
            let discardedFolder = try discardedFolder()
            return try mediaFilesInFolder(folderURL: discardedFolder, isManaged: true)
        } catch { logger.error("Error getting the discarded files \(error)") }
        return []
    }

    func file(from url: URL) -> MediaFile? {
        let fileMng = FileManager.default

        if fileMng.fileExists(atPath: url.path) {
            let pathComponents = url.pathComponents
            let pathContainsInbox = pathComponents.contains(Constants.inboxFolderName)
            return MediaFile(url: url, isNew: pathContainsInbox)
        } else {
            logger.debug("Not existing file by url: \(url)")
            return nil
        }
    }

    func updateFile(file: MediaFile) -> MediaFile? {

        // Before calling this method the Media file should be modified with a
        // valid ID and and name.

        // If the file is not dirty, there is nothing to update.
        guard file.isDirty else { return file }
        // If the file is not ready to be managed (have valid data) fail by returning no file.
        guard file.canBeManaged else { return nil }

        do {
            let currentLocation = file.url
            let base = currentLocation.deletingLastPathComponent()
            let destinationLocation = base.appendingPathComponent(file.fileName)

            let fileMng = FileManager.default
            try fileMng.moveItem(at: currentLocation, to: destinationLocation)

            return MediaFile(url: destinationLocation, isNew: file.isNew)
        } catch {
            logger.error("Error Updating file \(file.name) with error \(error)")
            return nil
        }
    }

    /// Convert a file to know without moving to to another location.
    /// This will mostly rename the file to not have the ID
    /// - Parameter file: the file to modify
    /// - Returns: the modified file
    private func convertToNewWithoutMoving(file: MediaFile) throws -> MediaFile {

        // Modify the file to be a new file
        var newfile = file
        newfile.id = nil

        // Now move it to achive the rename but without moving it.
        let currentLocation = newfile.url
        let base = currentLocation.deletingLastPathComponent()
        let destinationLocation = base.appendingPathComponent(newfile.fileName)

        let fileMng = FileManager.default
        try fileMng.moveItem(at: currentLocation, to: destinationLocation)

        if let resultingMediaFile = MediaFile(url: destinationLocation, isNew: true) {
            return resultingMediaFile
        } else {
            logger.error("Error converting to new file \(file.name)")
            throw MediaFileSystemError.convertingFileToNew
        }
    }

    func manageFile(file: MediaFile) -> MediaFile? {

        guard file.canBeManaged else { return nil }

        do {
            let currentLocation = file.url
            let destination = try managedFolder().appendingPathComponent(file.fileName)

            let fileMng = FileManager.default
            try fileMng.moveItem(at: currentLocation, to: destination)
            return MediaFile(url: destination, isNew: false)
        } catch {
            logger.error("Error managing file \(file.name) with error \(error)")
            return nil
        }
    }

    func archiveFile(file: MediaFile) -> MediaFile? {

        guard file.canBeManaged else { return nil }

        do {
            let currentLocation = file.url
            let destination = try archivedFolder().appendingPathComponent(file.fileName)

            let fileMng = FileManager.default
            try fileMng.moveItem(at: currentLocation, to: destination)
            return MediaFile(url: destination, isNew: false)
        } catch {
            logger.error("Error archiving file \(file.name) with error \(error)")
            return nil
        }
    }

    func unarchiveFile(file: MediaFile) -> MediaFile? {

        manageFile(file: file)
    }

    func deleteFile(file: MediaFile) {

        do {
            let fileMng = FileManager.default
            try fileMng.removeItem(at: file.url)
        } catch {
            logger.error("Error deleting file \(file.name) with error \(error)")
        }
    }

    func discardFile(file: MediaFile) -> MediaFile? {

        do {

            var newFile = file
            if !file.isNew {
                newFile = try convertToNewWithoutMoving(file: file)
            }

            let currentLocation = newFile.url
            let destination = try discardedFolder().appendingPathComponent(newFile.fileName)

            let fileMng = FileManager.default
            try fileMng.moveItem(at: currentLocation, to: destination)
            return MediaFile(url: destination, isNew: true)
        } catch {
            logger.error("Error discarding file \(file.name) with error \(error)")
            return nil
        }
    }

    func resetDefaultMediaFiles() {

        setUpIfNeeded()
    }
}
