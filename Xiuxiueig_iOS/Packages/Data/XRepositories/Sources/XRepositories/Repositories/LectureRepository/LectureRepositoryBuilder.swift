// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

/// Facility to build a Lecture Repository.
public struct LectureRepositoryBuilder {

    public static func build() throws -> LectureRepositoryInteface {

        try LectureRepository(store: ModelStoreBuilder.build())
    }
}
