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
final class GoalRepositoryInterfaceMock: GoalRepositoryInterface {

    //MARK: - add

    var addGoalThrowableError: Error?
    var addGoalCallsCount = 0
    var addGoalCalled: Bool {
        return addGoalCallsCount > 0
    }
    var addGoalReceivedGoal: GoalDataEntity?
    var addGoalReceivedInvocations: [GoalDataEntity] = []
    var addGoalClosure: ((GoalDataEntity) throws -> Void)?

    func add(goal: GoalDataEntity) async throws {
        if let error = addGoalThrowableError {
            throw error
        }
        addGoalCallsCount += 1
        addGoalReceivedGoal = goal
        addGoalReceivedInvocations.append(goal)
        try addGoalClosure?(goal)
    }

    //MARK: - goals

    var goalsThrowableError: Error?
    var goalsCallsCount = 0
    var goalsCalled: Bool {
        return goalsCallsCount > 0
    }
    var goalsReturnValue: [GoalDataEntity]!
    var goalsClosure: (() throws -> [GoalDataEntity])?

    func goals() async throws -> [GoalDataEntity] {
        if let error = goalsThrowableError {
            throw error
        }
        goalsCallsCount += 1
        return try goalsClosure.map({ try $0() }) ?? goalsReturnValue
    }

    //MARK: - goal

    var goalWithIdThrowableError: Error?
    var goalWithIdCallsCount = 0
    var goalWithIdCalled: Bool {
        return goalWithIdCallsCount > 0
    }
    var goalWithIdReceivedId: UUID?
    var goalWithIdReceivedInvocations: [UUID] = []
    var goalWithIdReturnValue: GoalDataEntity?
    var goalWithIdClosure: ((UUID) throws -> GoalDataEntity?)?

    func goal(withId id: UUID) async throws -> GoalDataEntity? {
        if let error = goalWithIdThrowableError {
            throw error
        }
        goalWithIdCallsCount += 1
        goalWithIdReceivedId = id
        goalWithIdReceivedInvocations.append(id)
        return try goalWithIdClosure.map({ try $0(id) }) ?? goalWithIdReturnValue
    }

    //MARK: - update

    var updateGoalThrowableError: Error?
    var updateGoalCallsCount = 0
    var updateGoalCalled: Bool {
        return updateGoalCallsCount > 0
    }
    var updateGoalReceivedGoal: GoalDataEntity?
    var updateGoalReceivedInvocations: [GoalDataEntity] = []
    var updateGoalClosure: ((GoalDataEntity) throws -> Void)?

    func update(goal: GoalDataEntity) async throws {
        if let error = updateGoalThrowableError {
            throw error
        }
        updateGoalCallsCount += 1
        updateGoalReceivedGoal = goal
        updateGoalReceivedInvocations.append(goal)
        try updateGoalClosure?(goal)
    }

    //MARK: - deleteGoal

    var deleteGoalWithIdThrowableError: Error?
    var deleteGoalWithIdCallsCount = 0
    var deleteGoalWithIdCalled: Bool {
        return deleteGoalWithIdCallsCount > 0
    }
    var deleteGoalWithIdReceivedId: UUID?
    var deleteGoalWithIdReceivedInvocations: [UUID] = []
    var deleteGoalWithIdClosure: ((UUID) throws -> Void)?

    func deleteGoal(withId id: UUID) async throws {
        if let error = deleteGoalWithIdThrowableError {
            throw error
        }
        deleteGoalWithIdCallsCount += 1
        deleteGoalWithIdReceivedId = id
        deleteGoalWithIdReceivedInvocations.append(id)
        try deleteGoalWithIdClosure?(id)
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
