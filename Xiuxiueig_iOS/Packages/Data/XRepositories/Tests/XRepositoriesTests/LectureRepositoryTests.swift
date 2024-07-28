import XCTest
@testable import XRepositories

final class XRepositoriesTests: XCTestCase {

    var lectureRepo: LectureRepositoryInteface!

    override func setUp() async throws {
        try await super.setUp()

        lectureRepo = try LectureRepositoryBuilder.buildInMemory(autopersist: true)
    }

    func testLectureAddAndDeleteFlow_REP0110_REP0120_REP0130() async throws {
        // GIVEN a Lecture data entity
        let uuid = UUID()
        let title = "This is a test title"
        let url = URL(string: "file://This/is/a/test/url.mp3")!
        let initialLecture = LectureDataEntity(id: uuid, title: title, mediaURL: url)

        // WHEN adding a lecture
        try await lectureRepo.add(lecture: initialLecture)

        // THEN then we can retrive that lecture.
        if let retrievedLecture = try await lectureRepo.lecture(withId: uuid) {
            XCTAssertEqual(retrievedLecture.id, uuid)
        } else {
            XCTFail("There should be a lecture to retrieve")
        }

        // WHEN deleting that lecture
        try await lectureRepo.deleteLecture(withId: uuid)

        // THEN there should be no lecture
        let lectures = try await lectureRepo.lectures()
        XCTAssert(lectures.count == 0)
        // even when retrieved with id.
        if try await lectureRepo.lecture(withId: uuid) != nil {
            XCTFail("There should be NO lecture to retrieve")
        }
    }

    func testLectureUpdateFlow_REP0150() async throws {
        // GIVEN a Lecture is already in the repo
        let uuid = UUID()
        let title = "This is a test title"
        let url = URL(string: "file://This/is/a/test/url.mp3")!
        var initialLecture = LectureDataEntity(id: uuid, title: title, mediaURL: url)
        try await lectureRepo.add(lecture: initialLecture)

        // THEN then we can retrive that lecture.
        if let retrievedLecture = try await lectureRepo.lecture(withId: uuid) {
            XCTAssertEqual(retrievedLecture.id, uuid)
        } else {
            XCTFail("There should be a lecture to retrieve")
        }

        // WHEN updating the lecture with new data and update it
        initialLecture.title = "Modified Title"
        initialLecture.state = .managed
        try await lectureRepo.update(lecture: initialLecture)

        // THEN then we can retrive the lecture and check the data
        if let retrievedLecture = try await lectureRepo.lecture(withId: uuid) {
            XCTAssertEqual(retrievedLecture.id, uuid)
            XCTAssertEqual(retrievedLecture.title, "Modified Title")
            XCTAssertEqual(retrievedLecture.state, .managed)
        } else {
            XCTFail("There should be a lecture to retrieve")
        }
    }
}
