// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import SwiftData

struct ModelStoreBuilder {

    static func build(inMemory: Bool = false) throws -> ModelStore {

        let fullSchema = Schema([
            LectureModel.self,
            CategoryModel.self
        ])

        let configuration = ModelConfiguration(schema: fullSchema, isStoredInMemoryOnly: inMemory)

        let container = try ModelContainer(for: fullSchema, configurations: [configuration])

        return ModelStore(modelContainer: container)
    }
}
