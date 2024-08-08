// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

public struct GoalDataEntity: Identifiable, Equatable {

    public let id: UUID
    public var title: String
    public var dueDate: Date?

    public init(id: UUID,
                title: String,
                dueDate: Date?) {

        self.id = id
        self.title = title
        self.dueDate = dueDate
    }
}

// MARK: - Extensions to convert to and from model

extension GoalDataEntity {

    func goalModel() -> GoalModel {

        let model = GoalModel(
            externalId: self.id,
            title: self.title,
            dueDate: self.dueDate)

        return model
    }

    static func from(model: GoalModel) -> Self? {

        guard let id = model.externalId,
              let title =  model.title
        else { return nil }

        let dataEntity = GoalDataEntity(
            id: id,
            title: title,
            dueDate: model.dueDate)

        return dataEntity
    }
}
