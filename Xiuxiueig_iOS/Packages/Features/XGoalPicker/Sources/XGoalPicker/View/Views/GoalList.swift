// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI

struct GoalList: View {

    var goals: [GoalViewModel]

    @State private var selectedTab: Int = 1
    private let handlers: ActionHandlers = .init()

    var body: some View {

        List {

            ForEach(goals) { goal in
                GoalRow(title: goal.title,
                        subTitle: goal.subtitle,
                        image: goal.image)
                .onTapGesture { select(id: goal.id) }
            }
            .listRowSeparator(.hidden)

        }
        .listStyle(.plain)
        .navigationTitle(String(localized: "Goals", comment: "Goal Picker list title"))
    }

    // MARK: - Actions

    public func onSelect(_ action: @escaping ((UUID) -> Void)) -> Self {
        handlers.onSelect = action
        return self
    }
}

private class ActionHandlers {

    var onSelect: ((UUID) -> Void)?
}

private extension GoalList {

    func select(id: UUID) {
        handlers.onSelect?(id)
    }
}

struct SwiftUIView_Previews: PreviewProvider {

    @State static var models = [
        GoalViewModel(id: UUID(),
                      title: "Long-term learning",
                      subtitle: "No due date",
                      image: "infinity.circle"),
        GoalViewModel(id: UUID(),
                      title: "Prime trimester",
                      subtitle: "1/2/2025",
                      image: "target")
    ]
    static var previews: some View {
        NavigationView {
            GoalList(goals: models)
            .previewDisplayName("Goal Collection")
            //                .preferredColorScheme(.dark)
        }

    }
}
