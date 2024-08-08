// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import XCTest
@testable import XRepositories

final class GoalRepositoryTests: XCTestCase {

    var goalRepo: GoalRepositoryInterface!

    override func setUp() async throws {
        try await super.setUp()

        // Get rid of the inMemory Store
        ModelStoreBuilder.inMemoryStorageContainer = nil

        goalRepo = try GoalRepositoryBuilder.buildInMemory()
    }

    func testLectureAddAndDeleteFlow_REP0510_REP0520_REP0530() async throws {
        // GIVEN a Lecture data entity
        let uuid = UUID()
        let title = "This is a test title"
        let initialGoal = GoalDataEntity(id: uuid, title: title, dueDate: nil)

        // WHEN adding a goal
        try await goalRepo.add(goal: initialGoal)

        // THEN then we can retrive that lecture.
        if let retrievedGoal = try await goalRepo.goal(withId: uuid) {
            XCTAssertEqual(retrievedGoal.id, uuid)
        } else {
            XCTFail("There should be a goal to retrieve")
        }

        // WHEN deleting that lecture
        try await goalRepo.deleteGoal(withId: uuid)

        // THEN there should be no lecture
        let goals = try await goalRepo.goals()
        XCTAssert(goals.count == 0)
        // even when retrieved with id.
        if try await goalRepo.goal(withId: uuid) != nil {
            XCTFail("There should be NO goal to retrieve")
        }
    }

    func testLectureUpdateFlow_REP0150() async throws {
        // GIVEN a Lecture is already in the repo
        let uuid = UUID()
        let title = "This is a test title"
        let initialGoal = GoalDataEntity(id: uuid, title: title, dueDate: getADate())
        try await goalRepo.add(goal: initialGoal)

        // THEN then we can retrive that goal.
        if let retrievedGoal = try await goalRepo.goal(withId: uuid) {
            XCTAssertEqual(retrievedGoal.id, uuid)
        } else {
            XCTFail("There should be a goal to retrieve")
        }

        // WHEN updating the goal with new data and update it
        var modifiedGoal =  initialGoal
        modifiedGoal.title = "Modified Title"
        let modifiedDate = getAModifiedDate()
        modifiedGoal.dueDate = modifiedDate
        try await goalRepo.update(goal: modifiedGoal)

        // THEN then we can retrive the goal and check the data
        if let retrievedGoal = try await goalRepo.goal(withId: uuid) {
            XCTAssertEqual(retrievedGoal.id, uuid)
            XCTAssertEqual(retrievedGoal.title, "Modified Title")
            XCTAssertEqual(retrievedGoal.dueDate, modifiedDate)
        } else {
            XCTFail("There should be a goal to retrieve")
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

    func getAModifiedDate() -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = 2025
        dateComponents.month = 9
        dateComponents.day = 9

        let calendar = Calendar.current

        let specificDate = calendar.date(from: dateComponents)!
        return specificDate
    }
}
