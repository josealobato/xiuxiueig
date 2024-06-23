// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI
import XCoordinator
import XLogin

extension AppFlowCoordinator {

    @ViewBuilder
    func loggedOutView() -> some View {
        let adapter = XLoginAdapter()
        XLoginBuilder.build(services: adapter,
                            coordinator: self)
    }
}
