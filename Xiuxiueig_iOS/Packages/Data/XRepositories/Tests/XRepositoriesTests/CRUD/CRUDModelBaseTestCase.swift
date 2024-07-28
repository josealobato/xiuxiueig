// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

// This code is based on the Persistence implemenentation of my friend
// Alejandro Ramirez `Jano`.

import XCTest
import SwiftData

// swiftlint:disable identifier_name
@testable import XRepositories

/// Generic test case to allow for a quick way of writing test
/// for different Models.
class CRUDModelBaseTestCase<T: PersistentModel>: XCTestCase {
    var store: ModelStore!

    override func setUp() async throws {
        // GIVEN a fresh store in memory
        store = try ModelStoreBuilder.build(inMemory: true)
    }

    // MARK: - Crud - Create

    /// Tests ModelStore.insert(_:) with one model
    func _testInsertModel(_ input: () -> T) async throws {
        // GIVEN a store with one inserted model
        let model = input()
        try await store.insert(model)
        try await store.save()

        // WHEN fetching all models of that type
        let models: [T] = try await store.fetch()

        // THEN there is one model in the store
        try await XCTAssertCount(T.self, 1)

        // THEN the model found is equal to the inserted model
        let readBackModel = try XCTUnwrap(models.first)
        XCTAssertEqual(model, readBackModel)
    }

    /// Tests ModelStore.insert(_:) with an array of models
    func _testInsertModels(_ input: () -> [T]) async throws {
        // GIVEN a store with many inserted models
        let models = input()
        try await store.insert(models)
        try await store.save()

        // THEN number of fetched objects matches number of objects in the input
        try await XCTAssertCount(T.self, models.count)
    }

    // MARK: - cRud - Retrive

    /// Tests ModelStore.fetch(_:) without parameters
    func _testFetchWithoutDescriptor(_ input: () -> T) async throws {
        // GIVEN a store with one inserted model
        let model = input()
        try await store.insert(model)
        try await store.save()
        try await XCTAssertCount(T.self, 1)

        // WHEN fetching all models
        let models: [T] = try await store.fetch()

        // THEN there is one model in the store
        XCTAssertEqual(models.count, 1)
    }

    /// Tests ModelStore.fetch(_:) with descriptor
    func _testFetchWithDescriptor(_ input: () -> T, descriptor: FetchDescriptor<T>) async throws {
        // GIVEN a store with one inserted model
        let model = input()
        try await store.insert(model)
        try await store.save()
        try await XCTAssertCount(T.self, 1)

        // WHEN fetching all models with a matching descriptor
        let models: [T] = try await store.fetch(descriptor)

        // THEN there is one model in the store
        XCTAssertEqual(models.count, 1)
    }

    // Could write Tests ModelStore.fetch(_:) with predicate
    // Pending implementation.

    // MARK: - crUd - Update

    // No base test case for Update

    // MARK: - cruD - Delete

    /// Tests ModelStore.delete(_:predicate:) without predicate
    func _testDeleteWithoutPredicate(input: () -> T) async throws {
        // GIVEN a store with one inserted model
        let model = input()
        try await store.insert(model)
        try await store.save()
        try await XCTAssertCount(T.self, 1)

        // WHEN deleting all models of that type
        try await store.delete(T.self, predicate: nil)

        // THEN no models of that type remain in the store
        try await XCTAssertCount(T.self, 0)
    }

    /// Tests ModelStore.delete(_:predicate:) with predicate
    func _testDeleteWithPredicate(input: () -> T, predicate: Predicate<T>) async throws {
        // GIVEN a store with one inserted model
        let model = input()
        try await store.insert(model)
        try await store.save()
        try await XCTAssertCount(T.self, 1)

        // WHEN deleting all models with a matching predicate
        try await store.delete(T.self, predicate: predicate)

        // THEN no models of that type remain in the store
        try await XCTAssertCount(T.self, 0)
    }

    /// Tests ModelStore.delete(id:type:) with ID
    func _testDeleteWithID(_ input: () -> T) async throws {
        // GIVEN a store with one inserted model
        let model = input()
        try await store.insert(model)
        try await store.save()
        try await XCTAssertCount(T.self, 1)

        // WHEN deleting all models with that id
        try await store.delete(id: model.persistentModelID, type: T.self)

        // THEN no models of that type remain in the store
        try await XCTAssertCount(T.self, 0)
    }

    // MARK: - Helper methods

    /// Method to assert the number of entries of a model in the Store.
    /// - Parameters:
    ///   - type: The model type
    ///   - count: the nxpected count
    private func XCTAssertCount(
        _ type: T.Type,
        _ count: Int,
        _ message: @autoclosure () -> String = "",
        file: StaticString = #filePath,
        line: UInt = #line
    ) async throws where T: Equatable {
        let objects: [T] = try await store.fetch()
        XCTAssertEqual(objects.count, count, message(), file: file, line: line)
    }
}
// swiftlint:enable identifier_name
