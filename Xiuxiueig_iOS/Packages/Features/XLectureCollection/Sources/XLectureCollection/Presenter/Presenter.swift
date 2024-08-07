// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI
import struct XEntities.LectureEntity

final class Presenter: ObservableObject, InteractorOutput {

    // View Interface
    @Published var lectures: [LectureViewModel] = []
    @Published var viewState: LectureCollectionView.ViewState? = .loading

    func dispatch(_ event: InteractorEvents.Output) {

        DispatchQueue.main.async {

            self.dispatchOnMain(event)
        }
    }

    private func renderContent(lectures: [LectureViewModel]) {

        withAnimation {

            viewState = nil
            self.lectures = lectures
        }
    }

    private func dispatchOnMain(_ event: InteractorEvents.Output) {

        switch event {
        case .startLoading:
            //            updateViewState(.loading)
            break

        case .refresh(let lectures):
            let lectureViewModels = lectures.compactMap(createViewModel)
            renderContent(lectures: lectureViewModels)
        }
    }

    private func createViewModel(from entity: LectureEntity) -> LectureViewModel {

        LectureViewModel.build(from: entity)
    }
}
