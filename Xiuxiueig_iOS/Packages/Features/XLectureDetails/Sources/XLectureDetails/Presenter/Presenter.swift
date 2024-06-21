import SwiftUI
import struct XEntities.LectureEntity

final class Presenter: ObservableObject, InteractorOutput {

    // View Interface
    @Published var lecture: ViewModel = ViewModel.default()
    @Published var viewState: PackageView.ViewState? = .loading

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

    private func renderContent(lecture: ViewModel) {

        withAnimation {

            viewState = nil
            self.lecture = lecture
        }
    }

    private func dispatchOnMain(_ event: InteractorEvents.Output) {

        switch event {
        case .startLoading:
            // updateViewState(.loading)
            break

        case let .refresh(lecture, categories):
            let viewModel = ViewModel.build(from: lecture, categories: categories)
            renderContent(lecture: viewModel)
        }
    }

//    private func createViewModel(from entity: Lecture) -> ViewModel {
//
//        ViewModel.build(from: entity)
//    }
}
