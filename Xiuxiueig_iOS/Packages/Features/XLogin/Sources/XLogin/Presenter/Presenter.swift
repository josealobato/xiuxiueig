// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI

final class Presenter: ObservableObject, InteractorOutput {

    // View Interface
    @Published var viewState: LoginView.ViewState? = .loaded

    // MARK: - Interactor Output conformance

    func dispatch(_ event: InteractorEvents.Output) {
//        DispatchQueue.main.async {
//
//            self.dispatchOnMain(event)
//        }
    }

    private func dispatchOnMain(_ event: InteractorEvents.Output) {

    }
}
