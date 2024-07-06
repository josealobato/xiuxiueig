// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI
import XCoordinator
import XToolKit
import XPreferences

/// The `AppFlowCoordinator` is the root coordinator of the application.
/// It will be the last coordinator on attending an event.
/// It is also the entry point of the application
final class AppFlowCoordinator: XCoordinatorProtocol, ObservableObject {

    enum State {
        case loggedOut
        case onboarding(userName: String)
        case loggedIn(context: LoggedInFlowContext)
    }

    @Published var state: State = .loggedOut
    func updateState(_ state: State) {
        DispatchQueue.main.async {
            self.state = state
        }
    }

    let logger = XLog.logger(category: "AppFlowCoordinator")
    let prefereces = XPreferencesManagerBuilder.build()
    var isStarted: Bool = false

    var userName: String?
    var onboardingPerformed: Bool? = false

    var parentCoordinator: (any XCoordinator.XCoordinationRequestProtocol)?

    var childCoordinators: [any XCoordinator.XCoordinatorProtocol] = []

    init() {
        logger.debug("init AppFlowCoordinator")
        loadPreferences()
        logger.debug("Loaded user name: \(self.userName ?? "No user name yet") and onboarding \((self.onboardingPerformed ?? false) ? "done" : "not done").")
    }

    deinit {
        logger.debug("init AppFlowCoordinator")
    }

    func start() {
        logger.debug("start AppFlowCoordinator")
        setUpStartingState()
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

    func setUpStartingState() {
        // If there is already a user go to the onboarding directly.
        if let userName = userName {
            // If the onboad has already be done, go to the app directly
            if let onboardingPerformed = onboardingPerformed,
               onboardingPerformed == true,
               // but only if you can build its context!
               let loggedInFlowContext = loggedInFlowContextBuilder() {

                // Launch the App
                state = .loggedIn(context: loggedInFlowContext)
            } else {

                // Go to the Onboarding page
                state = .onboarding(userName: userName)
            }
        } // Otherwise stay in the login page.
    }

    func loadPreferences() {
        prefereces.declarePreference(key: PreferencesKeys.userName.rawValue,
                                     defaultValue: nil as String?,
                                     mode: .universal)
        prefereces.declarePreference(key: PreferencesKeys.onboardingPerformed.rawValue,
                                     defaultValue: false,
                                     mode: .universal)
        userName = prefereces.preference(for: PreferencesKeys.userName.rawValue)
        onboardingPerformed = prefereces.preference(for: PreferencesKeys.onboardingPerformed.rawValue)
    }
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
            case .onboarding(let name): onboardingView(userName: name)
            case .loggedIn(let context): loggedInView(context: context)
            }
        }
    }
}
