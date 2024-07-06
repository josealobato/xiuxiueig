// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI

struct LoginView: View {

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

    @State private var userName: String = ""

    var body: some View {
        VStack {
            Text("Welcome to Xiuxiueig!", bundle: .module)
                .font(.largeTitle)
                .padding(.bottom)
            Text("How do you can to be called here?", bundle: .module)
            TextField("Enter your nickname", text: $userName)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button {
                request(.done(userName))
            } label: {
                Text("Yep, that is me", bundle: .module)
            }
            .disabled(userName.count < 3)
            .alert(isPresented: $presenter.isShowingError, content: {
                Alert(title: Text("Error on saving"),
                      message: Text("There was an error while saving your name, please try again"),
                      dismissButton: .default(Text("Retry"),
                                              action: { request(.done(userName)) }))
            })
        }
        .padding()
    }
}

#if DEBUG
struct PreviewInteractor: InteractorInput, InteractorOutput {
    func request(_ event: InteractorEvents.Input) async { }
    func dispatch(_ event: InteractorEvents.Output) { }
}

private var previewPresenter = Presenter()

#Preview("Empty") {
    LoginView(presenter: previewPresenter, interactor: PreviewInteractor())
}

#Preview("Error") {
    previewPresenter.isShowingError = true
    return LoginView(presenter: previewPresenter, interactor: PreviewInteractor())
}

#endif
