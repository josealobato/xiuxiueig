// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI
import XCoordinator
import XOnboarding

extension AppFlowCoordinator {

    @ViewBuilder
    func onboardingView(userName: String) -> some View {
        let adapter = XOnboardingAdapter()
        XOnboardingBuilder.build(services: adapter,
                                 coordinator: self,
                                 userName: userName)
    }
}
