// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import XCTest
import XRepositories
import XToolKit

@testable import MediaConsistencyService
// By desing ONLY the MediaFileSystem can create MediaFiles. I use testable here
// to be able to create them for testing purposes.
@testable import MediaFileSystem

final class MCSArchivedConsistencyTests: XCTestCase {

    var mcs: MediaConsistencyServiceInterface!
    var fileSystemMock: MediaFileSystemIntefaceMock!
    var repoMock: LectureRepositoryIntefaceMock!

    override func setUp() {
        super.setUp()
        fileSystemMock = MediaFileSystemIntefaceMock()
        repoMock = LectureRepositoryIntefaceMock()
        mcs = MediaConsistencyServiceBuilder.build(fileSystem: fileSystemMock, repository: repoMock)

        // Set up the mocks for other actions that the MCS does not related to managed files
        fileSystemMock.unmanagedFilesReturnValue = []
        fileSystemMock.managedFilesReturnValue = []
        repoMock.lecturesReturnValue = []

    }

    override func tearDown() {
        mcs = nil
        super.tearDown()
    }

    // MARK: - Archived File consistency

    func testArchivedFileConsistencySuccess_MCS0240() throws {
        // GIVEN there is a archived file
        fileSystemMock.archivedFilesReturnValue = [aArchivedFile]
        // and it is also in the repository
        repoMock.lectureWithIdReturnValue = aArchivedFileMatchingEntity

        // It is expected no file action to happen
        fileSystemMock.discardFileFileClosure = { _ in
            XCTFail("No lecture should be deleted")
            return nil
        }

        // WHEN we run the MCS
        mcs.process(systemEvent: .willEnterForeground)

        // THEN (see expectation above)
        wait(for: [], timeout: 1.0)
    }

    func testArchivedFileConsistencyFail_MCS0250() throws {
        // GIVEN there is a archived file
        let archivedFile = aArchivedFile
        fileSystemMock.archivedFilesReturnValue = [archivedFile]
        // and it is not in the repository
        repoMock.lecturesReturnValue = []

        // It is expected that the archived file is discarded.
        let expectation = expectation(description: "archived file discarded")
        fileSystemMock.discardFileFileClosure = { discardedFile in
            XCTAssertEqual(discardedFile.id, archivedFile.id)
            expectation.fulfill()
            return discardedFile
        }

        // WHEN we run the MCS
        mcs.process(systemEvent: .willEnterForeground)

        // THEN (see expectation above)
        wait(for: [expectation], timeout: 1.0)
    }

    // MARK: - Archived Entities consistency

    func testArchivedEntityConsistencySuccess_MCS0530() throws {
        // GIVEN there is a archived entity
        repoMock.lectureWithIdReturnValue = aArchivedFileMatchingEntity
        // and it is also in the file system
        fileSystemMock.archivedFilesReturnValue = [aArchivedFile]

        // No action will be taken
        repoMock.deleteLectureWithIdClosure = { _ in
            XCTFail("No lecture should be deleted")
        }

        // WHEN we run the MCS
        mcs.process(systemEvent: .willEnterForeground)

        // THEN (see expectation above)
        wait(for: [], timeout: 1.0)
    }

    func testArchivedEntityConsistencyFail_MCS0530() throws {
        // GIVEN there is a archived entity
        let entity = aArchivedFileMatchingEntity
        repoMock.lecturesReturnValue = [entity]
        // and it is also in the file system
        fileSystemMock.archivedFilesReturnValue = []

        // No action will be taken
        let expectation = expectation(description: "Entity will be deleted")
        repoMock.deleteLectureWithIdClosure = { uuid in
            XCTAssertEqual(uuid, entity.id)
            expectation.fulfill()
        }

        // WHEN we run the MCS
        mcs.process(systemEvent: .willEnterForeground)

        // THEN (see expectation above)
        wait(for: [expectation], timeout: 1.0)
    }

    // MARK: - Support Methods

    // MARK: - Test Data

    var aArchivedFile: MediaFile {
        let uuid = uuidString("0")
        let url = URL(string: "file:///Users/ana.maria/\(uuid)-this%20is%20a%20sample%20file%20name.mp3")!
        return MediaFile(url: url, isNew: false)!
    }

    var aArchivedFileMatchingEntity: LectureDataEntity {
        let uuid = uuidString("0")
        let url = URL(string: "file:///Users/ana.maria/\(uuid)-this%20is%20a%20sample%20file%20name.mp3")!
        var entity = LectureDataEntity(id: UUID(), title: "this is a sample file name", mediaURL: url)
        entity.state = .archived
        return entity
    }
}
