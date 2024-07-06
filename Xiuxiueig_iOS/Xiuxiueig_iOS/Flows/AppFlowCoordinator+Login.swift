// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI
import XCoordinator
import XLogin

extension AppFlowCoordinator {

    @ViewBuilder
    /// Create the feature for log in.
    /// **Notice** that the logged out state does no require context.
    /// - Returns: The login view ready to use
    func loggedOutView() -> some View {
        let adapter = XLoginAdapter()
        XLoginBuilder.build(services: adapter,
                            coordinator: self)
    }
}
