// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

/// The `CoordinatorProtocol` define what a coordinator should provide to its users.
/// All coordinators in the system should conform to this protocol. This will allow us
/// to build a tree of coordinator and defer coordination tasks to other members of the
/// tree.
public protocol XCoordinatorProtocol {

    func start()
    func stop()
    var isStarted: Bool { get set }
    var parentCoordinator: XCoordinatorRequestProtocol? { get set }
    var childCoordinators: [ XCoordinatorProtocol] { get set }

    mutating func addChild(_ newChild: XCoordinatorProtocol)
    mutating func removeChild(_ child: XCoordinatorProtocol)
}

extension XCoordinatorProtocol {

    mutating func addChild(_ newChild: XCoordinatorProtocol) {
        childCoordinators.append(newChild)
    }

    mutating func removeChild(_ child: XCoordinatorProtocol) {
        // Not implemented. Not sure if removing a child will be needed.
    }
}
