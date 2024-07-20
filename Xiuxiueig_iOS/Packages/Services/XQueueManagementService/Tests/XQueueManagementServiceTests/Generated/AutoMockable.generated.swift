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

@testable import XQueueManagementService; import XEntities; import XCoordinator; import XRepositories














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
final class QueueManagementServiceInterfaceMock: QueueManagementServiceInterface {
    var coordinator: XCoordinationRequestProtocol?

    //MARK: - getQueue

    var getQueueCallsCount = 0
    var getQueueCalled: Bool {
        return getQueueCallsCount > 0
    }
    var getQueueReturnValue: [LectureEntity]!
    var getQueueClosure: (() -> [LectureEntity])?

    func getQueue() -> [LectureEntity] {
        getQueueCallsCount += 1
        return getQueueClosure.map({ $0() }) ?? getQueueReturnValue
    }

    //MARK: - getNext

    var getNextCallsCount = 0
    var getNextCalled: Bool {
        return getNextCallsCount > 0
    }
    var getNextReturnValue: LectureEntity?
    var getNextClosure: (() -> LectureEntity?)?

    func getNext() -> LectureEntity? {
        getNextCallsCount += 1
        return getNextClosure.map({ $0() }) ?? getNextReturnValue
    }

    //MARK: - startedPlayingLecture

    var startedPlayingLectureIdInCallsCount = 0
    var startedPlayingLectureIdInCalled: Bool {
        return startedPlayingLectureIdInCallsCount > 0
    }
    var startedPlayingLectureIdInReceivedArguments: (id: UUID, second: Int)?
    var startedPlayingLectureIdInReceivedInvocations: [(id: UUID, second: Int)] = []
    var startedPlayingLectureIdInClosure: ((UUID, Int) -> Void)?

    func startedPlayingLecture(id: UUID, in second: Int) async {
        startedPlayingLectureIdInCallsCount += 1
        startedPlayingLectureIdInReceivedArguments = (id: id, second: second)
        startedPlayingLectureIdInReceivedInvocations.append((id: id, second: second))
        startedPlayingLectureIdInClosure?(id, second)
    }

    //MARK: - pausedLecture

    var pausedLectureIdInCallsCount = 0
    var pausedLectureIdInCalled: Bool {
        return pausedLectureIdInCallsCount > 0
    }
    var pausedLectureIdInReceivedArguments: (id: UUID, second: Int)?
    var pausedLectureIdInReceivedInvocations: [(id: UUID, second: Int)] = []
    var pausedLectureIdInClosure: ((UUID, Int) -> Void)?

    func pausedLecture(id: UUID, in second: Int) async {
        pausedLectureIdInCallsCount += 1
        pausedLectureIdInReceivedArguments = (id: id, second: second)
        pausedLectureIdInReceivedInvocations.append((id: id, second: second))
        pausedLectureIdInClosure?(id, second)
    }

    //MARK: - skippedLecture

    var skippedLectureIdCallsCount = 0
    var skippedLectureIdCalled: Bool {
        return skippedLectureIdCallsCount > 0
    }
    var skippedLectureIdReceivedId: UUID?
    var skippedLectureIdReceivedInvocations: [UUID] = []
    var skippedLectureIdClosure: ((UUID) -> Void)?

    func skippedLecture(id: UUID) async {
        skippedLectureIdCallsCount += 1
        skippedLectureIdReceivedId = id
        skippedLectureIdReceivedInvocations.append(id)
        skippedLectureIdClosure?(id)
    }

    //MARK: - donePlayingLecture

    var donePlayingLectureIdCallsCount = 0
    var donePlayingLectureIdCalled: Bool {
        return donePlayingLectureIdCallsCount > 0
    }
    var donePlayingLectureIdReceivedId: UUID?
    var donePlayingLectureIdReceivedInvocations: [UUID] = []
    var donePlayingLectureIdClosure: ((UUID) -> Void)?

    func donePlayingLecture(id: UUID) async {
        donePlayingLectureIdCallsCount += 1
        donePlayingLectureIdReceivedId = id
        donePlayingLectureIdReceivedInvocations.append(id)
        donePlayingLectureIdClosure?(id)
    }

    //MARK: - playLecture

    var playLectureIdCallsCount = 0
    var playLectureIdCalled: Bool {
        return playLectureIdCallsCount > 0
    }
    var playLectureIdReceivedId: UUID?
    var playLectureIdReceivedInvocations: [UUID] = []
    var playLectureIdClosure: ((UUID) -> Void)?

    func playLecture(id: UUID) async {
        playLectureIdCallsCount += 1
        playLectureIdReceivedId = id
        playLectureIdReceivedInvocations.append(id)
        playLectureIdClosure?(id)
    }

    //MARK: - addToQueueOnTop

    var addToQueueOnTopIdCallsCount = 0
    var addToQueueOnTopIdCalled: Bool {
        return addToQueueOnTopIdCallsCount > 0
    }
    var addToQueueOnTopIdReceivedId: UUID?
    var addToQueueOnTopIdReceivedInvocations: [UUID] = []
    var addToQueueOnTopIdClosure: ((UUID) -> Void)?

    func addToQueueOnTop(id: UUID) async {
        addToQueueOnTopIdCallsCount += 1
        addToQueueOnTopIdReceivedId = id
        addToQueueOnTopIdReceivedInvocations.append(id)
        addToQueueOnTopIdClosure?(id)
    }

    //MARK: - addToQueueAtBottom

    var addToQueueAtBottomIdCallsCount = 0
    var addToQueueAtBottomIdCalled: Bool {
        return addToQueueAtBottomIdCallsCount > 0
    }
    var addToQueueAtBottomIdReceivedId: UUID?
    var addToQueueAtBottomIdReceivedInvocations: [UUID] = []
    var addToQueueAtBottomIdClosure: ((UUID) -> Void)?

    func addToQueueAtBottom(id: UUID) async {
        addToQueueAtBottomIdCallsCount += 1
        addToQueueAtBottomIdReceivedId = id
        addToQueueAtBottomIdReceivedInvocations.append(id)
        addToQueueAtBottomIdClosure?(id)
    }

    //MARK: - removeFromQueue

    var removeFromQueueIdCallsCount = 0
    var removeFromQueueIdCalled: Bool {
        return removeFromQueueIdCallsCount > 0
    }
    var removeFromQueueIdReceivedId: UUID?
    var removeFromQueueIdReceivedInvocations: [UUID] = []
    var removeFromQueueIdClosure: ((UUID) -> Void)?

    func removeFromQueue(id: UUID) async {
        removeFromQueueIdCallsCount += 1
        removeFromQueueIdReceivedId = id
        removeFromQueueIdReceivedInvocations.append(id)
        removeFromQueueIdClosure?(id)
    }

    //MARK: - changeOrder

    var changeOrderIdFromToCallsCount = 0
    var changeOrderIdFromToCalled: Bool {
        return changeOrderIdFromToCallsCount > 0
    }
    var changeOrderIdFromToReceivedArguments: (id: UUID, origin: Int, destination: Int)?
    var changeOrderIdFromToReceivedInvocations: [(id: UUID, origin: Int, destination: Int)] = []
    var changeOrderIdFromToClosure: ((UUID, Int, Int) -> Void)?

    func changeOrder(id: UUID, from origin: Int, to destination: Int) async {
        changeOrderIdFromToCallsCount += 1
        changeOrderIdFromToReceivedArguments = (id: id, origin: origin, destination: destination)
        changeOrderIdFromToReceivedInvocations.append((id: id, origin: origin, destination: destination))
        changeOrderIdFromToClosure?(id, origin, destination)
    }

    //MARK: - willEnterForeground

    var willEnterForegroundCallsCount = 0
    var willEnterForegroundCalled: Bool {
        return willEnterForegroundCallsCount > 0
    }
    var willEnterForegroundClosure: (() -> Void)?

    func willEnterForeground() {
        willEnterForegroundCallsCount += 1
        willEnterForegroundClosure?()
    }

    //MARK: - didEnterForeground

    var didEnterForegroundCallsCount = 0
    var didEnterForegroundCalled: Bool {
        return didEnterForegroundCallsCount > 0
    }
    var didEnterForegroundClosure: (() -> Void)?

    func didEnterForeground() {
        didEnterForegroundCallsCount += 1
        didEnterForegroundClosure?()
    }

    //MARK: - willEnterBackground

    var willEnterBackgroundCallsCount = 0
    var willEnterBackgroundCalled: Bool {
        return willEnterBackgroundCallsCount > 0
    }
    var willEnterBackgroundClosure: (() -> Void)?

    func willEnterBackground() {
        willEnterBackgroundCallsCount += 1
        willEnterBackgroundClosure?()
    }

    //MARK: - didEnterBackground

    var didEnterBackgroundCallsCount = 0
    var didEnterBackgroundCalled: Bool {
        return didEnterBackgroundCallsCount > 0
    }
    var didEnterBackgroundClosure: (() -> Void)?

    func didEnterBackground() {
        didEnterBackgroundCallsCount += 1
        didEnterBackgroundClosure?()
    }

    //MARK: - attendToLocalNotification

    var attendToLocalNotificationIdentifierCallsCount = 0
    var attendToLocalNotificationIdentifierCalled: Bool {
        return attendToLocalNotificationIdentifierCallsCount > 0
    }
    var attendToLocalNotificationIdentifierReceivedIdentifier: String?
    var attendToLocalNotificationIdentifierReceivedInvocations: [String] = []
    var attendToLocalNotificationIdentifierClosure: ((String) -> Void)?

    func attendToLocalNotification(identifier: String) {
        attendToLocalNotificationIdentifierCallsCount += 1
        attendToLocalNotificationIdentifierReceivedIdentifier = identifier
        attendToLocalNotificationIdentifierReceivedInvocations.append(identifier)
        attendToLocalNotificationIdentifierClosure?(identifier)
    }

    //MARK: - start

    var startCallsCount = 0
    var startCalled: Bool {
        return startCallsCount > 0
    }
    var startClosure: (() -> Void)?

    func start() {
        startCallsCount += 1
        startClosure?()
    }

    //MARK: - stop

    var stopCallsCount = 0
    var stopCalled: Bool {
        return stopCallsCount > 0
    }
    var stopClosure: (() -> Void)?

    func stop() {
        stopCallsCount += 1
        stopClosure?()
    }

}
final class XCoordinationRequestProtocolMock: XCoordinationRequestProtocol {

    //MARK: - coordinate

    var coordinateFromRequestCallsCount = 0
    var coordinateFromRequestCalled: Bool {
        return coordinateFromRequestCallsCount > 0
    }
    var coordinateFromRequestReceivedArguments: (feature: XCoordinated, request: XCoordinationRequest)?
    var coordinateFromRequestReceivedInvocations: [(feature: XCoordinated, request: XCoordinationRequest)] = []
    var coordinateFromRequestClosure: ((XCoordinated, XCoordinationRequest) -> Void)?

    func coordinate(from feature: XCoordinated, request: XCoordinationRequest) {
        coordinateFromRequestCallsCount += 1
        coordinateFromRequestReceivedArguments = (feature: feature, request: request)
        coordinateFromRequestReceivedInvocations.append((feature: feature, request: request))
        coordinateFromRequestClosure?(feature, request)
    }

}
final class XCoordinatorServiceLifeCycleProtocolMock: XCoordinatorServiceLifeCycleProtocol {
    var coordinator: XCoordinationRequestProtocol?

    //MARK: - willEnterForeground

    var willEnterForegroundCallsCount = 0
    var willEnterForegroundCalled: Bool {
        return willEnterForegroundCallsCount > 0
    }
    var willEnterForegroundClosure: (() -> Void)?

    func willEnterForeground() {
        willEnterForegroundCallsCount += 1
        willEnterForegroundClosure?()
    }

    //MARK: - didEnterForeground

    var didEnterForegroundCallsCount = 0
    var didEnterForegroundCalled: Bool {
        return didEnterForegroundCallsCount > 0
    }
    var didEnterForegroundClosure: (() -> Void)?

    func didEnterForeground() {
        didEnterForegroundCallsCount += 1
        didEnterForegroundClosure?()
    }

    //MARK: - willEnterBackground

    var willEnterBackgroundCallsCount = 0
    var willEnterBackgroundCalled: Bool {
        return willEnterBackgroundCallsCount > 0
    }
    var willEnterBackgroundClosure: (() -> Void)?

    func willEnterBackground() {
        willEnterBackgroundCallsCount += 1
        willEnterBackgroundClosure?()
    }

    //MARK: - didEnterBackground

    var didEnterBackgroundCallsCount = 0
    var didEnterBackgroundCalled: Bool {
        return didEnterBackgroundCallsCount > 0
    }
    var didEnterBackgroundClosure: (() -> Void)?

    func didEnterBackground() {
        didEnterBackgroundCallsCount += 1
        didEnterBackgroundClosure?()
    }

    //MARK: - attendToLocalNotification

    var attendToLocalNotificationIdentifierCallsCount = 0
    var attendToLocalNotificationIdentifierCalled: Bool {
        return attendToLocalNotificationIdentifierCallsCount > 0
    }
    var attendToLocalNotificationIdentifierReceivedIdentifier: String?
    var attendToLocalNotificationIdentifierReceivedInvocations: [String] = []
    var attendToLocalNotificationIdentifierClosure: ((String) -> Void)?

    func attendToLocalNotification(identifier: String) {
        attendToLocalNotificationIdentifierCallsCount += 1
        attendToLocalNotificationIdentifierReceivedIdentifier = identifier
        attendToLocalNotificationIdentifierReceivedInvocations.append(identifier)
        attendToLocalNotificationIdentifierClosure?(identifier)
    }

    //MARK: - start

    var startCallsCount = 0
    var startCalled: Bool {
        return startCallsCount > 0
    }
    var startClosure: (() -> Void)?

    func start() {
        startCallsCount += 1
        startClosure?()
    }

    //MARK: - stop

    var stopCallsCount = 0
    var stopCalled: Bool {
        return stopCallsCount > 0
    }
    var stopClosure: (() -> Void)?

    func stop() {
        stopCallsCount += 1
        stopClosure?()
    }

}
final class XCoordinatorServiceProtocolMock: XCoordinatorServiceProtocol {
    var coordinator: XCoordinationRequestProtocol?

    //MARK: - attendToLocalNotification

    var attendToLocalNotificationIdentifierCallsCount = 0
    var attendToLocalNotificationIdentifierCalled: Bool {
        return attendToLocalNotificationIdentifierCallsCount > 0
    }
    var attendToLocalNotificationIdentifierReceivedIdentifier: String?
    var attendToLocalNotificationIdentifierReceivedInvocations: [String] = []
    var attendToLocalNotificationIdentifierClosure: ((String) -> Void)?

    func attendToLocalNotification(identifier: String) {
        attendToLocalNotificationIdentifierCallsCount += 1
        attendToLocalNotificationIdentifierReceivedIdentifier = identifier
        attendToLocalNotificationIdentifierReceivedInvocations.append(identifier)
        attendToLocalNotificationIdentifierClosure?(identifier)
    }

    //MARK: - start

    var startCallsCount = 0
    var startCalled: Bool {
        return startCallsCount > 0
    }
    var startClosure: (() -> Void)?

    func start() {
        startCallsCount += 1
        startClosure?()
    }

    //MARK: - stop

    var stopCallsCount = 0
    var stopCalled: Bool {
        return stopCallsCount > 0
    }
    var stopClosure: (() -> Void)?

    func stop() {
        stopCallsCount += 1
        stopClosure?()
    }

}
