// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import XCTest
import XToolKit

@testable import MediaFileSystem

final class FileByURLTests: XCTestCase {

    var mfsut: MediaFileSystem!

    override func setUpWithError() throws {
        deleteAllBeforeTest()

        mfsut = MediaFileSystem()
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

    private func existDirectory(url: URL) -> Bool {

        let fileMng = FileManager.default
        var isDir: ObjCBool = false

        let existFile = fileMng.fileExists(atPath: url.path, isDirectory: &isDir)
        let isDirectory = isDir.boolValue == true

        return existFile && isDirectory
    }

    // MARK: - Test Getting files

    func testGettingNewFileFromURL_MFS0100() {
        // GIVEN some new files
        let originalFile = mfsut.unmanagedFiles().first!

        // WHEN we get a new file from its url
        let obtainedFile = mfsut.file(from: originalFile.url)

        // Then the file is new and has valid name
        if let newFile = obtainedFile {
            XCTAssert(newFile.isNew, "The file is a new File")
            XCTAssertEqual(newFile.name, originalFile.name, "The file is a new File")
        } else {
            XCTFail("The new file should exist")
        }
    }

    func testGettingManagedFileFromURL_MFS0100() {
        // GIVEN some managed files
        // to obtain it we manage one of the existing files.
        var newFile = mfsut.unmanagedFiles().first!
        newFile.id = uuidString("0")
        let originalFile = mfsut.manageFile(file: newFile)!

        // WHEN we get a file from its url
        let obtainedFile = mfsut.file(from: originalFile.url)

        // Then the file is not new and has valid name
        if let newFile = obtainedFile {
            XCTAssertFalse(newFile.isNew, "The file is a new File")
            XCTAssertEqual(newFile.name, originalFile.name, "The file is a new File")
        } else {
            XCTFail("The new file should exist")
        }
    }

    func testGettingArchivedFileFromURL_MFS0100() {
        // GIVEN some managed files
        // to obtain it we manage one of the existing files.
        var newFile = mfsut.unmanagedFiles().first!
        newFile.id = uuidString("0")
        let originalFile = mfsut.archiveFile(file: newFile)!

        // WHEN we get a file from its url
        let obtainedFile = mfsut.file(from: originalFile.url)

        // THEN the file is not new and has valid name
        if let newFile = obtainedFile {
            XCTAssertFalse(newFile.isNew, "The file is a new File")
            XCTAssertEqual(newFile.name, originalFile.name, "The file is a new File")
        } else {
            XCTFail("The new file should exist")
        }
    }

    func testGettingNonExistintFileFromURL_MFS0100() {
        // GIVEN That we have a bogus URL
        let bogusUrl = URL(string: "file://this/is/not/valid.mp3")!

        // WHEN we get a file from its url
        let obtainedFile = mfsut.file(from: bogusUrl)

        // THEN we do not get a file
        XCTAssertNil(obtainedFile, "The file should NOT exist")
    }
}
