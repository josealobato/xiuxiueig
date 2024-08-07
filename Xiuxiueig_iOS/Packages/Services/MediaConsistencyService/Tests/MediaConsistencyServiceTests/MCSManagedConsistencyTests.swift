// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import XCTest
import XRepositories
import XToolKit

@testable import MediaConsistencyService
// By desing ONLY the MediaFileSystem can create MediaFiles. I use testable here
// to be able to create them for testing purposes.
@testable import MediaFileSystem

final class MCSManagedConsistencyTests: XCTestCase {

    var mcs: MediaConsistencyServiceInterface!
    var fileSystemMock: MediaFileSystemIntefaceMock!
    var repoMock: LectureRepositoryIntefaceMock!

    let documentBaseURL: URL = URL(string: "file:///user/document/")!

    override func setUp() {
        super.setUp()
        fileSystemMock = MediaFileSystemIntefaceMock()
        repoMock = LectureRepositoryIntefaceMock()
        mcs = MediaConsistencyServiceBuilder.build(fileSystem: fileSystemMock, repository: repoMock)

        // set up the mocks for other actions that the MCS does not related to managed files
        fileSystemMock.unmanagedFilesReturnValue = []
        fileSystemMock.archivedFilesReturnValue = []
        repoMock.lecturesReturnValue = []

        MediaFile.baseURL = { self.documentBaseURL }
    }

    override func tearDown() {
        mcs = nil
        super.tearDown()
    }

    // MARK: - Managed File consistency

    func testManagedFileConsistencySuccess_MCS0220() throws {
        // GIVEN there is a managed file
        fileSystemMock.managedFilesReturnValue = [aManagedFile]
        // and it is also in the repository
        repoMock.lectureWithIdReturnValue = aManagedFileMatchingEntity

        // Nothing should happen
        fileSystemMock.discardFileFileClosure = { _ in
            XCTFail("No lecture should be deleted")
            return nil
        }

        // WHEN we run the MCS
        mcs.process(systemEvent: .willEnterForeground)

        // THEN (see expectation above)
        wait(for: [], timeout: 1.0)
    }

    func testManagedFileConsistencyFail_MCS0230() throws {
        // GIVEN there is a managed file
        let managedFile = aManagedFile
        fileSystemMock.managedFilesReturnValue = [managedFile]
        // and it is not in the repository
        repoMock.lecturesReturnValue = []

        // The file should be discarded
        let expectation = expectation(description: "Managed file discarded")
        fileSystemMock.discardFileFileClosure = { discardedFile in
            XCTAssertEqual(discardedFile.id, managedFile.id)
            expectation.fulfill()
            return discardedFile
        }

        // WHEN we run the MCS
        mcs.process(systemEvent: .willEnterForeground)

        // THEN (see expectation above)
        wait(for: [expectation], timeout: 1.0)
    }

    // MARK: - Managed Entities consistency

    func testManagedEntityConsistencySuccess_MCS0520() throws {
        // GIVEN there is a managed entity
        let managedEntity = aManagedFileMatchingEntity
        repoMock.lectureWithIdReturnValue = managedEntity
        // and it is also in the file system
        fileSystemMock.managedFilesReturnValue = [aManagedFile]

        // The entity won't be removed
        repoMock.deleteLectureWithIdClosure = { _ in
            XCTFail("No lecture should be deleted")
        }

        // WHEN we run the MCS
        mcs.process(systemEvent: .willEnterForeground)

        // THEN (see expectation above)
        wait(for: [], timeout: 1.0)
    }

    func testManagedEntityConsistencyFail_MCS0520() throws {
        // GIVEN there is a managed entity
        let managedEntity = aManagedFileMatchingEntity
        repoMock.lecturesReturnValue = [managedEntity]
        // and it is NOT in the file system
        fileSystemMock.managedFilesReturnValue = []

        // The entity will be delted
        let expectation = expectation(description: "Managed entity deleted")
        repoMock.deleteLectureWithIdClosure = { uuid in
            XCTAssertEqual(uuid, managedEntity.id)
            expectation.fulfill()
        }

        // WHEN we run the MCS
        mcs.process(systemEvent: .willEnterForeground)

        // THEN (see expectation above)
        wait(for: [expectation], timeout: 1.0)
    }

    // MARK: - Support Methods

    // MARK: - Test Data

    var aManagedFile: MediaFile {
        let uuid = uuidString("0")
        let url = URL(string: "\(documentBaseURL)Managed/\(uuid)-this%20is%20a%20sample%20file%20name.mp3")!
        return MediaFile(url: url, isNew: false)!
    }

    var aManagedFileMatchingEntity: LectureDataEntity {
        let uuid = uuidString("0")
        let urlComponents = URLComponents(string: "Managed/\(uuid)-this%20is%20a%20sample%20file%20name.mp3")!
        var entity = LectureDataEntity(id: UUID(), title: "this is a sample file name", mediaTailURL: urlComponents)
        entity.state = .managed
        return entity
    }
}
