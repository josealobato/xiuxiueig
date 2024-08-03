// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftData

struct ModelStoreBuilder {

    static func build(inMemory: Bool = false) throws -> ModelStore {

        var storageContainer: StorageContainer
        if inMemory {
            storageContainer = StorageContainer(inMemory: inMemory)
        } else {
            storageContainer = StorageContainer.shared
        }

        return ModelStore(modelContainer: storageContainer.modelContainer)
    }
}
