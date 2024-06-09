// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

/// The `XCoordinatorRequest` defines the actions that any feature
/// could request using the `XCoordinatorRequestProtocol`.
///
/// Whenever a feature request a coordination it should use one of this
/// actions. This means that this file will contains all the possible actions that
/// can be performed in the application. This is not ideal, but it the desing
/// choosen for this application.
public enum XCoordinatorRequest: String, Equatable {
    // Please, keep this list sorted alphabetically.

    // Generic request.
    // Those request that not pointing to something specific
    case dismiss
    case done
    case logoout

    // Specific requests.
    // Those request that direct to a concrete feature.
    // e.g.: `case showPlayer`
}
