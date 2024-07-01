// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XToolKit

/// CRUD interface to manange `CategoryDataEntities`.
public protocol CategoryRepositoryInteface: AutoMockable {

    // Create
    func add(category: CategoryDataEntity) async throws

    // Read
    func categories() async throws -> [CategoryDataEntity]
    func category(withId id: UUID) async throws -> CategoryDataEntity?

    // Update
    func update(category: CategoryDataEntity) async throws

    // Delete
    func deleteCategory(withId id: UUID) async throws
}
