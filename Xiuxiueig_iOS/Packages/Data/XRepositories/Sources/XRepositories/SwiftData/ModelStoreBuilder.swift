// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftData

struct ModelStoreBuilder {

    // Use this inMemoryStorageContainer for testing.
    // Nullyfy it on the test's set up to start fresh, or do not
    // do it for all test to work on the same 
    static var inMemoryStorageContainer: StorageContainer?

    static func build(inMemory: Bool = false) throws -> ModelStore {

        var storageContainer: StorageContainer
        if inMemory {

            if let container = inMemoryStorageContainer {
                storageContainer = container
            } else {
                storageContainer = StorageContainer(inMemory: inMemory)
                inMemoryStorageContainer = storageContainer
            }

        } else {
            storageContainer = StorageContainer.shared
        }

        return ModelStore(modelContainer: storageContainer.modelContainer)
    }
}
