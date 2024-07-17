// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XToolKit

/// CRUD interface to manange `LectureDataEntities`.
public protocol LectureRepositoryInteface: AutoMockable {

    // Create
    func add(lecture: LectureDataEntity) async throws

    // Read
    func lectures() async throws -> [LectureDataEntity]
    func lecture(withId id: UUID) async throws -> LectureDataEntity?

    // Update
    func update(lecture: LectureDataEntity) async throws

    // Delete
    func deleteLecture(withId id: UUID) async throws

    // Persist
    func persist() async throws
}
