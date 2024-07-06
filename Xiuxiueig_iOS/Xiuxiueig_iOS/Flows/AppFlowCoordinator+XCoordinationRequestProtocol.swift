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

        switch feature {
        case .xLogin:
            if case .done = request, let userName = userName {
                updateState(.onboarding(userName: userName))
            }
        case .xOnboarding:
            if case .done = request {
                updateState(.loggedIn)
            }
        default:
            logger.debug(
                "AppFlowCoordinator: Nothing to coordinate for feature \(feature.rawValue) and request \(request)"
            )
        }
    }
}
