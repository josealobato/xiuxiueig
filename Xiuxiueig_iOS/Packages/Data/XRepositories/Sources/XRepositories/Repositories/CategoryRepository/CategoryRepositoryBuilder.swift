// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

/// Facility to build a Category Repository.
public struct CategoryRepositoryBuilder {

    public static func build() throws -> CategoryRepositoryInteface {

        try CategoryRepository(store: ModelStoreBuilder.build())
    }
}
