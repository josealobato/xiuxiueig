// Generated using Sourcery 2.1.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable:next blanket_disable_command
// swiftlint:disable all

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

@testable import XRepositories














final class CategoryRepositoryIntefaceMock: CategoryRepositoryInteface {

    //MARK: - add

    var addCategoryThrowableError: Error?
    var addCategoryCallsCount = 0
    var addCategoryCalled: Bool {
        return addCategoryCallsCount > 0
    }
    var addCategoryReceivedCategory: CategoryDataEntity?
    var addCategoryReceivedInvocations: [CategoryDataEntity] = []
    var addCategoryClosure: ((CategoryDataEntity) throws -> Void)?

    func add(category: CategoryDataEntity) async throws {
        if let error = addCategoryThrowableError {
            throw error
        }
        addCategoryCallsCount += 1
        addCategoryReceivedCategory = category
        addCategoryReceivedInvocations.append(category)
        try addCategoryClosure?(category)
    }

    //MARK: - categories

    var categoriesThrowableError: Error?
    var categoriesCallsCount = 0
    var categoriesCalled: Bool {
        return categoriesCallsCount > 0
    }
    var categoriesReturnValue: [CategoryDataEntity]!
    var categoriesClosure: (() throws -> [CategoryDataEntity])?

    func categories() async throws -> [CategoryDataEntity] {
        if let error = categoriesThrowableError {
            throw error
        }
        categoriesCallsCount += 1
        return try categoriesClosure.map({ try $0() }) ?? categoriesReturnValue
    }

    //MARK: - category

    var categoryWithIdThrowableError: Error?
    var categoryWithIdCallsCount = 0
    var categoryWithIdCalled: Bool {
        return categoryWithIdCallsCount > 0
    }
    var categoryWithIdReceivedId: UUID?
    var categoryWithIdReceivedInvocations: [UUID] = []
    var categoryWithIdReturnValue: CategoryDataEntity?
    var categoryWithIdClosure: ((UUID) throws -> CategoryDataEntity?)?

    func category(withId id: UUID) async throws -> CategoryDataEntity? {
        if let error = categoryWithIdThrowableError {
            throw error
        }
        categoryWithIdCallsCount += 1
        categoryWithIdReceivedId = id
        categoryWithIdReceivedInvocations.append(id)
        return try categoryWithIdClosure.map({ try $0(id) }) ?? categoryWithIdReturnValue
    }

    //MARK: - update

    var updateCategoryThrowableError: Error?
    var updateCategoryCallsCount = 0
    var updateCategoryCalled: Bool {
        return updateCategoryCallsCount > 0
    }
    var updateCategoryReceivedCategory: CategoryDataEntity?
    var updateCategoryReceivedInvocations: [CategoryDataEntity] = []
    var updateCategoryClosure: ((CategoryDataEntity) throws -> Void)?

    func update(category: CategoryDataEntity) async throws {
        if let error = updateCategoryThrowableError {
            throw error
        }
        updateCategoryCallsCount += 1
        updateCategoryReceivedCategory = category
        updateCategoryReceivedInvocations.append(category)
        try updateCategoryClosure?(category)
    }

    //MARK: - deleteCategory

    var deleteCategoryWithIdThrowableError: Error?
    var deleteCategoryWithIdCallsCount = 0
    var deleteCategoryWithIdCalled: Bool {
        return deleteCategoryWithIdCallsCount > 0
    }
    var deleteCategoryWithIdReceivedId: UUID?
    var deleteCategoryWithIdReceivedInvocations: [UUID] = []
    var deleteCategoryWithIdClosure: ((UUID) throws -> Void)?

    func deleteCategory(withId id: UUID) async throws {
        if let error = deleteCategoryWithIdThrowableError {
            throw error
        }
        deleteCategoryWithIdCallsCount += 1
        deleteCategoryWithIdReceivedId = id
        deleteCategoryWithIdReceivedInvocations.append(id)
        try deleteCategoryWithIdClosure?(id)
    }

    //MARK: - persist

    var persistThrowableError: Error?
    var persistCallsCount = 0
    var persistCalled: Bool {
        return persistCallsCount > 0
    }
    var persistClosure: (() throws -> Void)?

    func persist() async throws {
        if let error = persistThrowableError {
            throw error
        }
        persistCallsCount += 1
        try persistClosure?()
    }

}
final class LectureRepositoryIntefaceMock: LectureRepositoryInteface {

    //MARK: - add

    var addLectureThrowableError: Error?
    var addLectureCallsCount = 0
    var addLectureCalled: Bool {
        return addLectureCallsCount > 0
    }
    var addLectureReceivedLecture: LectureDataEntity?
    var addLectureReceivedInvocations: [LectureDataEntity] = []
    var addLectureClosure: ((LectureDataEntity) throws -> Void)?

    func add(lecture: LectureDataEntity) async throws {
        if let error = addLectureThrowableError {
            throw error
        }
        addLectureCallsCount += 1
        addLectureReceivedLecture = lecture
        addLectureReceivedInvocations.append(lecture)
        try addLectureClosure?(lecture)
    }

    //MARK: - lectures

    var lecturesThrowableError: Error?
    var lecturesCallsCount = 0
    var lecturesCalled: Bool {
        return lecturesCallsCount > 0
    }
    var lecturesReturnValue: [LectureDataEntity]!
    var lecturesClosure: (() throws -> [LectureDataEntity])?

    func lectures() async throws -> [LectureDataEntity] {
        if let error = lecturesThrowableError {
            throw error
        }
        lecturesCallsCount += 1
        return try lecturesClosure.map({ try $0() }) ?? lecturesReturnValue
    }

    //MARK: - lecture

    var lectureWithIdThrowableError: Error?
    var lectureWithIdCallsCount = 0
    var lectureWithIdCalled: Bool {
        return lectureWithIdCallsCount > 0
    }
    var lectureWithIdReceivedId: UUID?
    var lectureWithIdReceivedInvocations: [UUID] = []
    var lectureWithIdReturnValue: LectureDataEntity?
    var lectureWithIdClosure: ((UUID) throws -> LectureDataEntity?)?

    func lecture(withId id: UUID) async throws -> LectureDataEntity? {
        if let error = lectureWithIdThrowableError {
            throw error
        }
        lectureWithIdCallsCount += 1
        lectureWithIdReceivedId = id
        lectureWithIdReceivedInvocations.append(id)
        return try lectureWithIdClosure.map({ try $0(id) }) ?? lectureWithIdReturnValue
    }

    //MARK: - update

    var updateLectureThrowableError: Error?
    var updateLectureCallsCount = 0
    var updateLectureCalled: Bool {
        return updateLectureCallsCount > 0
    }
    var updateLectureReceivedLecture: LectureDataEntity?
    var updateLectureReceivedInvocations: [LectureDataEntity] = []
    var updateLectureClosure: ((LectureDataEntity) throws -> Void)?

    func update(lecture: LectureDataEntity) async throws {
        if let error = updateLectureThrowableError {
            throw error
        }
        updateLectureCallsCount += 1
        updateLectureReceivedLecture = lecture
        updateLectureReceivedInvocations.append(lecture)
        try updateLectureClosure?(lecture)
    }

    //MARK: - deleteLecture

    var deleteLectureWithIdThrowableError: Error?
    var deleteLectureWithIdCallsCount = 0
    var deleteLectureWithIdCalled: Bool {
        return deleteLectureWithIdCallsCount > 0
    }
    var deleteLectureWithIdReceivedId: UUID?
    var deleteLectureWithIdReceivedInvocations: [UUID] = []
    var deleteLectureWithIdClosure: ((UUID) throws -> Void)?

    func deleteLecture(withId id: UUID) async throws {
        if let error = deleteLectureWithIdThrowableError {
            throw error
        }
        deleteLectureWithIdCallsCount += 1
        deleteLectureWithIdReceivedId = id
        deleteLectureWithIdReceivedInvocations.append(id)
        try deleteLectureWithIdClosure?(id)
    }

    //MARK: - persist

    var persistThrowableError: Error?
    var persistCallsCount = 0
    var persistCalled: Bool {
        return persistCallsCount > 0
    }
    var persistClosure: (() throws -> Void)?

    func persist() async throws {
        if let error = persistThrowableError {
            throw error
        }
        persistCallsCount += 1
        try persistClosure?()
    }

}
final class LectureURLConsistencyHandlerMock: LectureURLConsistencyHandler {

    //MARK: - update

    var updateEntityThrowableError: Error?
    var updateEntityCallsCount = 0
    var updateEntityCalled: Bool {
        return updateEntityCallsCount > 0
    }
    var updateEntityReceivedEntity: LectureDataEntity?
    var updateEntityReceivedInvocations: [LectureDataEntity] = []
    var updateEntityReturnValue: LectureDataEntity!
    var updateEntityClosure: ((LectureDataEntity) throws -> LectureDataEntity)?

    func update(entity: LectureDataEntity) throws -> LectureDataEntity {
        if let error = updateEntityThrowableError {
            throw error
        }
        updateEntityCallsCount += 1
        updateEntityReceivedEntity = entity
        updateEntityReceivedInvocations.append(entity)
        return try updateEntityClosure.map({ try $0(entity) }) ?? updateEntityReturnValue
    }

}
// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

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
        let urlComponents = URLComponents()
        let initialLecture = LectureDataEntity(id: uuid, title: title, mediaTailURL: urlComponents)

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
        let urlComponents = URLComponents()
        var initialLecture = LectureDataEntity(id: uuid, title: title, mediaTailURL: urlComponents)
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
        let urlComponents = URLComponents(string: "/Inbox/myfile.mp3")!
        var initialLecture = LectureDataEntity(id: uuid, title: title, mediaTailURL: urlComponents)
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
            modifiedLecture.mediaTailURL = URLComponents(string: "Inbox/myfile.mp3")!
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
                retrievedLecture.mediaTailURL.path,
                "Inbox/myfile.mp3"
            )
        } else {
            XCTFail("There should be a lecture to retrieve")
        }
    }

    func testLectureUpdateWithConsistecyFail_REP0151() async throws {
        // GIVEN a Lecture is already in the repo
        let uuid = UUID()
        let title = "This is a test title"
        let urlComponents = URLComponents()
        var initialLecture = LectureDataEntity(id: uuid, title: title, mediaTailURL: urlComponents)
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
        let urlComponents = URLComponents()
        var initialLecture = LectureDataEntity(id: uuid, title: title, mediaTailURL: urlComponents)
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
        // GIVEN a Lecture is already in the repo
        let uuid = UUID()
        let title = "This is a test title"
        let urlComponents = URLComponents()
        var initialLecture = LectureDataEntity(id: uuid, title: title, mediaTailURL: urlComponents)
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
// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftData
import XCTest

@testable import XRepositories

final class CategoryModelCRUDTest: CRUDModelBaseTestCase<CategoryModel> {

    // MARK: - Build facilities.

    let createModel = { CategoryModel(externalId: UUID(), title: "Maths", imageURL: URL(string: "http://test.com")) }
    let createModels = {
        [
            CategoryModel(externalId: UUID(), title: "Maths", imageURL: URL(string: "http://test.com")),
            CategoryModel(externalId: UUID(), title: "Physics", imageURL: URL(string: "http://test.com"))
        ]
    }
    let modelPredicate = #Predicate<CategoryModel> { $0.title == "Maths" }

    // MARK: - Crud - Create

    func testInsertModel() async throws {
        try await _testInsertModel { createModel() }
    }

    func testInsertModels() async throws {
        try await _testInsertModels { createModels() }
    }

    // MARK: - cRud - Retrive

    func testFetchWithoutDescriptor() async throws {
        try await _testFetchWithoutDescriptor { createModel() }
    }

    func testFetchWithDescriptor() async throws {
        try await _testFetchWithDescriptor(
            { createModel() },
            descriptor: FetchDescriptor(predicate: modelPredicate)
        )
    }

    // MARK: - crUd - Update

    // Not clear yet how to test this.

    // MARK: - cruD - Delete

    func testDeleteWithoutPredicate() async throws {
        try await _testDeleteWithoutPredicate { createModel() }
    }

    func testDeleteWithPredicate() async throws {
        try await _testDeleteWithPredicate(
            input: { createModel() },
            predicate: modelPredicate
        )
    }

    func testDeleteWithID() async throws {
        try await _testDeleteWithID { createModel() }
    }
}
// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

// This code is based on the Persistence implemenentation of my friend
// Alejandro Ramirez `Jano`.

import XCTest
import SwiftData

// swiftlint:disable identifier_name
@testable import XRepositories

/// Generic test case to allow for a quick way of writing test
/// for different Models.
class CRUDModelBaseTestCase<T: PersistentModel>: XCTestCase {
    var store: ModelStore!

    override func setUp() async throws {
        // GIVEN a fresh store in memory
        store = try ModelStoreBuilder.build(inMemory: true)
    }

    // MARK: - Crud - Create

    /// Tests ModelStore.insert(_:) with one model
    func _testInsertModel(_ input: () -> T) async throws {
        // GIVEN a store with one inserted model
        let model = input()
        try await store.insert(model)
        try await store.save()

        // WHEN fetching all models of that type
        let models: [T] = try await store.fetch()

        // THEN there is one model in the store
        try await XCTAssertCount(T.self, 1)

        // THEN the model found is equal to the inserted model
        let readBackModel = try XCTUnwrap(models.first)
        XCTAssertEqual(model, readBackModel)
    }

    /// Tests ModelStore.insert(_:) with an array of models
    func _testInsertModels(_ input: () -> [T]) async throws {
        // GIVEN a store with many inserted models
        let models = input()
        try await store.insert(models)
        try await store.save()

        // THEN number of fetched objects matches number of objects in the input
        try await XCTAssertCount(T.self, models.count)
    }

    // MARK: - cRud - Retrive

    /// Tests ModelStore.fetch(_:) without parameters
    func _testFetchWithoutDescriptor(_ input: () -> T) async throws {
        // GIVEN a store with one inserted model
        let model = input()
        try await store.insert(model)
        try await store.save()
        try await XCTAssertCount(T.self, 1)

        // WHEN fetching all models
        let models: [T] = try await store.fetch()

        // THEN there is one model in the store
        XCTAssertEqual(models.count, 1)
    }

    /// Tests ModelStore.fetch(_:) with descriptor
    func _testFetchWithDescriptor(_ input: () -> T, descriptor: FetchDescriptor<T>) async throws {
        // GIVEN a store with one inserted model
        let model = input()
        try await store.insert(model)
        try await store.save()
        try await XCTAssertCount(T.self, 1)

        // WHEN fetching all models with a matching descriptor
        let models: [T] = try await store.fetch(descriptor)

        // THEN there is one model in the store
        XCTAssertEqual(models.count, 1)
    }

    // Could write Tests ModelStore.fetch(_:) with predicate
    // Pending implementation.

    // MARK: - crUd - Update

    // No base test case for Update

    // MARK: - cruD - Delete

    /// Tests ModelStore.delete(_:predicate:) without predicate
    func _testDeleteWithoutPredicate(input: () -> T) async throws {
        // GIVEN a store with one inserted model
        let model = input()
        try await store.insert(model)
        try await store.save()
        try await XCTAssertCount(T.self, 1)

        // WHEN deleting all models of that type
        try await store.delete(T.self, predicate: nil)

        // THEN no models of that type remain in the store
        try await XCTAssertCount(T.self, 0)
    }

    /// Tests ModelStore.delete(_:predicate:) with predicate
    func _testDeleteWithPredicate(input: () -> T, predicate: Predicate<T>) async throws {
        // GIVEN a store with one inserted model
        let model = input()
        try await store.insert(model)
        try await store.save()
        try await XCTAssertCount(T.self, 1)

        // WHEN deleting all models with a matching predicate
        try await store.delete(T.self, predicate: predicate)

        // THEN no models of that type remain in the store
        try await XCTAssertCount(T.self, 0)
    }

    /// Tests ModelStore.delete(id:type:) with ID
    func _testDeleteWithID(_ input: () -> T) async throws {
        // GIVEN a store with one inserted model
        let model = input()
        try await store.insert(model)
        try await store.save()
        try await XCTAssertCount(T.self, 1)

        // WHEN deleting all models with that id
        try await store.delete(id: model.persistentModelID, type: T.self)

        // THEN no models of that type remain in the store
        try await XCTAssertCount(T.self, 0)
    }

    // MARK: - Helper methods

    /// Method to assert the number of entries of a model in the Store.
    /// - Parameters:
    ///   - type: The model type
    ///   - count: the nxpected count
    private func XCTAssertCount(
        _ type: T.Type,
        _ count: Int,
        _ message: @autoclosure () -> String = "",
        file: StaticString = #filePath,
        line: UInt = #line
    ) async throws where T: Equatable {
        let objects: [T] = try await store.fetch()
        XCTAssertEqual(objects.count, count, message(), file: file, line: line)
    }
}
// swiftlint:enable identifier_name
// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftData
import XCTest

@testable import XRepositories

final class LectureModelCRUDTest: CRUDModelBaseTestCase<LectureModel> {

    // MARK: - Build facilities.

    let createModel = {
        LectureModel(externalId: UUID(), title: "My great lessson")
    }
    let createModels = {
        [
            LectureModel(externalId: UUID(), title: "My great lessson"),
            LectureModel(externalId: UUID(), title: "My other great lessson")
        ]
    }
    let modelPredicate = #Predicate<LectureModel> { $0.title == "My great lessson" }

    // MARK: - Crud - Create

    func testInsertModel() async throws {
        try await _testInsertModel { createModel() }
    }

    func testInsertModels() async throws {
        try await _testInsertModels { createModels() }
    }

    // MARK: - cRud - Retrive

    func testFetchWithoutDescriptor() async throws {
        try await _testFetchWithoutDescriptor { createModel() }
    }

    func testFetchWithDescriptor() async throws {
        try await _testFetchWithDescriptor(
            { createModel() },
            descriptor: FetchDescriptor(predicate: modelPredicate)
        )
    }

    // MARK: - crUd - Update

    // Not clear yet how to test this.

    // MARK: - cruD - Delete

    func testDeleteWithoutPredicate() async throws {
        try await _testDeleteWithoutPredicate { createModel() }
    }

    func testDeleteWithPredicate() async throws {
        try await _testDeleteWithPredicate(
            input: { createModel() },
            predicate: modelPredicate
        )
    }

    func testDeleteWithID() async throws {
        try await _testDeleteWithID { createModel() }
    }
}
// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import XCTest
@testable import XRepositories

final class GoalRepositoryTests: XCTestCase {

    var goalRepo: GoalRepositoryInterface!

    override func setUp() async throws {
        try await super.setUp()

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
        let urlComponents = URLComponents()
        var initialGoal = GoalDataEntity(id: uuid, title: title, dueDate: getADate())
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
// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "XRepositories",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "XRepositories",
            targets: ["XRepositories"])
    ],
    dependencies: [
        .package(name: "XToolKit", path: "../../XToolKit")
    ],
    targets: [
        .target(
            name: "XRepositories",
            dependencies: ["XToolKit"]),
        .testTarget(
            name: "XRepositoriesTests",
            dependencies: ["XRepositories", "XToolKit"])
    ]
)
// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

public struct LectureDataEntity: Identifiable, Equatable {

    public let id: UUID
    public var title: String
    public var category: CategoryDataEntity?
    public var goal: GoalDataEntity?
    public var mediaTailURL: URLComponents
    public var imageURL: URL?
    public var queuePosition: Int?
    public var playPosition: Int?
    public var played: [Date]

    public enum State: String, Codable, Equatable {
        case new
        case managed
        case archived
    }
    public var state: State

    public init(id: UUID,
                title: String,
                category: CategoryDataEntity? = nil,
                goal: GoalDataEntity? = nil,
                mediaTailURL: URLComponents,
                imageURL: URL? = nil,
                queuePosition: Int? = nil,
                playPosition: Int? = nil,
                played: [Date] = [],
                state: State = State.new) {

        self.id = id
        self.title = title
        self.category = category
        self.goal = goal
        self.mediaTailURL = mediaTailURL
        self.imageURL = imageURL
        self.queuePosition = queuePosition
        self.playPosition = playPosition
        self.played = played
        self.state = state
    }
}

// MARK: - Extensions to convert to and from model

extension LectureDataEntity {

    func lectureModel() -> LectureModel {

        var state: LectureModel.State
        switch self.state {
        case .archived: state = .archived
        case .new: state = .new
        case .managed: state = .managed
        }

        return LectureModel(externalId: self.id,
                            title: self.title,
                            category: self.category?.categoryModel(),
                            goal: self.goal?.goalModel(),
                            mediaTailURLPath: self.mediaTailURL.path,
                            imageURL: self.imageURL,
                            queuePosition: self.queuePosition,
                            playPosition: self.playPosition,
                            played: self.played,
                            state: state)
    }

    static func from(model: LectureModel) -> Self? {

        guard let mediaTailURLPath = model.mediaTailURLPath,
              let mediaTailURLComponents = URLComponents(string: mediaTailURLPath)
        else { return nil }

        var categoryDataEntity: CategoryDataEntity?
        if let categoryModel = model.category {
            categoryDataEntity = CategoryDataEntity.from(model: categoryModel)
        }

        var goalDataEntity: GoalDataEntity?
        if let goalModel = model.goal {
            goalDataEntity = GoalDataEntity.from(model: goalModel)
        }

        var state: State
        switch model.state {
        case .archived: state = .archived
        case .new: state = .new
        case .managed: state = .managed
        default: state = .new
        }

        return LectureDataEntity(id: model.externalId ?? UUID(),
                                 title: model.title ?? "",
                                 category: categoryDataEntity,
                                 goal: goalDataEntity,
                                 mediaTailURL: mediaTailURLComponents,
                                 imageURL: model.imageURL ?? nil,
                                 queuePosition: model.queuePosition,
                                 playPosition: model.playPosition,
                                 played: model.played ?? [],
                                 state: state)
    }
}
// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

public struct GoalDataEntity: Identifiable, Equatable {

    public let id: UUID
    public var title: String
    public var dueDate: Date?

    public init(id: UUID,
                title: String,
                dueDate: Date?) {

        self.id = id
        self.title = title
        self.dueDate = dueDate
    }
}

// MARK: - Extensions to convert to and from model

extension GoalDataEntity {

    func goalModel() -> GoalModel {

        let model = GoalModel(
            externalId: self.id,
            title: self.title,
            dueDate: self.dueDate)

        return model
    }

    static func from(model: GoalModel) -> Self? {

        guard let id = model.externalId,
              let title =  model.title
        else { return nil }

        let dataEntity = GoalDataEntity(
            id: id,
            title: title,
            dueDate: model.dueDate)

        return dataEntity
    }
}
// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

public struct CategoryDataEntity: Identifiable, Equatable {

    public let id: UUID
    public var title: String
    public var imageURL: URL?

    // This is the FS symbol associated with every.
    // one like `text.book.closed` can be set by default.
    public var defaultImage: String {
        "text.book.closed"
    }

    public init(id: UUID,
                title: String,
                imageURL: URL?) {

        self.id = id
        self.title = title
        self.imageURL = imageURL
    }
}

// MARK: - Extensions to convert to and from model

extension CategoryDataEntity {

    func categoryModel() -> CategoryModel {
        CategoryModel(externalId: self.id,
                      title: self.title,
                      imageURL: self.imageURL)
    }

    static func from(model: CategoryModel) -> Self {

        CategoryDataEntity(id: model.externalId ?? UUID(),
                           title: model.title ?? "",
                           imageURL: model.imageURL)

    }
}
// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import SwiftData
import XToolKit

@ModelActor
/// The actor that contains access to the data store.
final actor ModelStore {
    let logger = XLog.logger(category: "ModelStore")

    // Easy access to the model Context.
    public var context: ModelContext { modelContext }
}
// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

// This code is based on the Persistence implemenentation of my friend
// Alejandro Ramirez `Jano`.

import Foundation
import SwiftData

enum ModelStoreError: Error, CustomStringConvertible, Equatable {

    // Keep this enumeration sorted alphabetically
    case missingObjectWithId(PersistentIdentifier)

    // CustomStringConvertible
    var description: String {
        switch self {
        case .missingObjectWithId(let id):
            "Expected to find object with id \(id)"

        }
    }
}
// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import SwiftData

@Model
final class CategoryModel {
    var externalId: UUID?
    var title: String?
    var imageURL: URL?

    init(externalId: UUID? = nil, title: String? = nil, imageURL: URL?) {
        self.externalId = externalId
        self.title = title
        self.imageURL = imageURL
    }
}
// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import SwiftData

@Model
final class LectureModel {
    var externalId: UUID?
    var title: String?

    @Relationship(deleteRule: .nullify)
    var category: CategoryModel?

    @Relationship(deleteRule: .nullify)
    var goal: GoalModel?

    var mediaTailURLPath: String?
    var imageURL: URL?

    var queuePosition: Int?
    var playPosition: Int?
    var played: [Date]?

    enum State: String, Codable {
        case new
        case managed
        case archived

        static func from(entityState: LectureDataEntity.State) -> State {
            switch entityState {
            case .new: return .new
            case .managed: return .managed
            case .archived: return .archived
            }
        }
    }
    var state: State?

    init(externalId: UUID? = nil,
         title: String? = nil,
         category: CategoryModel? = nil,
         goal: GoalModel? = nil,
         mediaTailURLPath: String? = nil,
         imageURL: URL? = nil,
         queuePosition: Int? = nil,
         playPosition: Int? = nil,
         played: [Date]? = nil,
         state: State? = nil) {
        self.externalId = externalId
        self.title = title
        self.category = category
        self.goal = goal
        self.mediaTailURLPath = mediaTailURLPath
        self.imageURL = imageURL
        self.queuePosition = queuePosition
        self.playPosition = playPosition
        self.played = played
        self.state = state
    }
}

extension LectureModel {

    func updateWith(entity: LectureDataEntity) {
        // id is not updated
        title = entity.title
        // Not updating the category here.
        // Not updating the goal here.
        mediaTailURLPath = entity.mediaTailURL.path
        queuePosition = entity.queuePosition
        playPosition = entity.playPosition
        played = entity.played
        state = State.from(entityState: entity.state)
    }
}
// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import SwiftData

@Model
final class GoalModel {
    var externalId: UUID?
    var title: String?
    var dueDate: Date?

    init(externalId: UUID? = nil,
         title: String? = nil,
         dueDate: Date? = nil) {

        self.externalId = externalId
        self.title = title
        self.dueDate = dueDate
    }
}

extension GoalModel {

    func updateWith(entity: GoalDataEntity) {
        // id is not updated
        title = entity.title
        dueDate = entity.dueDate
    }
}
// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftData

struct ModelStoreBuilder {

    static var inMemoryStorageContainer: StorageContainer?

    static func build(inMemory: Bool = false) throws -> ModelStore {

        var storageContainer: StorageContainer
        if inMemory {

            if let container = inMemoryStorageContainer {
                storageContainer = container
            } else {
                storageContainer = StorageContainer(inMemory: inMemory)
                inMemoryStorageContainer = storageContainer
            }

        } else {
            storageContainer = StorageContainer.shared
        }

        print("--------> container : \(storageContainer)")

//        if let url = storageContainer.configurations.first?.url.path(percentEncoded: false) {
//                    print("sqlite3 \"\(url)\"")
//                } else {
//                    print("No SQLite database found.")
//                }

        return ModelStore(modelContainer: storageContainer.modelContainer)
    }
}
// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

// This code is based on the Persistence implemenentation of my friend
// Alejandro Ramirez `Jano`.

import Foundation
import SwiftData

extension ModelStore {

    // MARK: - store specific methods

    func save() throws {
        try context.save()
    }

    // MARK: - Crud - Create

    func insert(_ model: some PersistentModel) throws {
        context.insert(model)
    }

    func insert(_ models: [some PersistentModel]) throws {
        for model in models {
            context.insert(model)
        }
    }

    // MARK: - cRud - Retrive

    func fetch<T: PersistentModel>(_ predicate: Predicate<T>? = nil) throws -> [T] {
        try context.fetch(FetchDescriptor<T>(predicate: predicate))
    }

    func fetch<T: PersistentModel>(_ descriptor: FetchDescriptor<T>) throws -> [T] {
        try context.fetch(descriptor)
    }

    func fetch<T: PersistentModel>(id: PersistentIdentifier, type: T.Type) throws -> T? {
        context.model(for: id) as? T
    }

    func numberOf<T: PersistentModel>(_ model: T.Type) throws -> Int {
        try context.fetchCount(FetchDescriptor<T>())
    }

    // MARK: - crUd - Update

    /// `update` do not really update but check the existence of a value and then execute
    /// the given `updating` method to allow the caller to update. This is a internal
    /// method to be used inside the Model Store.
    /// - Parameters:
    ///   - id: Moded id to update
    ///   - updating: The method to be called to do the update.
    /// - Returns: The moidifed model.
    func update<T: PersistentModel>(id: PersistentIdentifier, updating: (T) throws -> Void) throws -> T {
        guard let item = context.model(for: id) as? T else {
            throw ModelStoreError.missingObjectWithId(id)
        }
        try updating(item)
        return item
    }

    // MARK: - cruD - Delete

    func delete<T: PersistentModel>(_ model: T.Type, predicate: Predicate<T>? = nil) throws {
        try context.delete(model: T.self, where: predicate)
    }

    func delete<T: PersistentModel>(id: PersistentIdentifier, type: T.Type) throws {
        guard let item = context.model(for: id) as? T else { return }
        context.delete(item)
    }

}
// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftData

/// The storage container is in charge of building the Model container
/// that will be later use to create the Model Store.
///
/// Notice that:
/// * Model containter should be only one.
/// * Model Store will be one for every repo, since it is the responsible for
///     the context.
struct StorageContainer {

    static let shared = StorageContainer()

    let inMemory: Bool
    init(inMemory: Bool = false) {

        self.inMemory = inMemory
    }

    lazy var modelContainer: ModelContainer = {
        let fullSchema = Schema([
            LectureModel.self,
            CategoryModel.self,
            GoalModel.self
        ])

        let configuration = ModelConfiguration(schema: fullSchema, isStoredInMemoryOnly: inMemory)

        let container: ModelContainer
        do {
            container = try ModelContainer(
                for: fullSchema,
                configurations: [configuration]
            )
        } catch {
            fatalError("Failed to create the model container: \(error)")
        }

        return container
    }()
}
// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

final class CategoryRepository {

    let store: ModelStore

    init(store: ModelStore) {
        self.store = store
    }
}

extension CategoryRepository: CategoryRepositoryInteface {

    func add(category: CategoryDataEntity) async throws {
        try await store.insert(category.categoryModel())
    }

    func categories() async throws -> [CategoryDataEntity] {
        let models: [CategoryModel] = try await store.fetch(nil)
        let dataEntities = models.map { CategoryDataEntity.from(model: $0) }
        return dataEntities
    }

    func category(withId id: UUID) async throws -> CategoryDataEntity? {
        let modelPredicate = #Predicate<CategoryModel> { $0.externalId == id }
        let model: [CategoryModel] = try await store.fetch(modelPredicate)
        if let model = model.first {
            let dataEntity = CategoryDataEntity.from(model: model)
            return dataEntity
        }
        return nil
    }

    func update(category: CategoryDataEntity) async throws {
        // Intentionaly left empty
    }

    func deleteCategory(withId id: UUID) async throws {
        let modelPredicate = #Predicate<CategoryModel> { $0.externalId == id }
        try await store.delete(CategoryModel.self, predicate: modelPredicate)
    }

    func persist() async throws {
        try await store.save()
    }
}
// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XToolKit

/// CRUD interface to manange `CategoryDataEntities`.
public protocol CategoryRepositoryInteface: AutoMockable {

    // Create
    func add(category: CategoryDataEntity) async throws

    // Read
    func categories() async throws -> [CategoryDataEntity]
    func category(withId id: UUID) async throws -> CategoryDataEntity?

    // Update
    func update(category: CategoryDataEntity) async throws

    // Delete
    func deleteCategory(withId id: UUID) async throws

    // Persist
    func persist() async throws
}
// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

/// Facility to build a Category Repository.
public struct CategoryRepositoryBuilder {

    public static func build() throws -> CategoryRepositoryInteface {

        try CategoryRepository(store: ModelStoreBuilder.build())
    }
}
// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XToolKit

/// Errors that the LectureRepositoryInteface will throw
/// (not all errors are covered ATM)
public enum LectureRepositoryIntefaceError: Error {
    case noModelForGivenEntity
    case canNotUpdateWithoutConsistencyHandler
}

// Developer Note: this interface is throwing some interal errors.
// Need to be improved.

/// CRUD interface to manange `LectureDataEntities`.
public protocol LectureRepositoryInteface: AutoMockable {

    // Create
    func add(lecture: LectureDataEntity) async throws

    // Read
    func lectures() async throws -> [LectureDataEntity]
    func lecture(withId id: UUID) async throws -> LectureDataEntity?

    // Update
    func update(lecture: LectureDataEntity) async throws

    // Delete
    func deleteLecture(withId id: UUID) async throws

    // Persist
    func persist() async throws
}
// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XToolKit

final class LectureRepository {

    let logger = XLog.logger(category: "Lecture Repository")
    let store: ModelStore
    let uRLConsistencyHandler: LectureURLConsistencyHandler?

    /// When autopersist is on, the repository will persist automaticaly on
    /// every call to a modifying method (add, delete, update)
    let autoPersist: Bool

    init(store: ModelStore,
         consistencyInterface: LectureURLConsistencyHandler?,
         autopersist: Bool = false) {
        self.store = store
        self.uRLConsistencyHandler = consistencyInterface
        self.autoPersist = autopersist
    }
}

extension LectureRepository: LectureRepositoryInteface {

    func add(lecture: LectureDataEntity) async throws {
        logger.debug("LR Add lecture \(lecture.title)")
        try await store.insert(lecture.lectureModel())
        if autoPersist { try await persist() }
    }

    func lectures() async throws -> [LectureDataEntity] {
        let models: [LectureModel] = try await store.fetch(nil)
        let dataEntities = models.compactMap { LectureDataEntity.from(model: $0) }
        return dataEntities
    }

    func lecture(withId id: UUID) async throws -> LectureDataEntity? {
        let modelPredicate = #Predicate<LectureModel> { $0.externalId == id }
        let model: [LectureModel] = try await store.fetch(modelPredicate)
        if let model = model.first {
            let dataEntity = LectureDataEntity.from(model: model)
            return dataEntity
        }
        return nil
    }

    func update(lecture: LectureDataEntity) async throws {

        // First, let's get the model first.

        let id = lecture.id
        let modelPredicate = #Predicate<LectureModel> { $0.externalId == id }
        let models: [LectureModel] = try await store.fetch(modelPredicate)

        guard let lectureModel = models.first else {
            logger.error("LR no model for lecture: \(lecture.title)")
            throw LectureRepositoryIntefaceError.noModelForGivenEntity
        }

        // Second let's update the Media URL.

        // Before updating and persisting the model, update the Media File System,
        // if that goes well proceed to the change in the dataBase.
        guard let uRLConsistencyHandler = self.uRLConsistencyHandler else {
            // log update can now work without consistencyInterface
            logger.error("LR Can not update without URL consistency handler")
            throw LectureRepositoryIntefaceError.canNotUpdateWithoutConsistencyHandler
        }

        let modifiedLecture = try uRLConsistencyHandler.update(entity: lecture)

        // Finaly let's update and persist the model

        lectureModel.updateWith(entity: modifiedLecture)

        // Update Dependencies (Category)
        if let category = modifiedLecture.category {
            let categoryId = category.id
            let modelPredicate = #Predicate<CategoryModel> { $0.externalId == categoryId }
            let models: [CategoryModel] = try await store.fetch(modelPredicate)
            if let categoryModel = models.first {
                lectureModel.category = categoryModel
            }
        }

        // Update Dependencies (Goal)
        if let goal = modifiedLecture.goal {
            let goalId = goal.id
            let modelPredicate = #Predicate<GoalModel> { $0.externalId == goalId }
            let models: [GoalModel] = try await store.fetch(modelPredicate)
            if let goalModel = models.first {
                lectureModel.goal = goalModel
            }
        }

        logger.debug("LR Updated lecture \(modifiedLecture.title) with url \(modifiedLecture.mediaTailURL)")
        try await persist()
    }

    func deleteLecture(withId id: UUID) async throws {
        logger.warning("LR delete lecture")
        let modelPredicate = #Predicate<LectureModel> { $0.externalId == id }
        try await store.delete(LectureModel.self, predicate: modelPredicate)
        if autoPersist { try await persist() }
    }

    func persist() async throws {
        try await store.save()
    }
}
// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XToolKit

/// We a entity is updated, externally we need a handler that modify the URL
/// and make it consistent with the media file system. That handler should
/// conform to this protocol for the Lecture repository interact with it.
public protocol LectureURLConsistencyHandler: AutoMockable {

    /// The Lecture repository will use this method to request an updated
    /// entity with a fresh URL from the given modified entity
    /// - Parameter entity: The suposely modified entity.
    /// - Returns: A new entity with the same data than the previous one but
    ///            with an updated URL according to the changes in the input
    ///            entity.
    func update(entity: LectureDataEntity) throws -> LectureDataEntity
}
// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

/// Facility to build a Lecture Repository.
public struct LectureRepositoryBuilder {

    public static func build(
        uRLConsistencyHandler: LectureURLConsistencyHandler? = nil,
        autopersist: Bool = false) throws -> LectureRepositoryInteface {

        try LectureRepository(
            store: ModelStoreBuilder.build(),
            consistencyInterface: uRLConsistencyHandler,
            autopersist: autopersist
        )
    }

    public static func buildInMemory(
        uRLConsistencyHandler: LectureURLConsistencyHandler? = nil,
        autopersist: Bool = false) throws -> LectureRepositoryInteface {

        try LectureRepository(
            store: ModelStoreBuilder.build(inMemory: true),
            consistencyInterface: uRLConsistencyHandler,
            autopersist: autopersist
        )
    }
}
// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

/// Facility to build a Goal Repository.
public struct GoalRepositoryBuilder {

    public static func build() throws -> GoalRepositoryInterface {

        try GoalRepository(
            store: ModelStoreBuilder.build()
        )
    }

    public static func buildInMemory() throws -> GoalRepositoryInterface {

        try GoalRepository(
            store: ModelStoreBuilder.build(inMemory: true)
        )
    }
}
// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XToolKit

/// Errors that the GoalRepositoryInteface will throw
/// (not all errors are covered ATM)
public enum GoalRepositoryIntefaceError: Error {
    case noModelForGivenEntity
}

public protocol GoalRepositoryInterface: AutoMockable {

    // Create
    func add(goal: GoalDataEntity) async throws

    // Read
    func goals() async throws -> [GoalDataEntity]
    func goal(withId id: UUID) async throws -> GoalDataEntity?

    // Update
    func update(goal: GoalDataEntity) async throws

    // Delete
    func deleteGoal(withId id: UUID) async throws

    // Persist
    func persist() async throws
}
// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XToolKit

final class GoalRepository {

    let logger = XLog.logger(category: "Goal Repository")
    let store: ModelStore

    init(store: ModelStore) {
        self.store = store
    }
}

extension GoalRepository: GoalRepositoryInterface {

    func add(goal: GoalDataEntity) async throws {
        logger.debug("GoalRep Add goal \(goal.title)")
        try await store.insert(goal.goalModel())
        try await persist()
    }

    func goals() async throws -> [GoalDataEntity] {
        let models: [GoalModel] = try await store.fetch(nil)
        let dataEntities = models.compactMap { GoalDataEntity.from(model: $0) }
        return dataEntities
    }

    func goal(withId id: UUID) async throws -> GoalDataEntity? {
        let modelPredicate = #Predicate<GoalModel> { $0.externalId == id }
        let model: [GoalModel] = try await store.fetch(modelPredicate)
        if let model = model.first {
            let dataEntity = GoalDataEntity.from(model: model)
            return dataEntity
        }
        return nil
    }

    func update(goal: GoalDataEntity) async throws {

        // First, let's get the model first.

        let id = goal.id
        let modelPredicate = #Predicate<GoalModel> { $0.externalId == id }
        let models: [GoalModel] = try await store.fetch(modelPredicate)

        guard let goalModel = models.first else {
            logger.error("GoalRep no model for lecture: \(goal.title)")
            throw GoalRepositoryIntefaceError.noModelForGivenEntity
        }

        // Second, let's update and persist the model

        goalModel.updateWith(entity: goal)

        try await persist()
    }

    func deleteGoal(withId id: UUID) async throws {
        logger.warning("GoalRep delete goal")
        let modelPredicate = #Predicate<GoalModel> { $0.externalId == id}
        try await store.delete(GoalModel.self, predicate: modelPredicate)
        try await persist()
    }

    func persist() async throws {
        try await store.save()
    }
}
// The Swift Programming Language
// https://docs.swift.org/swift-book
