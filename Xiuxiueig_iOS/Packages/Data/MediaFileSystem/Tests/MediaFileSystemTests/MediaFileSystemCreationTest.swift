// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import XCTest
@testable import MediaFileSystem

final class MediaFileSystemCreationTest: XCTestCase {

    // MARK: - Test

    override func setUpWithError() throws {
        deleteAllBeforeTest()
    }

    enum Constants {
        static let managedFolderName: String = "Managed"
        static let inboxFolderName: String = "Inbox"
        static let archivedFolderName: String = "Archived"
        static let discardedFolderName: String = "Discarded"
    }

    private func baseFolderURL() -> URL {
        return MediaFile.baseURL()!
    }

    func deleteAllBeforeTest() {

        let fileMng = FileManager.default
        let baseFolderURL = baseFolderURL()

        let inboxFolderULR = baseFolderURL.appendingPathComponent(Constants.inboxFolderName)
        try? fileMng.removeItem(at: inboxFolderULR)
        let managedFolderULR = baseFolderURL.appendingPathComponent(Constants.managedFolderName)
        try? fileMng.removeItem(at: managedFolderULR)
        let archivedFolderULR = baseFolderURL.appendingPathComponent(Constants.archivedFolderName)
        try? fileMng.removeItem(at: archivedFolderULR)
        let discardedFolderULR = baseFolderURL.appendingPathComponent(Constants.discardedFolderName)
        try? fileMng.removeItem(at: discardedFolderULR)
    }

    private func existDirectory(url: URL) -> Bool {

        let fileMng = FileManager.default
        var isDir: ObjCBool = false

        let existFile = fileMng.fileExists(atPath: url.path, isDirectory: &isDir)
        let isDirectory = isDir.boolValue == true

        return existFile && isDirectory
    }

    func testFilesCreation_MFS0030() throws {

        // WHEN Creating a MFS
        let mfsut = MediaFileSystem()

        // THEN the demo files shold be created on the
        let unmanagedFiles = mfsut.unmanagedFiles()
        XCTAssert(unmanagedFiles.count == 3)
        let managedFiles = mfsut.managedFiles()
        XCTAssert(managedFiles.count == 0)
    }

    func testFolderCreation_MFS0010_MFS0020() throws {

        // WHEN Creating a MFS
        _ = MediaFileSystem()

        // THEN the folders for inbox, managed and archive shold be created
        let baseFolderURL = baseFolderURL()

        let inboxFolderULR = baseFolderURL.appendingPathComponent(Constants.inboxFolderName)
        XCTAssert(existDirectory(url: inboxFolderULR))
        let managedFolderULR = baseFolderURL.appendingPathComponent(Constants.managedFolderName)
        XCTAssert(existDirectory(url: managedFolderULR))
        let archivedFolderULR = baseFolderURL.appendingPathComponent(Constants.archivedFolderName)
        XCTAssert(existDirectory(url: archivedFolderULR))
        let discardedFolderULR = baseFolderURL.appendingPathComponent(Constants.discardedFolderName)
        XCTAssert(existDirectory(url: discardedFolderULR))
    }
}
