// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import XCTest
@testable import XRepositories

final class LectureRepositoryGoalTests: XCTestCase {

    var lectureRepo: LectureRepositoryInteface!
    var goalRepo: GoalRepositoryInterface!
    var uRLConsistencyMock: LectureURLConsistencyHandlerMock!

    override func setUp() async throws {
        try await super.setUp()

        // Get rid of the inMemory Store
        ModelStoreBuilder.inMemoryStorageContainer = nil

        uRLConsistencyMock = LectureURLConsistencyHandlerMock()
        lectureRepo = try LectureRepositoryBuilder.buildInMemory(
            uRLConsistencyHandler: uRLConsistencyMock,
            autopersist: true
        )

        goalRepo = try GoalRepositoryBuilder.buildInMemory()
        print("done")
    }

    func testLectureUpdateFlowWhenGoalChanges_REP0150() async throws {

        throw XCTSkip("""
                This test is temporarily disabled.
                The test passes when not using inMemory storage.
        """)

        // GIVEN a Lecture is already in the repo
        let uuid = UUID()
        let title = "This is a test title"
        let urlComponents = URLComponents()
        let initialLecture = LectureDataEntity(id: uuid, title: title, mediaTailURL: urlComponents)
        try await lectureRepo.add(lecture: initialLecture)

        // THEN then we can retrive that lecture check that it doesn't have
        // a goal
        if let retrievedLecture = try await lectureRepo.lecture(withId: uuid) {
            XCTAssertEqual(retrievedLecture.id, uuid)
            XCTAssertNil(retrievedLecture.goal)
        } else {
            XCTFail("There should be a lecture to retrieve")
        }

        // AND having a goal in the repository
        let aDate = getADate()
        let goalID = UUID()
        let newGoal = GoalDataEntity(id: goalID, title: "New goal", dueDate: aDate)
        try await goalRepo.add(goal: newGoal)

        // THEN then we can retrive that
        if let retrievedgoal = try await goalRepo.goal(withId: goalID) {
            XCTAssertEqual(retrievedgoal.id, goalID)
        } else {
            XCTFail("There should be a goal to retrieve")
        }

        // AND if the URL consistency handler do not fail
        uRLConsistencyMock.updateEntityClosure = { lecture in
            return lecture
        }

        // WHEN updating the lecture with new goal and update it
        var modifiedLecture = initialLecture
        modifiedLecture.goal = newGoal
        try await lectureRepo.update(lecture: modifiedLecture)

        // THEN then we can retrive the lecture and check the data
        if let retrievedLecture = try await lectureRepo.lecture(withId: uuid) {
            XCTAssertEqual(retrievedLecture.id, uuid)
            XCTAssertEqual(retrievedLecture.goal, newGoal)
        } else {
            XCTFail("There should be a lecture to retrieve")
        }
    }

    // MARK: - test data

    func getADate() -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = 2024
        dateComponents.month = 8
        dateComponents.day = 8

        let calendar = Calendar.current

        let specificDate = calendar.date(from: dateComponents)!
        return specificDate
    }
}
