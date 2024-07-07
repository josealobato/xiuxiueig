// copyright © 2024 jose a lobato. under mit license(https://mit-license.org)

import SwiftUI
import struct XEntities.LectureEntity

final class Presenter: ObservableObject, InteractorOutput {

    // View Interface
    @Published var lecture: LectureViewModel = LectureViewModel.none
    @Published var viewState: PlayerView.ViewState? = .loading

    let interactor: InteractorInput

    init(interactor: InteractorInput) {

        self.interactor = interactor
    }

    func request(_ event: InteractorEvents.Input) async {

        await interactor.request(event)
    }

    func dispatch(_ event: InteractorEvents.Output) {

        DispatchQueue.main.async {

            self.dispatchOnMain(event)
        }
    }

    private func renderContent(viewModel: LectureViewModel) {

        withAnimation {

            viewState = nil
            self.lecture = viewModel
        }
    }

    private func dispatchOnMain(_ event: InteractorEvents.Output) {

        switch event {
        case .startLoading:
            // WARNIN: for now the initial state is no lecture.
            renderContent(viewModel: LectureViewModel.none)

        case .refresh(let data):
            let lectureViewModel = createViewModel(from: data)
            renderContent(viewModel: lectureViewModel)

        case .noLecture:
            renderContent(viewModel: LectureViewModel.none)

        }
    }

    private func createViewModel(from data: InteractorEvents.Output.LectureData) -> LectureViewModel {

        LectureViewModel.build(from: data)
    }
}
