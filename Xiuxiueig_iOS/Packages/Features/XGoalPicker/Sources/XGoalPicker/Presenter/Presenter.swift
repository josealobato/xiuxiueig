// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI
import struct XEntities.GoalEntity

final class Presenter: ObservableObject, InteractorOutput {

    // View Interface
    @Published var goals: [GoalViewModel] = []
    @Published var viewState: GoalPickerView.ViewState? = .loading

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

    private func renderContent(goals: [GoalViewModel]) {

        withAnimation {

            viewState = nil
            self.goals = goals
        }
    }

    private func dispatchOnMain(_ event: InteractorEvents.Output) {

        switch event {
        case .startLoading:
            //            updateViewState(.loading)
            break

        case .refresh(let goals):
            let goalViewModels = goals.compactMap(createViewModel)
            renderContent(goals: goalViewModels)
        }
    }

    private func createViewModel(from entity: GoalEntity) -> GoalViewModel {

        GoalViewModel.build(from: entity)
    }
}
