// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

/// Facility to build a Lecture Repository.
public struct LectureRepositoryBuilder {

    public static func build(
        uRLConsistencyHandler: LectureURLConsistencyHandler? = nil,
        autopersist: Bool = false) throws -> LectureRepositoryInteface {

        try LectureRepository(
            store: ModelStoreBuilder.build(),
            consistencyInterface: uRLConsistencyHandler,
            autopersist: autopersist
        )
    }

    public static func buildInMemory(
        uRLConsistencyHandler: LectureURLConsistencyHandler? = nil,
        autopersist: Bool = false) throws -> LectureRepositoryInteface {

        try LectureRepository(
            store: ModelStoreBuilder.build(inMemory: true),
            consistencyInterface: uRLConsistencyHandler,
            autopersist: autopersist
        )
    }
}
