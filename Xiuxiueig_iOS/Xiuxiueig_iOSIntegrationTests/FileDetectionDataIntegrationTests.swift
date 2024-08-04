// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import XCTest
import MediaConsistencyService

// swiftlint:disable:next blanket_disable_command
// swiftlint:disable force_try

import XRepositories

// Imported as testable to not use the shared instance.
@testable import MediaFileSystem

final class FileDetectionDataIntegrationTests: XCTestCase {

    var mfs: MediaFileSystemInteface!
    var mcs: MediaConsistencyServiceInterface!
    var repo: LectureRepositoryInteface!

    override func setUpWithError() throws {
        deleteAllBeforeTest()
        sleep(2)

        mfs = MediaFileSystem() // Notice that not using the shared.
        repo = try! LectureRepositoryBuilder.buildInMemory()
        mcs = MediaConsistencyServiceBuilder.build(
            fileSystem: mfs,
            repository: repo)
    }

    override func tearDownWithError() throws {
        deleteAllBeforeTest()
        sleep(2)
    }

    func testInitialCleanState() async throws {
        // GIVEN that the stack is setup
        // WHEN the MCS runs
        mcs.process(systemEvent: .willEnterForeground)
        sleep(1) // Wait for the process to finish.
        // THEN we should have 3 lectures from the three demo files.
        let entities = try! await repo.lectures()
        XCTAssert(entities.count == 3)
        // AND all are new
        for entity in entities {
            XCTAssert(entity.state == .new)
        }
        // AND folders match
        assertNumberOfFiles(inbox: 3, managed: 0, archived: 0, discarded: 0)
    }

    func testAddingANew() async throws {
        // GIVEN that the stack is set up
        // AND the MCS runs
        mcs.process(systemEvent: .willEnterForeground)
        sleep(1) // Wait for the process to finish.

        // WHEN we add another file and run it again
        addAFile()
        mcs.process(systemEvent: .willEnterForeground)
        sleep(1) // Wait for the process to finish.

        // THEN we should have 3 lectures from the three demo files.
        let entities = try! await repo.lectures()
        XCTAssert(entities.count == 4)
        // AND all are new
        for entity in entities {
            XCTAssert(entity.state == .new)
        }
        // AND folders match
        assertNumberOfFiles(inbox: 4, managed: 0, archived: 0, discarded: 0)

        // WHEN running MCS a second time
        mcs.process(systemEvent: .willEnterForeground)
        sleep(1) // Wait for the process to finish.

        // THEN it will not alter the state in any way
        let entitiesAfterSecondRun = try! await repo.lectures()
        XCTAssert(entitiesAfterSecondRun.count == 4)
        // AND all are new
        for entity in entitiesAfterSecondRun {
            XCTAssert(entity.state == .new)
        }
        // AND folders match
        assertNumberOfFiles(inbox: 4, managed: 0, archived: 0, discarded: 0)
    }

    // MARK: - Supporting methods

    enum Constants {
        static let managedFolderName: String = "Managed"
        static let inboxFolderName: String = "Inbox"
        static let archivedFolderName: String = "Archived"
        static let discardedFolderName: String = "Discarded"
    }

    func deleteAllBeforeTest() {

        let fileMng = FileManager.default
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

    func addAFile() {

        duplicateFile(
            fileName: "Inbox/1-Introduction to Ratpenat 1.mp3",
            newFileName: "Inbox/copy-\(generateRandomString(length: 4)).mp3")
    }

    func generateRandomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map { _ in letters.randomElement()! })
    }

    func duplicateFile(fileName: String, newFileName: String) {
        let fileManager = FileManager.default
        // Get the URL for the document directory
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Could not find the documents directory.")
            return
        }
        // Create the source file URL
        let sourceURL = documentsDirectory.appendingPathComponent(fileName)
        // Create the destination file URL
        let destinationURL = documentsDirectory.appendingPathComponent(newFileName)

        do {
            // Copy the file from the source URL to the destination URL
            try fileManager.copyItem(at: sourceURL, to: destinationURL)
            print("File copied successfully.")
        } catch {
            print("Failed to copy file: \(error.localizedDescription)")
        }
    }

    /// This method help me test the content of the folders on every test.
    func assertNumberOfFiles(inbox: Int, managed: Int, archived: Int, discarded: Int) {
        let unmanagedFiles = mfs.unmanagedFiles()
        XCTAssert(unmanagedFiles.count == inbox)
        let managedFiles = mfs.managedFiles()
        XCTAssert(managedFiles.count == managed)
        let archivedFiles = mfs.archivedFiles()
        XCTAssert(archivedFiles.count == archived)
        let discardedFiles = mfs.discardedFiles()
        XCTAssert(discardedFiles.count == discarded)
    }
}
