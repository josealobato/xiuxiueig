// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import XCTest
import MediaConsistencyService

// Make testable to create a MFS every time instead of using the shared.
@testable import MediaFileSystem

// swiftlint:disable:next blanket_disable_command
// swiftlint:disable force_try

import XRepositories

enum ConsistencyHandlerAdapterFakeError: Error {
    case anyError
}

final class ConsistencyHandlerAdapterFake: LectureURLConsistencyHandler {

    weak var consistencyService: MediaConsistencyServiceInterface?

    func update(entity: XRepositories.LectureDataEntity) throws -> XRepositories.LectureDataEntity {
        guard let consistencyService = self.consistencyService else {
            throw ConsistencyHandlerAdapterFakeError.anyError
        }
        return try consistencyService.update(entity: entity)
    }
}

final class ManagingEntityUpdatesIntegrationTests: XCTestCase {

    var mfs: MediaFileSystemInteface!
    var mcs: MediaConsistencyServiceInterface!
    var repo: LectureRepositoryInteface!

    override func setUpWithError() throws {
        deleteAllBeforeTest()
        sleep(2)

        let consistencyHandler = ConsistencyHandlerAdapterFake()
        mfs = MediaFileSystem()
        repo = try! LectureRepositoryBuilder.buildInMemory(
            uRLConsistencyHandler: consistencyHandler
        )
        mcs = MediaConsistencyServiceBuilder.build(
            fileSystem: mfs,
            repository: repo
        )
        consistencyHandler.consistencyService = mcs
    }

    override func tearDownWithError() throws {
        deleteAllBeforeTest()
        sleep(2)
    }

    // swiftlint:disable:next function_body_length
    func testEntityLifeCycle() async throws {
        // 1. Adding a file that creates an entity (state: new) ---------------

        // GIVEN that the stack is set up AND the MCS runs
        mcs.willEnterForeground(); sleep(1)

        // WHEN we add another file and run it again
        let initialFileName = "My new lecture file"
        addAFile(name: initialFileName)
        mcs.willEnterForeground(); sleep(1)

        // THEN we can get that file with correct state and value
        var lecture: LectureDataEntity!
        if let alecture = try await repo.lectures().first(where: { $0.title == initialFileName}) {
            XCTAssertEqual(alecture.title, initialFileName)
            XCTAssertEqual(alecture.state, .new)
            lecture = alecture
        } else { XCTFail("There should be an entity") }

        // AND the file keep having the right location and name
        XCTAssert(fileExistWith(path: Constants.inboxFolderName + "/\(initialFileName).mp3"))

        // 2. Modifying that entity (state: new) ------------------------------

        // WHEN the entity is modifed and update requested
        let secondFileName = "My modified new lecture file"
        lecture.title = secondFileName
        try await repo.update(lecture: lecture)

        // THEN the file should have been updated
        XCTAssert(fileExistWith(path: Constants.inboxFolderName + "/\(secondFileName).mp3"))

        // AND The entity has the right data with ...
        if let alecture = try await repo.lectures().first(where: { $0.title == secondFileName}) {
            XCTAssertEqual(alecture.title, secondFileName)
            XCTAssertEqual(alecture.state, .new)
            // ... UPDATED URL
            XCTAssert(
                alecture.mediaURL.path.hasSuffix(
                    Constants.inboxFolderName + "/\(secondFileName).mp3"
                )
            )
            lecture = alecture // Save the new lecture for next test.
        } else { XCTFail("There should be an entity") }

        // 3. Managing that entity (state: managed) ---------------------------

        // When managing a lecture
        lecture.state = .managed
        try await repo.update(lecture: lecture)

        // THEN the file should have moved to managed folder and updated with the id
        XCTAssert(fileExistWith(path: Constants.managedFolderName + "/\(lecture.id.uuidString)-\(lecture.title).mp3"))

        // AND The entity is managed and ...
        if let alecture = try await repo.lecture(withId: lecture.id) {
            XCTAssertEqual(alecture.state, .managed)
            // ... UPDATED URL with new folder location.
            XCTAssert(
                alecture.mediaURL.path.hasSuffix(
                    Constants.managedFolderName + "/\(lecture.id.uuidString)-\(secondFileName).mp3"
                )
            )
            lecture = alecture // Save the new lecture for next test.
        } else { XCTFail("There should be an entity") }

        // 4. Modifying that managed entity (state: managed) --------------------------

        // WHEN the entity is modifed and update requested
        let thirdFileName = "My modified managed lecture file"
        lecture.title = thirdFileName
        try await repo.update(lecture: lecture)

        // THEN the file should have been updated
        XCTAssert(fileExistWith(path: Constants.managedFolderName + "/\(lecture.id.uuidString)-\(thirdFileName).mp3"))

        // AND The entity has the right data with ...
        if let alecture = try await repo.lectures().first(where: { $0.title == thirdFileName}) {
            XCTAssertEqual(alecture.title, thirdFileName)
            XCTAssertEqual(alecture.state, .managed)
            // ... UPDATED URL
            XCTAssert(
                alecture.mediaURL.path.hasSuffix(
                    Constants.managedFolderName + "/\(lecture.id.uuidString)-\(thirdFileName).mp3"
                )
            )
            lecture = alecture // Save the new lecture for next test.
        } else { XCTFail("There should be an entity") }

        // 5. Archiving that managed entity (state: Archive) --------------------------

        // When managing a lecture
        lecture.state = .archived
        try await repo.update(lecture: lecture)

        // THEN the file should have moved to managed folder and updated with the id
        XCTAssert(fileExistWith(path: Constants.archivedFolderName + "/\(lecture.id.uuidString)-\(lecture.title).mp3"))

        // AND The entity is managed and ...
        if let alecture = try await repo.lecture(withId: lecture.id) {
            XCTAssertEqual(alecture.state, .archived)
            // ... UPDATED URL with new folder location.
            XCTAssert(
                alecture.mediaURL.path.hasSuffix(
                    Constants.archivedFolderName + "/\(lecture.id.uuidString)-\(lecture.title).mp3"
                )
            )
            lecture = alecture
        } else { XCTFail("There should be an entity") }
    }

    // WARNING, this is exactly the same test as before but we insert a `willEnterForeground`
    // on every action to make sure that all is OK if there is extra consistency runs.
    // swiftlint:disable:next function_body_length
    func testEntityLifeCycleWithExtraRunOnEnterForegrownd() async throws {
        // 1. Adding a file that creates an entity (state: new) ---------------

        // GIVEN that the stack is set up AND the MCS runs
        mcs.willEnterForeground(); sleep(1)

        // WHEN we add another file and run it again
        let initialFileName = "My new lecture file"
        addAFile(name: initialFileName)
        mcs.willEnterForeground(); sleep(1)

        // THEN we can get that file with correct state and value
        var lecture: LectureDataEntity!
        if let alecture = try await repo.lectures().first(where: { $0.title == initialFileName}) {
            XCTAssertEqual(alecture.title, initialFileName)
            XCTAssertEqual(alecture.state, .new)
            lecture = alecture
        } else { XCTFail("There should be an entity") }

        // AND the file keep having the right location and name
        XCTAssert(fileExistWith(path: Constants.inboxFolderName + "/\(initialFileName).mp3"))

        // EXTRA RUN of Consistency
        sleep(1); mcs.willEnterForeground(); sleep(1)
        assertNumberOfFiles(inbox: 4, managed: 0, archived: 0, discarded: 0)

        // 2. Modifying that entity (state: new) ------------------------------

        // WHEN the entity is modifed and update requested
        let secondFileName = "My modified new lecture file"
        lecture.title = secondFileName
        try await repo.update(lecture: lecture)

        // THEN the file should have been updated
        XCTAssert(fileExistWith(path: Constants.inboxFolderName + "/\(secondFileName).mp3"))

        // AND The entity has the right data with ...
        if let alecture = try await repo.lectures().first(where: { $0.title == secondFileName}) {
            XCTAssertEqual(alecture.title, secondFileName)
            XCTAssertEqual(alecture.state, .new)
            // ... UPDATED URL
            XCTAssert(
                alecture.mediaURL.path.hasSuffix(
                    Constants.inboxFolderName + "/\(secondFileName).mp3"
                )
            )
            lecture = alecture // Save the new lecture for next test.
        } else { XCTFail("There should be an entity") }

        // EXTRA RUN of Consistency
        sleep(1); mcs.willEnterForeground(); sleep(1)
        assertNumberOfFiles(inbox: 4, managed: 0, archived: 0, discarded: 0)

        // 3. Managing that entity (state: managed) ---------------------------

        // When managing a lecture
        lecture.state = .managed
        try await repo.update(lecture: lecture)

        // THEN the file should have moved to managed folder and updated with the id
        XCTAssert(fileExistWith(path: Constants.managedFolderName + "/\(lecture.id.uuidString)-\(lecture.title).mp3"))

        // AND The entity is managed and ...
        if let alecture = try await repo.lecture(withId: lecture.id) {
            XCTAssertEqual(alecture.state, .managed)
            // ... UPDATED URL with new folder location.
            XCTAssert(
                alecture.mediaURL.path.hasSuffix(
                    Constants.managedFolderName + "/\(lecture.id.uuidString)-\(secondFileName).mp3"
                )
            )
            lecture = alecture // Save the new lecture for next test.
        } else { XCTFail("There should be an entity") }

        // EXTRA RUN of Consistency
        sleep(1); mcs.willEnterForeground(); sleep(1)
        assertNumberOfFiles(inbox: 3, managed: 1, archived: 0, discarded: 0)

        // 4. Modifying that managed entity (state: managed) --------------------------

        // WHEN the entity is modifed and update requested
        let thirdFileName = "My modified managed lecture file"
        lecture.title = thirdFileName
        try await repo.update(lecture: lecture)

        // THEN the file should have been updated
        XCTAssert(fileExistWith(path: Constants.managedFolderName + "/\(lecture.id.uuidString)-\(thirdFileName).mp3"))

        // AND The entity has the right data with ...
        if let alecture = try await repo.lectures().first(where: { $0.title == thirdFileName}) {
            XCTAssertEqual(alecture.title, thirdFileName)
            XCTAssertEqual(alecture.state, .managed)
            // ... UPDATED URL
            XCTAssert(
                alecture.mediaURL.path.hasSuffix(
                    Constants.managedFolderName + "/\(lecture.id.uuidString)-\(thirdFileName).mp3"
                )
            )
            lecture = alecture // Save the new lecture for next test.
        } else { XCTFail("There should be an entity") }

        // EXTRA RUN of Consistency
        sleep(1); mcs.willEnterForeground(); sleep(1)
        assertNumberOfFiles(inbox: 3, managed: 1, archived: 0, discarded: 0)

        // 5. Archiving that managed entity (state: Archive) --------------------------

        // When managing a lecture
        lecture.state = .archived
        try await repo.update(lecture: lecture)

        // THEN the file should have moved to managed folder and updated with the id
        XCTAssert(fileExistWith(path: Constants.archivedFolderName + "/\(lecture.id.uuidString)-\(lecture.title).mp3"))

        // AND The entity is managed and ...
        if let alecture = try await repo.lecture(withId: lecture.id) {
            XCTAssertEqual(alecture.state, .archived)
            // ... UPDATED URL with new folder location.
            XCTAssert(
                alecture.mediaURL.path.hasSuffix(
                    Constants.archivedFolderName + "/\(lecture.id.uuidString)-\(lecture.title).mp3"
                )
            )
            lecture = alecture
        } else { XCTFail("There should be an entity") }

        // EXTRA RUN of Consistency
        sleep(1); mcs.willEnterForeground(); sleep(1)
        assertNumberOfFiles(inbox: 3, managed: 0, archived: 1, discarded: 0)
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

    func addAFile(name: String) {

        duplicateFile(
            fileName: "Inbox/1-Introduction to Ratpenat 1.mp3",
            newFileName: "Inbox/\(name).mp3")
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

    func fileExistWith(path: String) -> Bool {
        let fileManager = FileManager.default
        // Get the URL for the document directory
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Could not find the documents directory.")
            return false
        }

        let sourceURL = documentsDirectory.appendingPathComponent(path)
        let isValidFile = fileManager.fileExists(atPath: sourceURL.path)
        return isValidFile
    }

    private func existDirectory(url: URL) -> Bool {

        let fileMng = FileManager.default
        var isDir: ObjCBool = false

        let existFile = fileMng.fileExists(atPath: url.path, isDirectory: &isDir)
        let isDirectory = isDir.boolValue == true

        return existFile && isDirectory
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

    func assertNumberOfEntities(inbox: Int, managed: Int, archived: Int) async {
        let newEntities = (try! await repo.lectures()).filter { $0.state == .new }
        XCTAssert(newEntities.count == inbox)
        let managedEntities = (try! await repo.lectures()).filter { $0.state == .managed }
        XCTAssert(managedEntities.count == managed)
        let archivedEntities = (try! await repo.lectures()).filter { $0.state == .archived }
        XCTAssert(archivedEntities.count == archived)
    }
    // swiftlint:disable file_length
}
