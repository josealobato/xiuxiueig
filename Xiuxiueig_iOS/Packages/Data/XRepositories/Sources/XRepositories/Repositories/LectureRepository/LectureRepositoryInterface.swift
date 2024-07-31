// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XToolKit

/// Errors that the LectureRepositoryInteface will throw
/// (not all errors are covered ATM)
public enum LectureRepositoryIntefaceError: Error {
    case noModelForGivenEntity
    case canNotUpdateWithoutConsistencyHandler
}

// Developer Note: this interface is throwing some interal errors.
// Need to be improved.

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
