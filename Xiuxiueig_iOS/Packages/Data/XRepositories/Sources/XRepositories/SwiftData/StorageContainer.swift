// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftData

/// The storage container is in charge of building the Model container
/// that will be later use to create the Model Store.
///
/// Notice that:
/// * Model containter should be only one.
/// * Model Store will be one for every repo, since it is the responsible for
///     the context.
struct StorageContainer {

    static let shared = StorageContainer()

    let inMemory: Bool
    init(inMemory: Bool = false) {

        self.inMemory = inMemory
    }

    lazy var modelContainer: ModelContainer = {
        let fullSchema = Schema([
            LectureModel.self,
            CategoryModel.self
        ])

        let configuration = ModelConfiguration(schema: fullSchema, isStoredInMemoryOnly: inMemory)

        let container: ModelContainer
        do {
            container = try ModelContainer(
                for: fullSchema,
                configurations: [configuration]
            )
        } catch {
            fatalError("Failed to create the model container: \(error)")
        }

        return container
    }()
}
