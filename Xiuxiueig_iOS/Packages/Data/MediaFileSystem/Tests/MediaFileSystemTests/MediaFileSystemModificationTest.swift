// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import XCTest
@testable import MediaFileSystem

final class MediaFileSystemModificationTest: XCTestCase {

    var mfsut: MediaFileSystem!

    override func setUpWithError() throws {
        deleteAllBeforeTest()
        mfsut = MediaFileSystem()

        // Asses Initial State
        let unmanagedFiles = mfsut.unmanagedFiles()
        XCTAssert(unmanagedFiles.count == 3)
        let managedFiles = mfsut.managedFiles()
        XCTAssert(managedFiles.count == 0)
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

    // MARK: - Modify a new file will modify the file but it will still be new (no id).
    //         Do not do this!

    func testModifyANewFile() {

        let unmanagedFiles = mfsut.unmanagedFiles()
        var aFile = unmanagedFiles.first!
        aFile.id = "123"
        aFile.name = "The name of the file"
        let updatedFile = mfsut.updateFile(file: aFile)
        XCTAssertNotNil(updatedFile)
        XCTAssertEqual(updatedFile?.fileName, "123-The name of the file.mp3")

        // everything still the same
        let unmanagedFilesAfterModify = mfsut.unmanagedFiles()
        XCTAssert(unmanagedFilesAfterModify.count == 3)
        let managedFilesAfterModify = mfsut.managedFiles()
        XCTAssert(managedFilesAfterModify.count == 0)
    }

    func testManageAFile_MFS0040() {
        let unmanagedFiles = mfsut.unmanagedFiles()
        var aFile = unmanagedFiles.first!
        aFile.id = "124"
        aFile.name = "The name of the file"
        let managedFile = mfsut.manageFile(file: aFile)
        XCTAssertNotNil(managedFile)
        XCTAssertEqual(managedFile?.fileName, "124-The name of the file.mp3")

        // check state after managed
        let unmanagedFilesAfterManaged = mfsut.unmanagedFiles()
        XCTAssert(unmanagedFilesAfterManaged.count == 2)
        let managedFilesAfterManaged = mfsut.managedFiles()
        XCTAssert(managedFilesAfterManaged.count == 1)
    }

    func testArchiveAFile_MFS0050() {
        // First lets manage it.
        let unmanagedFiles = mfsut.unmanagedFiles()
        var aFile = unmanagedFiles.first!
        aFile.id = "124"
        aFile.name = "The name of the file"
        let managedFile = mfsut.manageFile(file: aFile)
        XCTAssertNotNil(managedFile)
        XCTAssertEqual(managedFile?.fileName, "124-The name of the file.mp3")

        // Now let's archive it.
        _ = mfsut.archiveFile(file: managedFile!)

        // check state after managed
        let unmanagedFilesAfterManaged = mfsut.unmanagedFiles()
        XCTAssert(unmanagedFilesAfterManaged.count == 2)
        let managedFilesAfterManaged = mfsut.managedFiles()
        XCTAssert(managedFilesAfterManaged.count == 0)

    }

    func testDeleteANewFile_MFS0070() {
        let unmanagedFiles = mfsut.unmanagedFiles()
        let aFile = unmanagedFiles.first!

        // delete it.
        mfsut.deleteFile(file: aFile)

        // check state after managed
        let unmanagedFilesAfter = mfsut.unmanagedFiles()
        XCTAssert(unmanagedFilesAfter.count == 2)
        let managedFiles = mfsut.managedFiles()
        XCTAssert(managedFiles.count == 0)
    }

    func testDeleteAManagedFile_MFS0070() {

        // First lets manage it.
        let unmanagedFiles = mfsut.unmanagedFiles()
        var aFile = unmanagedFiles.first!
        aFile.id = "124"
        aFile.name = "The name of the file"
        let managedFile = mfsut.manageFile(file: aFile)
        XCTAssertNotNil(managedFile)
        XCTAssertEqual(managedFile?.fileName, "124-The name of the file.mp3")

        // Now let's archive it.
        mfsut.deleteFile(file: managedFile!)

        // check state after managed
        let unmanagedFilesAfterManaged = mfsut.unmanagedFiles()
        XCTAssert(unmanagedFilesAfterManaged.count == 2)
        let managedFilesAfterManaged = mfsut.managedFiles()
        XCTAssert(managedFilesAfterManaged.count == 0)
    }
}
