import XCTest
@testable import XRepositories

final class XRepositoriesTests: XCTestCase {

    var lectureRepo: LectureRepositoryInteface!
    var uRLConsistencyMock: LectureURLConsistencyHandlerMock!

    override func setUp() async throws {
        try await super.setUp()

        uRLConsistencyMock = LectureURLConsistencyHandlerMock()
        lectureRepo = try LectureRepositoryBuilder.buildInMemory(
            uRLConsistencyHandler: uRLConsistencyMock,
            autopersist: true
        )
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

        // AND if the URL consistency handler do not fail
        uRLConsistencyMock.updateEntityClosure = { lecture in
            return lecture
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

    func testLectureUpdateWithConsistecyFlow_REP0151() async throws {
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

        // AND if the URL consistency handler modify the URL
        uRLConsistencyMock.updateEntityClosure = { lecture in
            var modifiedLecture = lecture
            modifiedLecture.mediaURL = URL(string: "file://This/is/a/new/url.mp3")!
            return modifiedLecture
        }

        // WHEN modifying the lecture with new data and update it
        initialLecture.state = .managed
        try await lectureRepo.update(lecture: initialLecture)

        // THEN then we can retrive the lecture and check that URL is the modified one.
        if let retrievedLecture = try await lectureRepo.lecture(withId: uuid) {
            XCTAssertEqual(retrievedLecture.id, uuid)
            XCTAssertEqual(retrievedLecture.state, .managed)
            XCTAssertEqual(
                retrievedLecture.mediaURL.absoluteString,
                "file://This/is/a/new/url.mp3"
            )
        } else {
            XCTFail("There should be a lecture to retrieve")
        }
    }

    func testLectureUpdateWithConsistecyFail_REP0151() async throws {
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

        // AND if the URL consistency handler fails
        uRLConsistencyMock.updateEntityThrowableError = URLConsistencyHandlerError.anyError

        // WHEN modifying the lecture with new data and update it
        // Then it throws
        initialLecture.state = .managed
        do {
            try await lectureRepo.update(lecture: initialLecture)
            XCTFail("Should throw")
        } catch { }
    }

    func testLectureUpdateWithoutConsistecyHandler_REP0151() async throws {
        // GIVEN a Lecture repo without consistency handler
        lectureRepo = try LectureRepositoryBuilder.buildInMemory(
            uRLConsistencyHandler: nil,
            autopersist: true
        )
        // with a entity in
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

        // WHEN modifying the lecture with new data and update it
        // Then it throws
        initialLecture.state = .managed
        do {
            try await lectureRepo.update(lecture: initialLecture)
            XCTFail("Should throw")
        } catch { }
    }
}

enum URLConsistencyHandlerError: Error {
    case anyError
}
