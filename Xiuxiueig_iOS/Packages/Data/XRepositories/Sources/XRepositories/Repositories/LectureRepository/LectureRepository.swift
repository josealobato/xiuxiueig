// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

final class LectureRepository {

    let store: ModelStore

    /// When autopersist is on, the repository will persist automaticaly on
    /// every call to a modifying method (add, delete, update)
    let autoPersist: Bool

    init(store: ModelStore, autopersist: Bool = false) {
        self.store = store
        self.autoPersist = autopersist
    }
}

extension LectureRepository: LectureRepositoryInteface {

    func add(lecture: LectureDataEntity) async throws {
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
        let id = lecture.id
        let modelPredicate = #Predicate<LectureModel> { $0.externalId == id }
        let models: [LectureModel] = try await store.fetch(modelPredicate)

        guard let lectureModel = models.first else {
            // throw
            return
        }

        lectureModel.updateWith(entity: lecture)

        // Update Dependencies (Category)
        if let category = lecture.category {
            let categoryId = category.id
            let modelPredicate = #Predicate<CategoryModel> { $0.externalId == categoryId }
            let models: [CategoryModel] = try await store.fetch(modelPredicate)
            if let categoryModel = models.first {
                lectureModel.category = categoryModel
            }
        }

        try await persist()

        // Broadcast update
    }

    func deleteLecture(withId id: UUID) async throws {
        let modelPredicate = #Predicate<LectureModel> { $0.externalId == id }
        try await store.delete(LectureModel.self, predicate: modelPredicate)
        if autoPersist { try await persist() }
    }

    func persist() async throws {
        try await store.save()
    }
}
