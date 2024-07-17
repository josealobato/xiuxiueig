// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

final class LectureRepository {

    let store: ModelStore

    init(store: ModelStore) {
        self.store = store
    }
}

extension LectureRepository: LectureRepositoryInteface {

    func add(lecture: LectureDataEntity) async throws {
        try await store.insert(lecture.lectureModel())
    }

    func lectures() async throws -> [LectureDataEntity] {
        let models: [LectureModel] = try await store.fetch(nil)
        let dataEntities = models.compactMap { LectureDataEntity.from(model: $0) }
        return dataEntities
    }

    func lecture(withId id: UUID) async throws -> LectureDataEntity? {
        let modelPredicate = #Predicate<LectureModel> { $0.id == id }
        let model: [LectureModel] = try await store.fetch(modelPredicate)
        if let model = model.first {
            let dataEntity = LectureDataEntity.from(model: model)
            return dataEntity
        }
        return nil
    }

    func update(lecture: LectureDataEntity) async throws {
        // Intentionally left empty
    }

    func deleteLecture(withId id: UUID) async throws {
        let modelPredicate = #Predicate<LectureModel> { $0.id == id }
        try await store.delete(LectureModel.self, predicate: modelPredicate)
    }

    func persist() async throws {
        try await store.save()
    }
}
