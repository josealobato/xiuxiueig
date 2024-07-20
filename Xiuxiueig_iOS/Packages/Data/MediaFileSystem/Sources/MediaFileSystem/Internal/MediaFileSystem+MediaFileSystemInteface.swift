// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XToolKit

extension MediaFileSystem: MediaFileSystemInteface {

    private func inboxFolder() throws -> URL {

        let fileMng = FileManager.default
        let docsURL = try fileMng.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        return docsURL.appendingPathComponent(Constants.inboxFolderName)
    }

    private func managedFolder() throws -> URL {

        let fileMng = FileManager.default
        let docsURL = try fileMng.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        )
        return docsURL.appendingPathComponent(Constants.managedFolderName)
    }

    private func archivedFolder() throws -> URL {

        let fileMng = FileManager.default
        let docsURL = try fileMng.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        )
        return docsURL.appendingPathComponent(Constants.archivedFolderName)
    }

    private func rejectedFolder() throws -> URL {

        let fileMng = FileManager.default
        let docsURL = try fileMng.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        )
        return docsURL.appendingPathComponent(Constants.rejectedFolderName)
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

    func resetDefaultMediaFiles() {

        setUpIfNeeded()

    }
}
