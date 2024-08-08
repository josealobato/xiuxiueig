// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XToolKit

final class GoalRepository {

    let logger = XLog.logger(category: "Goal Repository")
    let store: ModelStore

    init(store: ModelStore) {
        self.store = store
    }
}

extension GoalRepository: GoalRepositoryInterface {

    func add(goal: GoalDataEntity) async throws {
        logger.debug("GoalRep Add goal \(goal.title)")
        try await store.insert(goal.goalModel())
        try await persist()
    }

    func goals() async throws -> [GoalDataEntity] {
        let models: [GoalModel] = try await store.fetch(nil)
        let dataEntities = models.compactMap { GoalDataEntity.from(model: $0) }
        return dataEntities
    }

    func goal(withId id: UUID) async throws -> GoalDataEntity? {
        let modelPredicate = #Predicate<GoalModel> { $0.externalId == id }
        let model: [GoalModel] = try await store.fetch(modelPredicate)
        if let model = model.first {
            let dataEntity = GoalDataEntity.from(model: model)
            return dataEntity
        }
        return nil
    }

    func update(goal: GoalDataEntity) async throws {

        // First, let's get the model first.

        let id = goal.id
        let modelPredicate = #Predicate<GoalModel> { $0.externalId == id }
        let models: [GoalModel] = try await store.fetch(modelPredicate)

        guard let goalModel = models.first else {
            logger.error("GoalRep no model for lecture: \(goal.title)")
            throw GoalRepositoryIntefaceError.noModelForGivenEntity
        }

        // Second, let's update and persist the model

        goalModel.updateWith(entity: goal)

        try await persist()
    }

    func deleteGoal(withId id: UUID) async throws {
        logger.warning("GoalRep delete goal")
        let modelPredicate = #Predicate<GoalModel> { $0.externalId == id}
        try await store.delete(GoalModel.self, predicate: modelPredicate)
        try await persist()
    }

    func persist() async throws {
        try await store.save()
    }
}
