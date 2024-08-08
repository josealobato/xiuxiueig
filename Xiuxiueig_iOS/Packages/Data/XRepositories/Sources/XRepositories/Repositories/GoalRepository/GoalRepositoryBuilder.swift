// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

/// Facility to build a Goal Repository.
public struct GoalRepositoryBuilder {

    public static func build() throws -> GoalRepositoryInterface {

        try GoalRepository(
            store: ModelStoreBuilder.build()
        )
    }

    public static func buildInMemory() throws -> GoalRepositoryInterface {

        try GoalRepository(
            store: ModelStoreBuilder.build(inMemory: true)
        )
    }
}
