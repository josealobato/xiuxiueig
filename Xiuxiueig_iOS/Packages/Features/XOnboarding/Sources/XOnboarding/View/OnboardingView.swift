// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI

struct OnboardingView: View {

    enum ViewState {
        case loaded
    }

    @StateObject private var presenter: Presenter

    // Warning here, the interactor might disappear the the view is refreshed.
    let interactor: InteractorInput

    init(presenter: Presenter,
         interactor: InteractorInput) {

        self._presenter = StateObject(wrappedValue: presenter)
        self.interactor = interactor
    }

    func request(_ event: InteractorEvents.Input) {
        Task { await interactor.request(event) }
    }

    var body: some View {
        VStack {
            Text("This is the onboarding, I'll show you around", bundle: .module)
            Button {
                request(.done)
            } label: {
                Text("Let's enter!", bundle: .module)
            }
        }
    }
}

// #Preview {
//    SwiftUIView()
// }
