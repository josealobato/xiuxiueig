// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI
import XCoordinator

extension AppFlowCoordinator {

    @ViewBuilder
    func onboardingView() -> some View {
        VStack {
            Text("Onboarding")
            Button {
                self.updateState(.loggedIn)
            } label: {
                Text("Next")
            }
        }
    }
}
