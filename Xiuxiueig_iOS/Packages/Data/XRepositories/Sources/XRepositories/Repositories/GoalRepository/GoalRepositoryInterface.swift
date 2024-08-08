// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XToolKit

/// Errors that the GoalRepositoryInteface will throw
/// (not all errors are covered ATM)
public enum GoalRepositoryIntefaceError: Error {
    case noModelForGivenEntity
}

public protocol GoalRepositoryInterface: AutoMockable {

    // Create
    func add(goal: GoalDataEntity) async throws

    // Read
    func goals() async throws -> [GoalDataEntity]
    func goal(withId id: UUID) async throws -> GoalDataEntity?

    // Update
    func update(goal: GoalDataEntity) async throws

    // Delete
    func deleteGoal(withId id: UUID) async throws

    // Persist
    func persist() async throws
}
