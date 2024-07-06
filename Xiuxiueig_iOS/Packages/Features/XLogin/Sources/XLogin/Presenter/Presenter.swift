// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI

final class Presenter: ObservableObject, InteractorOutput {

    // View Interface
    @Published var viewModel: ViewModel = .default
    @Published var isShowingError = false

    // MARK: - Interactor Output conformance

    func dispatch(_ event: InteractorEvents.Output) {
        DispatchQueue.main.async {
            self.dispatchOnMain(event)
        }
    }

    private func dispatchOnMain(_ event: InteractorEvents.Output) {
        switch event {
        case .errorOnSave:
            isShowingError = true
        }

    }
}

struct ViewModel {

    static var `default`: ViewModel {
        ViewModel()
    }
}
