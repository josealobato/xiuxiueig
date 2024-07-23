// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import XCTest
import XToolKit
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
        static let discardedFolderName: String = "Discarded"
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
        let discardedFolderULR = docsURL.appendingPathComponent(Constants.discardedFolderName)
        try? fileMng.removeItem(at: discardedFolderULR)
    }

    /// This method help me test the content of the folders on every test.
    func assertNumberOfFiles(inbox: Int, managed: Int, archived: Int, discarded: Int) {
        let unmanagedFiles = mfsut.unmanagedFiles()
        XCTAssert(unmanagedFiles.count == inbox)
        let managedFiles = mfsut.managedFiles()
        XCTAssert(managedFiles.count == managed)
        let archivedFiles = mfsut.archivedFiles()
        XCTAssert(archivedFiles.count == archived)
        let discardedFiles = mfsut.discardedFiles()
        XCTAssert(discardedFiles.count == discarded)
    }

    // MARK: - Modify a new file will modify the file but it will still be new (no id).
    //         Do not do this!

    func testModifyANewFile() {

        let unmanagedFiles = mfsut.unmanagedFiles()
        var aFile = unmanagedFiles.first!
        aFile.id = uuidString("1")
        aFile.name = "The name of the file"
        let updatedFile = mfsut.updateFile(file: aFile)
        XCTAssertNotNil(updatedFile)
        XCTAssertEqual(updatedFile?.fileName, "The name of the file.mp3")

        // everything still the same
        assertNumberOfFiles(inbox: 3, managed: 0, archived: 0, discarded: 0)
    }

    func testManageAFile_MFS0040() {
        let unmanagedFiles = mfsut.unmanagedFiles()
        var aFile = unmanagedFiles.first!
        aFile.id = uuidString("1")
        aFile.name = "The name of the file"
        let managedFile = mfsut.manageFile(file: aFile)
        XCTAssertNotNil(managedFile)
        XCTAssertEqual(managedFile?.fileName, "\(uuidString("1"))-The name of the file.mp3")

        // check state after managed
        assertNumberOfFiles(inbox: 2, managed: 1, archived: 0, discarded: 0)
    }

    func testArchiveAFile_MFS0050() {
        // First lets manage it.
        let unmanagedFiles = mfsut.unmanagedFiles()
        var aFile = unmanagedFiles.first!
        aFile.id = uuidString("1")
        aFile.name = "The name of the file"
        let managedFile = mfsut.manageFile(file: aFile)
        XCTAssertNotNil(managedFile)
        XCTAssertEqual(managedFile?.fileName, "\(uuidString("1"))-The name of the file.mp3")

        // Now let's archive it.
        _ = mfsut.archiveFile(file: managedFile!)

        // check state after managed
        assertNumberOfFiles(inbox: 2, managed: 0, archived: 1, discarded: 0)
    }

    func testDiscardANewFile_MFS0080() {
        // First lets manage it.
        let unmanagedFiles = mfsut.unmanagedFiles()

        // Now let's discard it.
        _ = mfsut.discardFile(file: unmanagedFiles.first!)

        // check state after managed
        assertNumberOfFiles(inbox: 2, managed: 0, archived: 0, discarded: 1)
    }

    func testDiscardAManagedFile_MFS0080_MFS0090() {
        // First lets manage it.
        let unmanagedFiles = mfsut.unmanagedFiles()
        var aFile = unmanagedFiles.first!
        aFile.id = uuidString("1")
        aFile.name = "The name of the file"
        let managedFile = mfsut.manageFile(file: aFile)
        XCTAssertNotNil(managedFile)
        XCTAssertEqual(managedFile?.fileName, "\(uuidString("1"))-The name of the file.mp3")

        // Now let's discard it.
        let discardedFile = mfsut.discardFile(file: managedFile!)

        // check state after managed
        assertNumberOfFiles(inbox: 2, managed: 0, archived: 0, discarded: 1)
        // MFS0090
        XCTAssert(discardedFile!.isNew)
    }

    func testDeleteANewFile_MFS0070() {
        let unmanagedFiles = mfsut.unmanagedFiles()
        let aFile = unmanagedFiles.first!

        // delete it.
        mfsut.deleteFile(file: aFile)

        // check state after managed
        assertNumberOfFiles(inbox: 2, managed: 0, archived: 0, discarded: 0)
    }

    func testDeleteAManagedFile_MFS0070() {

        // First lets manage it.
        let unmanagedFiles = mfsut.unmanagedFiles()
        var aFile = unmanagedFiles.first!
        aFile.id = uuidString("1")
        aFile.name = "The name of the file"
        let managedFile = mfsut.manageFile(file: aFile)
        XCTAssertNotNil(managedFile)
        XCTAssertEqual(managedFile?.fileName, "\(uuidString("1"))-The name of the file.mp3")

        // Now let's archive it.
        mfsut.deleteFile(file: managedFile!)

        // check state after managed
        assertNumberOfFiles(inbox: 2, managed: 0, archived: 0, discarded: 0)
    }
}
