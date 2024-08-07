// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XToolKit

/// A coordinator services can be attached to a Coordinator to be controlled
/// within the flow of the coordinator.
public protocol XCoordinatorServiceProtocol: AutoMockable, AnyObject {

    /// Access to a coordinator.
    /// The services can access the coordinator to request coordination as a
    /// result of one its actions.
    /// NOTE: Use weak on its implementation.
    var coordinator: XCoordinationRequestProtocol? { get set }

    /// When the service receives a local notification this will be called
    /// - Parameter identifier: the identifier used for the local notification
    func attendToLocalNotification(identifier: String)

    /// Start the coordination service.
    func start()

    /// Stop the coordination service.
    func stop()
}

public extension XCoordinatorServiceProtocol {

    // By default the services do nothing on nofication call
    func attendToLocalNotification(identifier: String) { }
}

/// A service that is aware of the app life cycle.
/// Sometimes a service needs to know about the basic life cycle events of the
/// application. In that case this is a specializatio of the basic one.
public protocol XCoordinatorServiceLifeCycleProtocol: XCoordinatorServiceProtocol {

    func process(systemEvent event: XCoordinatorSystemEvents)
}

/// Extension to provide default implementation.
public extension XCoordinatorServiceLifeCycleProtocol {

    func process(systemEvent event: XCoordinatorSystemEvents) {
        /* Nothing to do */
    }
}
