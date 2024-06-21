import Foundation
import XToolKit
import struct XEntities.LectureEntity
import struct XEntities.CategoryEntity

/// These are the errors correctly managed by this module.
/// The rest of thrown errors will be handle as unknown.
public enum XLectureDetailsServiceError: Error {

    case invalidID
    case notAbleToSave
    case unkown
}

public protocol XLectureDetailsServiceInterface: AutoMockable {

    /// Get the lecture.
    func lecture(withId id: String) async throws -> LectureEntity

    /// Get the list of categories that can be applied to a lecture
    func categories() async throws -> [CategoryEntity]

    /// Save the lecture.
    /// - Parameter lecture: lecture to save.
    func save(lecture: LectureEntity) async throws
}
