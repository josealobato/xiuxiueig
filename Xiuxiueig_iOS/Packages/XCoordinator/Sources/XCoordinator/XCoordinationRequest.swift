// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

/// The `XCoordinatorRequest` defines the actions that any feature
/// could request using the `XCoordinatorRequestProtocol`.
///
/// Whenever a feature request a coordination it should use one of this
/// actions. This means that this file will contains all the possible actions that
/// can be performed in the application. This is not ideal, but it the desing
/// choosen for this application.
public enum XCoordinationRequest: Equatable {
    // Please, keep this list sorted alphabetically.

    // Generic request.
    // Those request that not pointing to something specific
    case dismiss
    case done
    case logoOut

    // Specific requests.
    // Those request that direct to a concrete feature.
    // e.g.: `case showPlayer`
    case showLectureDetails(id: String)

    // MARK: - Equatable
    public static func == (lhs: XCoordinationRequest, rhs: XCoordinationRequest) -> Bool {

        /// This case list is potentially lengthy,
        /// so please keep it sorted alphabetically.
        switch (lhs, rhs) {

        case (.dismiss, .dismiss): return true
        case (.done, .done): return true
        case (.logoOut, .logoOut): return true

        case let (.showLectureDetails(lhsId), .showLectureDetails(rhsId)): return lhsId == rhsId

        default: return false
        }
    }
}

extension XCoordinationRequest: CustomStringConvertible {
    public var description: String {
        switch self {
        case .dismiss: return "dismiss"
        case .done: return "done"
        case .logoOut: return "logoout"
        case .showLectureDetails: return "showLectureDetails"
        }
    }
}
