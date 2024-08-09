// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import struct XEntities.GoalEntity

struct GoalViewModel: Identifiable, Equatable {

    let id: UUID
    let title: String
    let subtitle: String
    let image: String

    static let dueDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yyyy"
        return dateFormatter
    }()
}

extension GoalViewModel {

    static func build(from goal: GoalEntity) -> GoalViewModel {

        var dueDateString = String(localized: "No due date", comment: "Goal subtitle when no due date available")
        if let dueDate = goal.dueDate {
            let formatedDateString = dueDateFormatter.string(from: dueDate)
            dueDateString = formatedDateString
        }

        return GoalViewModel(id: goal.id,
                             title: goal.title,
                             subtitle: dueDateString,
                             image: goal.image)
    }
}
