import XCTest
import XRepositories

@testable import MediaConsistencyService
// By desing ONLY the MediaFileSystem can create MediaFiles. I use testable here
// to be able to create them for testing purposes.
@testable import MediaFileSystem

final class MCSNewConsistencyTest: XCTestCase {

    var mcs: MediaConsistencyServiceInterface!
    var fileSystemMock: MediaFileSystemIntefaceMock!
    var repoMock: LectureRepositoryIntefaceMock!

    override func setUp() {
        super.setUp()
        fileSystemMock = MediaFileSystemIntefaceMock()
        repoMock = LectureRepositoryIntefaceMock()
        mcs = MediaConsistencyServiceBuilder.build(fileSystem: fileSystemMock, repository: repoMock)

        // Set up the mocks for other actions that the MCS does not related to new files
        fileSystemMock.managedFilesReturnValue = []
        fileSystemMock.archivedFilesReturnValue = []
        repoMock.lectureWithIdReturnValue = nil
    }

    override func tearDown() {
        mcs = nil
        super.tearDown()
    }

    // MARK: - New File consistency

    func testNewFileDetection_MCS0210() throws {
        // GIVEN there is a new file
        fileSystemMock.unmanagedFilesReturnValue = [aNewFile]
        // and it is not in the repository
        repoMock.lecturesReturnValue = []

        // It is expected that the new file is added to the repository with state new
        // and the name of the file.
        let expectation = expectation(description: "new file detected")
        repoMock.addLectureClosure = { addedLecture in
            XCTAssert(addedLecture.state == .new)
            XCTAssertEqual(addedLecture.title, "this is a sample file name")
            expectation.fulfill()
        }

        // WHEN we run the MCS
        mcs.willEnterForeground()

        // THEN (see expectation above)
        wait(for: [expectation], timeout: 2.0)
    }

    func testNewFileDetectionOfAlreadySeenFile_MCS0210() throws {
        // GIVEN there is a new file
        fileSystemMock.unmanagedFilesReturnValue = [aNewFile]
        // and it is is already in the repository
        repoMock.lecturesReturnValue = [aNewFileMatchingEntity]

        // It is expected that no new file is added to the repository.
        repoMock.addLectureClosure = { _ in
            XCTFail("No lecture should be added")
        }

        // WHEN we run the MCS
        mcs.willEnterForeground()

        // THEN (see expectation above)
        wait(for: [], timeout: 0.5)
    }

    // MARK: - New Entity consistency

    func testNewRepoEntityWithoutMatchingFile_MCS0510() throws {
        // GIVEN there is a new entity in the repo
        let entity = aNewFileMatchingEntity
        repoMock.lecturesReturnValue = [entity]
        // WITHOUT a matching file
        fileSystemMock.unmanagedFilesReturnValue = []

        // It is expected the lecture to be deleted.
        let expectation = expectation(description: "entity is deleted")
        repoMock.deleteLectureWithIdClosure = { uuid in
            XCTAssert(uuid == entity.id)
            expectation.fulfill()
        }

        // WHEN we run the MCS
        mcs.willEnterForeground()

        // THEN (see expectation above)
        wait(for: [expectation], timeout: 0.5)
    }

    func testNewRepoEntityWithMatchingFile_MCS0510() throws {
        // GIVEN there is a new entity in the repo
        let entity = aNewFileMatchingEntity
        repoMock.lecturesReturnValue = [entity]
        // WITH a matching file
        fileSystemMock.unmanagedFilesReturnValue = [aNewFile]

        // It is expected that no new file is added to the repository.
        repoMock.deleteLectureWithIdClosure = { _ in
            XCTFail("No lecture should be deleted")
        }
        // WHEN we run the MCS
        mcs.willEnterForeground()

        // THEN (see expectation above)
        wait(for: [], timeout: 0.5)
    }

    // MARK: - Support Methods

    // MARK: - Test Data

    var aNewFile: MediaFile {
        let url = URL(string: "file:///Users/ana.maria/this%20is%20a%20sample%20file%20name.mp3")!
        return MediaFile(url: url, isNew: true)!
    }

    var aNewFileMatchingEntity: LectureDataEntity {
        let url = URL(string: "file:///Users/ana.maria/this%20is%20a%20sample%20file%20name.mp3")!
        return LectureDataEntity(id: UUID(), title: "this is a sample file name", mediaURL: url)
    }
}
