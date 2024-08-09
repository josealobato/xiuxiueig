// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI

struct GoalPickerView: View {

    enum ViewState {

        case loading
    }

    @StateObject private var presenter: Presenter
    let interactor: InteractorInput

    init(presenter: Presenter,
         interactor: InteractorInput) {

        self._presenter = StateObject(wrappedValue: presenter)
        self.interactor = interactor
    }

    var body: some View {
        GoalList(goals: presenter.goals)
            .onSelect { request(.select($0)) }
            .navigationTitle(String(localized: "Select a Goal", comment: "Goal picker navigation title"))
            .onAppear { request(.loadInitialData) }
            .refreshable { request(.loadInitialData) }
    }

    func request(_ event: InteractorEvents.Input) {

        Task {

            await interactor.request(event)
        }
    }
}

struct GoalPickerView_Previews: PreviewProvider {

    struct TestContainer: View {

        @State private var previewGoals: [GoalViewModel] = [
            GoalViewModel(id: UUID(),
                          title: "Long-term learning",
                          subtitle: "No due date",
                          image: "infinity.circle"),
            GoalViewModel(id: UUID(),
                          title: "Prime trimester",
                          subtitle: "1/2/2025",
                          image: "target")
        ]

        var body: some View {
            GoalList(goals: previewGoals)
        }

    }

    static var previews: some View {
        TestContainer()
            .previewDisplayName("ContainerView")
    }
}
