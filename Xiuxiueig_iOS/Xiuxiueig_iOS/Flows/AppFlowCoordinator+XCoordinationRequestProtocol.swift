// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XCoordinator

///
/// Conformance of the `XCoordinatorRequestProtocol` of the `AppFlowCoordinator`
///
extension AppFlowCoordinator: XCoordinationRequestProtocol {

    func coordinate(from feature: XCoordinator.XCoordinated, request: XCoordinator.XCoordinationRequest) {

        guard isStarted else { return }
        logger.debug(
            "AppFlowCoordinator: feature \(feature.rawValue) request \(request)"
        )

        // Before processing the request we want to load the preferences, because any feature
        // could have updated the preferences and we want the latest state before procceding
        // with any action.
        loadPreferences()

        switch feature {
        case .xLogin:
            // Change the state to Onboarding only if the context can be built (only userName in this case)
            if case .done = request, let userName = userName {
                updateState(.onboarding(userName: userName))
            }
        case .xOnboarding:
            if case .done = request,
               // Change the state to logged in only if the context can be built.
               let context = loggedInFlowContextBuilder() {
                updateState(.loggedIn(context: context))
            }
        default:
            logger.debug(
                "AppFlowCoordinator: Nothing to coordinate for feature \(feature.rawValue) and request \(request)"
            )
        }
    }
}
