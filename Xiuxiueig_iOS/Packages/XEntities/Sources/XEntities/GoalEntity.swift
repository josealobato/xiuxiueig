// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

/// It represent a study goal.
/// Lectures will point to one of this goals.
public struct GoalEntity: Identifiable, Equatable {

    public var id: UUID
    public var title: String
    public var dueDate: Date?
    // TODO: This should be persisted.
    public var canBeDeleted: Bool = false

    public var image: String {
        return dueDate == nil ? "infinity.cirle" : "target"
    }

    public init(id: UUID,
                title: String,
                dueDate: Date? = nil) {

        self.id = id
        self.title = title
        self.dueDate = dueDate
    }
}
