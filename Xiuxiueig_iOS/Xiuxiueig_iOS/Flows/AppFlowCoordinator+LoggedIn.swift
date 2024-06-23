// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI
import XCoordinator

extension AppFlowCoordinator {

    @ViewBuilder
    func loggedInView() -> some View {
        LoggedInFlowView(coordinator: buildLoggedInCoordinator())
    }

    private func buildLoggedInCoordinator() -> LoggedInFlowCoordinator {
        if let coordinator = loggedInCoordinator {
            return coordinator
        } else {
            let coordinator = LoggedInFlowCoordinator()
            coordinator.parentCoordinator = self
            loggedInCoordinator = coordinator
            return coordinator
        }
    }
}
