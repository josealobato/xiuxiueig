// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XToolKit

final class LectureRepository {

    let logger = XLog.logger(category: "Lecture Repository")
    let store: ModelStore
    let uRLConsistencyHandler: LectureURLConsistencyHandler?

    /// When autopersist is on, the repository will persist automaticaly on
    /// every call to a modifying method (add, delete, update)
    let autoPersist: Bool

    init(store: ModelStore,
         consistencyInterface: LectureURLConsistencyHandler?,
         autopersist: Bool = false) {
        self.store = store
        self.uRLConsistencyHandler = consistencyInterface
        self.autoPersist = autopersist
    }
}

extension LectureRepository: LectureRepositoryInteface {

    func add(lecture: LectureDataEntity) async throws {
        logger.debug("LR Add lecture \(lecture.title)")
        try await store.insert(lecture.lectureModel())
        if autoPersist { try await persist() }
    }

    func lectures() async throws -> [LectureDataEntity] {
        let models: [LectureModel] = try await store.fetch(nil)
        let dataEntities = models.compactMap { LectureDataEntity.from(model: $0) }
        return dataEntities
    }

    func lecture(withId id: UUID) async throws -> LectureDataEntity? {
        let modelPredicate = #Predicate<LectureModel> { $0.externalId == id }
        let model: [LectureModel] = try await store.fetch(modelPredicate)
        if let model = model.first {
            let dataEntity = LectureDataEntity.from(model: model)
            return dataEntity
        }
        return nil
    }

    func update(lecture: LectureDataEntity) async throws {

        // First, let's get the model first.

        let id = lecture.id
        let modelPredicate = #Predicate<LectureModel> { $0.externalId == id }
        let models: [LectureModel] = try await store.fetch(modelPredicate)

        guard let lectureModel = models.first else {
            logger.error("LR no model for lecture: \(lecture.title)")
            throw LectureRepositoryIntefaceError.noModelForGivenEntity
        }

        // Second let's update the Media URL.

        // Before updating and persisting the model, update the Media File System,
        // if that goes well proceed to the change in the dataBase.
        guard let uRLConsistencyHandler = self.uRLConsistencyHandler else {
            // log update can now work without consistencyInterface
            logger.error("LR Can not update without URL consistency handler")
            throw LectureRepositoryIntefaceError.canNotUpdateWithoutConsistencyHandler
        }

        let modifiedLecture = try uRLConsistencyHandler.update(entity: lecture)

        // Finaly let's update and persist the model

        lectureModel.updateWith(entity: modifiedLecture)

        // Update Dependencies (Category)
        if let category = modifiedLecture.category {
            let categoryId = category.id
            let modelPredicate = #Predicate<CategoryModel> { $0.externalId == categoryId }
            let models: [CategoryModel] = try await store.fetch(modelPredicate)
            if let categoryModel = models.first {
                lectureModel.category = categoryModel
            }
        }

        // Update Dependencies (Goal)
        if let goal = modifiedLecture.goal {
            let goalId = goal.id
            let modelPredicate = #Predicate<GoalModel> { $0.externalId == goalId }
            let models: [GoalModel] = try await store.fetch(modelPredicate)
            if let goalModel = models.first {
                lectureModel.goal = goalModel
            }
        }

        logger.debug("LR Updated lecture \(modifiedLecture.title) with url \(modifiedLecture.mediaTailURL)")
        try await persist()
    }

    func deleteLecture(withId id: UUID) async throws {
        logger.warning("LR delete lecture")
        let modelPredicate = #Predicate<LectureModel> { $0.externalId == id }
        try await store.delete(LectureModel.self, predicate: modelPredicate)
        if autoPersist { try await persist() }
    }

    func persist() async throws {
        try await store.save()
    }
}
