// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI

final class Presenter: ObservableObject, InteractorOutput {

    @Published var viewModel: ViewModel = .default

    // MARK: - Interactor Output conformance

    func dispatch(_ event: InteractorEvents.Output) {
        DispatchQueue.main.async {
            self.dispatchOnMain(event)
        }
    }

    private func dispatchOnMain(_ event: InteractorEvents.Output) {
        switch event {
        case .userName(let userName):
            viewModel.userName = userName
        }
    }
}

struct ViewModel {

    var userName: String?

    static var `default`: ViewModel {
        ViewModel()
    }
}
