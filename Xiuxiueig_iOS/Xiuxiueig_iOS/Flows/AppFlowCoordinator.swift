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

    @ViewBuilder
    private func loggedOutView() -> some View {
        VStack {
            Text("Logged Out")
            Button {
                self.state = .onboarding
            } label: {
                Text("Next")
            }
        }
    }

    @ViewBuilder
    private func onboardingView() -> some View {
        VStack {
            Text("Onboarding")
            Button {
                self.state = .loggedIn
            } label: {
                Text("Next")
            }
        }
    }

    @ViewBuilder
    private func loggedInView() -> some View {
        LoggedInFlowView(coordinator: buildLoggedInCoordinator())
    }

    private func buildLoggedInCoordinator() -> LoggedInFlowCoordinator {
        if let coordinator = loggedInCoordinator {
            return coordinator
        } else {
            let coordinator = LoggedInFlowCoordinator()
            coordinator.parentCoordinator = self
            loggedInCoordinator = coordinator
            return coordinator
        }
    }
}

// MARK: - CoordinatorRequestProtocol

///
/// Conformance of the `XCoordinatorRequestProtocol` of the `AppFlowCoordinator`
///
extension AppFlowCoordinator: XCoordinationRequestProtocol {

    func coordinate(from feature: XCoordinator.XCoordinated, request: XCoordinator.XCoordinationRequest) {

        guard isStarted else { return }

        switch feature {
        default:
            logger.debug(
                "AppFlowCoordinator: Nothing to coordinate for feature \(feature.rawValue) and request \(request)"
            )
        }
    }
}
