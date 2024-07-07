// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XCoordinator

///
/// Conformance of the `XCoordinationRequestProtocol` of the `PlayerFlowCoordinator`
///
extension PlayerFlowCoordinator: XCoordinationRequestProtocol {

    func coordinate(from feature: XCoordinator.XCoordinated, request: XCoordinator.XCoordinationRequest) {

        guard isStarted else { return }

        switch feature {
            // No Coordinated features yet.
        default:
            logger.debug("""
                PlayerFlowCoordinator: Nothing to coordinate for feature \(feature.rawValue)
                and request \(request). Deferring to parent.
                """
            )
            parentCoordinator?.coordinate(from: feature, request: request)
        }
    }

    // MARK: - Request management

    // Every feature could do several different request.
    // Here the coordinator decides what every request should do, by having a method for
    // every feature
    // The Feature itself just request an action, but how it is handled
    // is coordinator's responsibility.

}
