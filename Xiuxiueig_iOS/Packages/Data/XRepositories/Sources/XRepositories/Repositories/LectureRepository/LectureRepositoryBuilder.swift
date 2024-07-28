// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

/// Facility to build a Lecture Repository.
public struct LectureRepositoryBuilder {

    public static func build(autopersist: Bool = false) throws -> LectureRepositoryInteface {

        try LectureRepository(store: ModelStoreBuilder.build(), autopersist: autopersist)
    }

    public static func buildInMemory(autopersist: Bool = false) throws -> LectureRepositoryInteface {

        try LectureRepository(store: ModelStoreBuilder.build(inMemory: true), autopersist: autopersist)
    }
}
