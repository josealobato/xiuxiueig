// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI
import XCoordinator
import XOnboarding

extension AppFlowCoordinator {

    @ViewBuilder
    /// On boarding view builder
    /// **Notice** that the onboarding is not a flow but a feature and does not require
    /// a context. It just needs the user name.
    /// - Parameter userName: The user name.
    /// - Returns: The onboarding View ready to use.
    func onboardingView(userName: String) -> some View {
        let adapter = XOnboardingAdapter()
        XOnboardingBuilder.build(services: adapter,
                                 coordinator: self,
                                 userName: userName)
    }
}
