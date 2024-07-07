// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

/// The `CoordinatorProtocol` define what a coordinator should provide to its users.
/// All coordinators in the system should conform to this protocol. This will allow us
/// to build a tree of coordinator and defer coordination tasks to other members of the
/// tree.
public protocol XCoordinatorProtocol: AnyObject {

    /// Start the coordinator.
    /// After that the coordinator shoiuld able to proccess coordination request.
    func start()

    /// Stop the coordinator
    /// After this point all coordination request will be ignored.
    func stop()

    /// Informs if the Coordinator is started, so attending requests.
    var isStarted: Bool { get set }

    /// Pointer back to the parent coordinator.
    /// This value is filled by the parent coordinator on creation.
    /// Make sure that the implementation is `weak` because the parent will
    /// also hold reference to all childs.
    var parentCoordinator: XCoordinationRequestProtocol? { get set }

    /// Holding refenreces to all child coordinators on creation.
    var childCoordinators: [XCoordinatorProtocol] { get set }

    // MARK: - Child Coordinator management

    func addChild(_ newChild: XCoordinatorProtocol)
    func removeChild(_ child: XCoordinatorProtocol)
    func removeAllChilds()

    /// Get a child of the given type.
    /// - Parameter type: The type of the child coordinator to get.
    /// - Returns: The existing instance in the child array if any.
    func getChild<T>(ofType type: T.Type) -> XCoordinatorProtocol?
}

/// Extension implementing a version of the child coordinator management.
public extension XCoordinatorProtocol {

    func addChild(_ newChild: XCoordinatorProtocol) {
        childCoordinators.append(newChild)
    }

    func removeChild(_ child: XCoordinatorProtocol) {
        childCoordinators.removeAll { $0 === child }
    }

    func removeAllChilds() {
        childCoordinators.removeAll()
    }

    func getChild<T>(ofType type: T.Type) -> XCoordinatorProtocol? {
        return childCoordinators.first { $0 is T }
    }
}
