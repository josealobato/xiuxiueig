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

@testable import MediaConsistencyService; import XCoordinator; import XRepositories; import MediaFileSystem;














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
final class MediaConsistencyServiceInterfaceMock: MediaConsistencyServiceInterface {
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
final class MediaFileSystemIntefaceMock: MediaFileSystemInteface {

    //MARK: - managedFiles

    var managedFilesCallsCount = 0
    var managedFilesCalled: Bool {
        return managedFilesCallsCount > 0
    }
    var managedFilesReturnValue: [MediaFile]!
    var managedFilesClosure: (() -> [MediaFile])?

    func managedFiles() -> [MediaFile] {
        managedFilesCallsCount += 1
        return managedFilesClosure.map({ $0() }) ?? managedFilesReturnValue
    }

    //MARK: - unmanagedFiles

    var unmanagedFilesCallsCount = 0
    var unmanagedFilesCalled: Bool {
        return unmanagedFilesCallsCount > 0
    }
    var unmanagedFilesReturnValue: [MediaFile]!
    var unmanagedFilesClosure: (() -> [MediaFile])?

    func unmanagedFiles() -> [MediaFile] {
        unmanagedFilesCallsCount += 1
        return unmanagedFilesClosure.map({ $0() }) ?? unmanagedFilesReturnValue
    }

    //MARK: - archivedFiles

    var archivedFilesCallsCount = 0
    var archivedFilesCalled: Bool {
        return archivedFilesCallsCount > 0
    }
    var archivedFilesReturnValue: [MediaFile]!
    var archivedFilesClosure: (() -> [MediaFile])?

    func archivedFiles() -> [MediaFile] {
        archivedFilesCallsCount += 1
        return archivedFilesClosure.map({ $0() }) ?? archivedFilesReturnValue
    }

    //MARK: - discardedFiles

    var discardedFilesCallsCount = 0
    var discardedFilesCalled: Bool {
        return discardedFilesCallsCount > 0
    }
    var discardedFilesReturnValue: [MediaFile]!
    var discardedFilesClosure: (() -> [MediaFile])?

    func discardedFiles() -> [MediaFile] {
        discardedFilesCallsCount += 1
        return discardedFilesClosure.map({ $0() }) ?? discardedFilesReturnValue
    }

    //MARK: - updateFile

    var updateFileFileCallsCount = 0
    var updateFileFileCalled: Bool {
        return updateFileFileCallsCount > 0
    }
    var updateFileFileReceivedFile: MediaFile?
    var updateFileFileReceivedInvocations: [MediaFile] = []
    var updateFileFileReturnValue: MediaFile?
    var updateFileFileClosure: ((MediaFile) -> MediaFile?)?

    func updateFile(file: MediaFile) -> MediaFile? {
        updateFileFileCallsCount += 1
        updateFileFileReceivedFile = file
        updateFileFileReceivedInvocations.append(file)
        return updateFileFileClosure.map({ $0(file) }) ?? updateFileFileReturnValue
    }

    //MARK: - manageFile

    var manageFileFileCallsCount = 0
    var manageFileFileCalled: Bool {
        return manageFileFileCallsCount > 0
    }
    var manageFileFileReceivedFile: MediaFile?
    var manageFileFileReceivedInvocations: [MediaFile] = []
    var manageFileFileReturnValue: MediaFile?
    var manageFileFileClosure: ((MediaFile) -> MediaFile?)?

    func manageFile(file: MediaFile) -> MediaFile? {
        manageFileFileCallsCount += 1
        manageFileFileReceivedFile = file
        manageFileFileReceivedInvocations.append(file)
        return manageFileFileClosure.map({ $0(file) }) ?? manageFileFileReturnValue
    }

    //MARK: - archiveFile

    var archiveFileFileCallsCount = 0
    var archiveFileFileCalled: Bool {
        return archiveFileFileCallsCount > 0
    }
    var archiveFileFileReceivedFile: MediaFile?
    var archiveFileFileReceivedInvocations: [MediaFile] = []
    var archiveFileFileReturnValue: MediaFile?
    var archiveFileFileClosure: ((MediaFile) -> MediaFile?)?

    func archiveFile(file: MediaFile) -> MediaFile? {
        archiveFileFileCallsCount += 1
        archiveFileFileReceivedFile = file
        archiveFileFileReceivedInvocations.append(file)
        return archiveFileFileClosure.map({ $0(file) }) ?? archiveFileFileReturnValue
    }

    //MARK: - unarchiveFile

    var unarchiveFileFileCallsCount = 0
    var unarchiveFileFileCalled: Bool {
        return unarchiveFileFileCallsCount > 0
    }
    var unarchiveFileFileReceivedFile: MediaFile?
    var unarchiveFileFileReceivedInvocations: [MediaFile] = []
    var unarchiveFileFileReturnValue: MediaFile?
    var unarchiveFileFileClosure: ((MediaFile) -> MediaFile?)?

    func unarchiveFile(file: MediaFile) -> MediaFile? {
        unarchiveFileFileCallsCount += 1
        unarchiveFileFileReceivedFile = file
        unarchiveFileFileReceivedInvocations.append(file)
        return unarchiveFileFileClosure.map({ $0(file) }) ?? unarchiveFileFileReturnValue
    }

    //MARK: - deleteFile

    var deleteFileFileCallsCount = 0
    var deleteFileFileCalled: Bool {
        return deleteFileFileCallsCount > 0
    }
    var deleteFileFileReceivedFile: MediaFile?
    var deleteFileFileReceivedInvocations: [MediaFile] = []
    var deleteFileFileClosure: ((MediaFile) -> Void)?

    func deleteFile(file: MediaFile) {
        deleteFileFileCallsCount += 1
        deleteFileFileReceivedFile = file
        deleteFileFileReceivedInvocations.append(file)
        deleteFileFileClosure?(file)
    }

    //MARK: - discardFile

    var discardFileFileCallsCount = 0
    var discardFileFileCalled: Bool {
        return discardFileFileCallsCount > 0
    }
    var discardFileFileReceivedFile: MediaFile?
    var discardFileFileReceivedInvocations: [MediaFile] = []
    var discardFileFileReturnValue: MediaFile?
    var discardFileFileClosure: ((MediaFile) -> MediaFile?)?

    func discardFile(file: MediaFile) -> MediaFile? {
        discardFileFileCallsCount += 1
        discardFileFileReceivedFile = file
        discardFileFileReceivedInvocations.append(file)
        return discardFileFileClosure.map({ $0(file) }) ?? discardFileFileReturnValue
    }

    //MARK: - resetDefaultMediaFiles

    var resetDefaultMediaFilesCallsCount = 0
    var resetDefaultMediaFilesCalled: Bool {
        return resetDefaultMediaFilesCallsCount > 0
    }
    var resetDefaultMediaFilesClosure: (() -> Void)?

    func resetDefaultMediaFiles() {
        resetDefaultMediaFilesCallsCount += 1
        resetDefaultMediaFilesClosure?()
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
