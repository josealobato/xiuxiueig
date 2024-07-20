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
        static let rejectedFolderName: String = "Rejected"
    }

    func deleteAllBeforeTest() {

        let fileMng = FileManager.default
        // swiftlint:disable:next force_try
        let docsURL = try! fileMng.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        )

        let inboxFolderULR = docsURL.appendingPathComponent(Constants.inboxFolderName)
        try? fileMng.removeItem(at: inboxFolderULR)
        let managedFolderULR = docsURL.appendingPathComponent(Constants.managedFolderName)
        try? fileMng.removeItem(at: managedFolderULR)
        let archivedFolderULR = docsURL.appendingPathComponent(Constants.archivedFolderName)
        try? fileMng.removeItem(at: archivedFolderULR)
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
        let fileMng = FileManager.default
        // swiftlint:disable:next force_try
        let docsURL = try! fileMng.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        )

        let inboxFolderULR = docsURL.appendingPathComponent(Constants.inboxFolderName)
        XCTAssert(existDirectory(url: inboxFolderULR))
        let managedFolderULR = docsURL.appendingPathComponent(Constants.managedFolderName)
        XCTAssert(existDirectory(url: managedFolderULR))
        let archivedFolderULR = docsURL.appendingPathComponent(Constants.archivedFolderName)
        XCTAssert(existDirectory(url: archivedFolderULR))
    }
}
