// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XToolKit

struct MediaFileSystem {

    enum MediaFileSystemError: Error {

        case convertingFileToNew
    }

    let logger = XLog.logger(category: "MediaFileSystem")

    enum Constants {
        static let managedFolderName: String = "Managed"
        static let inboxFolderName: String = "Inbox"
        static let archivedFolderName: String = "Archived"
        static let discardedFolderName: String = "Discarded"
    }

    init() {
       setUpIfNeeded()
    }

    func setUpIfNeeded(forceDefaultFiles: Bool = false) {

        setUpInboxFolderIfNeeded(copyDefaultFiles: forceDefaultFiles)
        setUpManageFolderIfNeeded()
        setUpArchivedFolderIfNeeded()
        setUpDiscardedFolderIfNeeded()
    }

    let defaultMediaFilesFilesInBundle = [

            Bundle.module.url(forResource: "1-Introduction to Ratpenat 1", withExtension: "mp3")!,
            Bundle.module.url(forResource: "2-Introduction to Ratpenat 2", withExtension: "mp3")!,
            Bundle.module.url(forResource: "3-Introduction to Ratpenat 3", withExtension: "mp3")!
        ]

    private func existDirectory(url: URL) -> Bool {

        let fileMng = FileManager.default
        var isDir: ObjCBool = false

        let existFile = fileMng.fileExists(atPath: url.path, isDirectory: &isDir)
        let isDirectory = isDir.boolValue == true

        return existFile && isDirectory
    }

    private func setUpManageFolderIfNeeded() {

        do {
            let fileMng = FileManager.default
            let docsURL = try fileMng.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false
            )

            logger.debug("documents URL: \(docsURL.absoluteString)")

            let manageFolderULR = docsURL.appendingPathComponent(Constants.managedFolderName)
            if !existDirectory(url: manageFolderULR) {

                try fileMng.createDirectory(at: manageFolderULR, withIntermediateDirectories: false)
            }
        } catch {
            logger.error("Error encounter when setting the '\(Constants.managedFolderName)' folder \(error)")
        }
    }

    private func setUpInboxFolderIfNeeded(copyDefaultFiles: Bool = false) {

        do {
            let fileMng = FileManager.default
            let docsURL = try fileMng.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false
            )

            let inboxFolderULR = docsURL.appendingPathComponent(Constants.inboxFolderName)
            var inboxJustCreated = false
            if !existDirectory(url: inboxFolderULR) {

                try fileMng.createDirectory(at: inboxFolderULR, withIntermediateDirectories: false)
                inboxJustCreated = true
            }

            // Copy demo files when requested or the folder is just created.
            if copyDefaultFiles || inboxJustCreated {

                for mediaFileURL in defaultMediaFilesFilesInBundle {

                    let fileName = mediaFileURL.lastPathComponent
                    let newUrl = inboxFolderULR.appendingPathComponent(fileName)
                    try fileMng.copyItem(at: mediaFileURL, to: newUrl)
                }
            }
        } catch {
            logger.error("Error encounter when setting the ''\(Constants.inboxFolderName)'' folder \(error)")
        }
    }

    private func setUpArchivedFolderIfNeeded() {

        do {
            let fileMng = FileManager.default
            let docsURL = try fileMng.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false
            )

            let manageFolderULR = docsURL.appendingPathComponent(Constants.archivedFolderName)
            if !existDirectory(url: manageFolderULR) {

                try fileMng.createDirectory(at: manageFolderULR, withIntermediateDirectories: false)
            }
        } catch {
            logger.error("Error encounter when setting the '\(Constants.archivedFolderName)' folder \(error)")
        }
    }

    private func setUpDiscardedFolderIfNeeded() {

        do {
            let fileMng = FileManager.default
            let docsURL = try fileMng.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false
            )

            let discardedFolderULR = docsURL.appendingPathComponent(Constants.discardedFolderName)
            if !existDirectory(url: discardedFolderULR) {

                try fileMng.createDirectory(at: discardedFolderULR, withIntermediateDirectories: false)
            }
        } catch {
            logger.error("Error encounter when setting the '\(Constants.discardedFolderName)' folder \(error)")
        }
    }
}
