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

@testable import XLogin; import XEntities; import XCoordinator;














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
final class XLoginServicesInterfaceMock: XLoginServicesInterface {

    //MARK: - saveUser

    var saveUserNameThrowableError: Error?
    var saveUserNameCallsCount = 0
    var saveUserNameCalled: Bool {
        return saveUserNameCallsCount > 0
    }
    var saveUserNameReceivedName: String?
    var saveUserNameReceivedInvocations: [String] = []
    var saveUserNameClosure: ((String) throws -> Void)?

    func saveUser(name: String) async throws {
        if let error = saveUserNameThrowableError {
            throw error
        }
        saveUserNameCallsCount += 1
        saveUserNameReceivedName = name
        saveUserNameReceivedInvocations.append(name)
        try saveUserNameClosure?(name)
    }

}
