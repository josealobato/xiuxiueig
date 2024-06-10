// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI
import XCoordinator

/// The `AppFlowCoordinator` is the root coordinator of the application.
/// It will be the last coordinator on attending an event.
final class AppFlowCoordinator: XCoordinatorProtocol, ObservableObject {

    var isStarted: Bool = false

    var parentCoordinator: (any XCoordinator.XCoordinatorRequestProtocol)?

    var childCoordinators: [any XCoordinator.XCoordinatorProtocol] = []

    init() {
        print("init AppFlowCoordinator")
    }

    deinit {
        print("init AppFlowCoordinator")
    }

    func start() {
        print("start AppFlowCoordinator")
        isStarted = true
    }

    func stop() {
        isStarted = false
    }
}

///
/// This extension provides the view associated with the Coordinator
///
extension AppFlowCoordinator {

    @ViewBuilder
    func baseCoordinatorView() -> some View {
        VStack {
            if !isStarted {
                Text("starting")
            } else {
                Text("Started")
            }
        }
    }
}

// MARK: - CoordinatorRequestProtocol

///
/// Conformance of the `XCoordinatorRequestProtocol` of the `AppFlowCoordinator`
///
extension AppFlowCoordinator: XCoordinatorRequestProtocol {

    func coordinate(from feature: XCoordinator.XCoordinated, request: XCoordinator.XCoordinatorRequest) {

        switch feature {
        default:
            print("Coordinator: Nothing to coordinate for feature \(feature) and request \(request)")
        }
    }
}
