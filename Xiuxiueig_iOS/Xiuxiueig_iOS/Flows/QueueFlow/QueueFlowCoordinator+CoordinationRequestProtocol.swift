// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XCoordinator

///
/// Conformance of the `XCoordinationRequestProtocol` of the `CollectionFlowCoordinator`
///
extension QueueFlowCoordinator: XCoordinationRequestProtocol {

    func coordinate(from feature: XCoordinated, request: XCoordinator.XCoordinationRequest) {

        guard isStarted else { return }

        switch feature {
        case .xLectureCollection: onLectureCollectionRequest(request: request)
        default:
            logger.debug(
                "Coordinator: Nothing to coordinate for feature \(feature.rawValue) and request \(request)"
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

    /// Manage all request by the Lecture Collection Feature
    /// - Parameter request: the request to handle.
    func onLectureCollectionRequest(request: XCoordinationRequest) {
        switch request {
        case .showLectureDetails(let id): push(.lectureDetails(id))
        default: logger.debug("Request not handled \(request)")
        }
    }
}
