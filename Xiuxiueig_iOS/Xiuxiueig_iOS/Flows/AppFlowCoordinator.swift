// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI
import XCoordinator
import XToolKit

/// The `AppFlowCoordinator` is the root coordinator of the application.
/// It will be the last coordinator on attending an event.
/// It is also the entry point of the application
final class AppFlowCoordinator: XCoordinatorProtocol, ObservableObject {

    enum State {
        case loggedOut
        case onboarding
        case loggedIn
    }

    @Published var state: State = .loggedOut
    func updateState(_ state: State) {
        DispatchQueue.main.async {
            self.state = state
        }
    }

    let logger = XLog.logger(category: "AppFlowCoordinator")
    var isStarted: Bool = false

    var parentCoordinator: (any XCoordinator.XCoordinationRequestProtocol)?

    var childCoordinators: [any XCoordinator.XCoordinatorProtocol] = []

    init() {
        logger.debug("init AppFlowCoordinator")
    }

    deinit {
        logger.debug("init AppFlowCoordinator")
    }

    func start() {
        logger.debug("start AppFlowCoordinator")
        isStarted = true
    }

    func stop() {
        logger.debug("stop AppFlowCoordinator")
        isStarted = false
    }

    // Temporal solution to hold the child flow coordinators instead of using the
    // `childCoordinators` array. Under investigation to check if it is worth the
    // complexity.
    var loggedInCoordinator: LoggedInFlowCoordinator?
}

///
/// This extension provides the view associated with the Coordinator
///
extension AppFlowCoordinator {

    @ViewBuilder
    func baseCoordinatorView() -> some View {
        VStack {
            switch state {
            case .loggedOut: loggedOutView()
            case .onboarding: onboardingView()
            case .loggedIn: loggedInView()
            }
        }
    }
}
