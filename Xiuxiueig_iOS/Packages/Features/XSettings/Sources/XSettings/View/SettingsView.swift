// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI

struct SettingsView: View {

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

        List {
            if let name = presenter.viewModel.userName {
                Text(
                    """
                    \(String(describing: name)) here you will find the\
                    settings to tune the application.
                    """
                )
            }
            Button {
                request(.logout)
            } label: {
                Text("Log out")
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .navigationTitle("Settings")
        .onAppear { request(.loadInitialData) }
    }
}

#if DEBUG
struct PreviewInteractor: InteractorInput, InteractorOutput {
    func request(_ event: InteractorEvents.Input) async { }
    func dispatch(_ event: InteractorEvents.Output) { }
}

private var previewPresenter = Presenter()
#Preview("Settings On Nav") {
    previewPresenter.viewModel.userName = "Pau"
    return NavigationView {

        SettingsView(presenter: previewPresenter, interactor: PreviewInteractor())
    }
}

#endif
