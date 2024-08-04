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

@testable import XPlayer; import XEntities; import XCoordinator;














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
final class XPlayerServiceInterfaceMock: XPlayerServiceInterface {

    //MARK: - nextLecture

    var nextLectureThrowableError: Error?
    var nextLectureCallsCount = 0
    var nextLectureCalled: Bool {
        return nextLectureCallsCount > 0
    }
    var nextLectureReturnValue: XPlayerLecture?
    var nextLectureClosure: (() throws -> XPlayerLecture?)?

    func nextLecture() async throws -> XPlayerLecture? {
        if let error = nextLectureThrowableError {
            throw error
        }
        nextLectureCallsCount += 1
        return try nextLectureClosure.map({ try $0() }) ?? nextLectureReturnValue
    }

    //MARK: - playing

    var playingIdInCallsCount = 0
    var playingIdInCalled: Bool {
        return playingIdInCallsCount > 0
    }
    var playingIdInReceivedArguments: (id: UUID, second: Int)?
    var playingIdInReceivedInvocations: [(id: UUID, second: Int)] = []
    var playingIdInClosure: ((UUID, Int) -> Void)?

    func playing(id: UUID, in second: Int) async {
        playingIdInCallsCount += 1
        playingIdInReceivedArguments = (id: id, second: second)
        playingIdInReceivedInvocations.append((id: id, second: second))
        playingIdInClosure?(id, second)
    }

    //MARK: - paused

    var pausedIdInCallsCount = 0
    var pausedIdInCalled: Bool {
        return pausedIdInCallsCount > 0
    }
    var pausedIdInReceivedArguments: (id: UUID, second: Int)?
    var pausedIdInReceivedInvocations: [(id: UUID, second: Int)] = []
    var pausedIdInClosure: ((UUID, Int) -> Void)?

    func paused(id: UUID, in second: Int) async {
        pausedIdInCallsCount += 1
        pausedIdInReceivedArguments = (id: id, second: second)
        pausedIdInReceivedInvocations.append((id: id, second: second))
        pausedIdInClosure?(id, second)
    }

    //MARK: - skipped

    var skippedIdInCallsCount = 0
    var skippedIdInCalled: Bool {
        return skippedIdInCallsCount > 0
    }
    var skippedIdInReceivedArguments: (id: UUID, second: Int)?
    var skippedIdInReceivedInvocations: [(id: UUID, second: Int)] = []
    var skippedIdInClosure: ((UUID, Int) -> Void)?

    func skipped(id: UUID, in second: Int) async {
        skippedIdInCallsCount += 1
        skippedIdInReceivedArguments = (id: id, second: second)
        skippedIdInReceivedInvocations.append((id: id, second: second))
        skippedIdInClosure?(id, second)
    }

    //MARK: - donePlaying

    var donePlayingIdThrowableError: Error?
    var donePlayingIdCallsCount = 0
    var donePlayingIdCalled: Bool {
        return donePlayingIdCallsCount > 0
    }
    var donePlayingIdReceivedId: UUID?
    var donePlayingIdReceivedInvocations: [UUID] = []
    var donePlayingIdClosure: ((UUID) throws -> Void)?

    func donePlaying(id: UUID) async throws {
        if let error = donePlayingIdThrowableError {
            throw error
        }
        donePlayingIdCallsCount += 1
        donePlayingIdReceivedId = id
        donePlayingIdReceivedInvocations.append(id)
        try donePlayingIdClosure?(id)
    }

}
