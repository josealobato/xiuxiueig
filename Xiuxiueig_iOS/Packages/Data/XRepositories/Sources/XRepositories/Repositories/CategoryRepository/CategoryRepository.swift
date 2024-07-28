// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

final class CategoryRepository {

    let store: ModelStore

    init(store: ModelStore) {
        self.store = store
    }
}

extension CategoryRepository: CategoryRepositoryInteface {

    func add(category: CategoryDataEntity) async throws {
        try await store.insert(category.categoryModel())
    }

    func categories() async throws -> [CategoryDataEntity] {
        let models: [CategoryModel] = try await store.fetch(nil)
        let dataEntities = models.map { CategoryDataEntity.from(model: $0) }
        return dataEntities
    }

    func category(withId id: UUID) async throws -> CategoryDataEntity? {
        let modelPredicate = #Predicate<CategoryModel> { $0.externalId == id }
        let model: [CategoryModel] = try await store.fetch(modelPredicate)
        if let model = model.first {
            let dataEntity = CategoryDataEntity.from(model: model)
            return dataEntity
        }
        return nil
    }

    func update(category: CategoryDataEntity) async throws {
        // Intentionaly left empty
    }

    func deleteCategory(withId id: UUID) async throws {
        let modelPredicate = #Predicate<CategoryModel> { $0.externalId == id }
        try await store.delete(CategoryModel.self, predicate: modelPredicate)
    }

    func persist() async throws {
        try await store.save()
    }
}
