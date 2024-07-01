// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

// This code is based on the Persistence implemenentation of my friend
// Alejandro Ramirez `Jano`.

import Foundation
import SwiftData

extension ModelStore {

    // MARK: - store specific methods

    func save() throws {
        try context.save()
    }

    // MARK: - Crud - Create

    func insert(_ model: some PersistentModel) throws {
        context.insert(model)
    }

    func insert(_ models: [some PersistentModel]) throws {
        for model in models {
            context.insert(model)
        }
    }

    // MARK: - cRud - Retrive

    func fetch<T: PersistentModel>(_ predicate: Predicate<T>? = nil) throws -> [T] {
        try context.fetch(FetchDescriptor<T>(predicate: predicate))
    }

    func fetch<T: PersistentModel>(_ descriptor: FetchDescriptor<T>) throws -> [T] {
        try context.fetch(descriptor)
    }

    func fetch<T: PersistentModel>(id: PersistentIdentifier, type: T.Type) throws -> T? {
        context.model(for: id) as? T
    }

    func numberOf<T: PersistentModel>(_ model: T.Type) throws -> Int {
        try context.fetchCount(FetchDescriptor<T>())
    }

    // MARK: - crUd - Update

    /// `update` do not really update but check the existence of a value and then execute
    /// the given `updating` method to allow the caller to update. This is a internal
    /// method to be used inside the Model Store.
    /// - Parameters:
    ///   - id: Moded id to update
    ///   - updating: The method to be called to do the update.
    /// - Returns: The moidifed model.
    func update<T: PersistentModel>(id: PersistentIdentifier, updating: (T) throws -> Void) throws -> T {
        guard let item = context.model(for: id) as? T else {
            throw ModelStoreError.missingObjectWithId(id)
        }
        try updating(item)
        return item
    }

    // MARK: - cruD - Delete

    func delete<T: PersistentModel>(_ model: T.Type, predicate: Predicate<T>? = nil) throws {
        try context.delete(model: T.self, where: predicate)
    }

    func delete<T: PersistentModel>(id: PersistentIdentifier, type: T.Type) throws {
        guard let item = context.model(for: id) as? T else { return }
        context.delete(item)
    }

}
