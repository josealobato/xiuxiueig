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

@testable import XLectureDetails; import XEntities; import XCoordinator;














final class InteractorInputMock: InteractorInput {

    //MARK: - request

    var requestCallsCount = 0
    var requestCalled: Bool {
        return requestCallsCount > 0
    }
    var requestReceivedEvent: InteractorEvents.Input?
    var requestReceivedInvocations: [InteractorEvents.Input] = []
    var requestClosure: ((InteractorEvents.Input) -> Void)?

    func request(_ event: InteractorEvents.Input) async {
        requestCallsCount += 1
        requestReceivedEvent = event
        requestReceivedInvocations.append(event)
        requestClosure?(event)
    }

}
final class InteractorOutputMock: InteractorOutput {

    //MARK: - dispatch

    var dispatchCallsCount = 0
    var dispatchCalled: Bool {
        return dispatchCallsCount > 0
    }
    var dispatchReceivedEvent: InteractorEvents.Output?
    var dispatchReceivedInvocations: [InteractorEvents.Output] = []
    var dispatchClosure: ((InteractorEvents.Output) -> Void)?

    func dispatch(_ event: InteractorEvents.Output) {
        dispatchCallsCount += 1
        dispatchReceivedEvent = event
        dispatchReceivedInvocations.append(event)
        dispatchClosure?(event)
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

    //MARK: - process

    var processSystemEventCallsCount = 0
    var processSystemEventCalled: Bool {
        return processSystemEventCallsCount > 0
    }
    var processSystemEventReceivedEvent: XCoordinatorSystemEvents?
    var processSystemEventReceivedInvocations: [XCoordinatorSystemEvents] = []
    var processSystemEventClosure: ((XCoordinatorSystemEvents) -> Void)?

    func process(systemEvent event: XCoordinatorSystemEvents) {
        processSystemEventCallsCount += 1
        processSystemEventReceivedEvent = event
        processSystemEventReceivedInvocations.append(event)
        processSystemEventClosure?(event)
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
final class XLectureDetailsServiceInterfaceMock: XLectureDetailsServiceInterface {

    //MARK: - lecture

    var lectureWithIdThrowableError: Error?
    var lectureWithIdCallsCount = 0
    var lectureWithIdCalled: Bool {
        return lectureWithIdCallsCount > 0
    }
    var lectureWithIdReceivedId: UUID?
    var lectureWithIdReceivedInvocations: [UUID] = []
    var lectureWithIdReturnValue: LectureEntity!
    var lectureWithIdClosure: ((UUID) throws -> LectureEntity)?

    func lecture(withId id: UUID) async throws -> LectureEntity {
        if let error = lectureWithIdThrowableError {
            throw error
        }
        lectureWithIdCallsCount += 1
        lectureWithIdReceivedId = id
        lectureWithIdReceivedInvocations.append(id)
        return try lectureWithIdClosure.map({ try $0(id) }) ?? lectureWithIdReturnValue
    }

    //MARK: - categories

    var categoriesThrowableError: Error?
    var categoriesCallsCount = 0
    var categoriesCalled: Bool {
        return categoriesCallsCount > 0
    }
    var categoriesReturnValue: [CategoryEntity]!
    var categoriesClosure: (() throws -> [CategoryEntity])?

    func categories() async throws -> [CategoryEntity] {
        if let error = categoriesThrowableError {
            throw error
        }
        categoriesCallsCount += 1
        return try categoriesClosure.map({ try $0() }) ?? categoriesReturnValue
    }

    //MARK: - save

    var saveLectureThrowableError: Error?
    var saveLectureCallsCount = 0
    var saveLectureCalled: Bool {
        return saveLectureCallsCount > 0
    }
    var saveLectureReceivedLecture: LectureEntity?
    var saveLectureReceivedInvocations: [LectureEntity] = []
    var saveLectureClosure: ((LectureEntity) throws -> Void)?

    func save(lecture: LectureEntity) async throws {
        if let error = saveLectureThrowableError {
            throw error
        }
        saveLectureCallsCount += 1
        saveLectureReceivedLecture = lecture
        saveLectureReceivedInvocations.append(lecture)
        try saveLectureClosure?(lecture)
    }

}
