// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import SwiftData

@Model
final class GoalModel {
    var externalId: UUID?
    var title: String?
    var dueDate: Date?

    init(externalId: UUID? = nil,
         title: String? = nil,
         dueDate: Date? = nil) {

        self.externalId = externalId
        self.title = title
        self.dueDate = dueDate
    }
}

extension GoalModel {

    func updateWith(entity: GoalDataEntity) {
        // id is not updated
        title = entity.title
        dueDate = entity.dueDate
    }
}
