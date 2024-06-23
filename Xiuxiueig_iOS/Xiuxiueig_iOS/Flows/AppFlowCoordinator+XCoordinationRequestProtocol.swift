// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XCoordinator

///
/// Conformance of the `XCoordinatorRequestProtocol` of the `AppFlowCoordinator`
///
extension AppFlowCoordinator: XCoordinationRequestProtocol {

    func coordinate(from feature: XCoordinator.XCoordinated, request: XCoordinator.XCoordinationRequest) {

        guard isStarted else { return }

        switch feature {
        case .xLogin:
            if case .done = request {
                updateState(.onboarding)
            }
        default:
            logger.debug(
                "AppFlowCoordinator: Nothing to coordinate for feature \(feature.rawValue) and request \(request)"
            )
        }
    }
}
