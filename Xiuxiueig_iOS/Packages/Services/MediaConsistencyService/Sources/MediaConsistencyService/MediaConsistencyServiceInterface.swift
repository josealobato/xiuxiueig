// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import XCoordinator
import XRepositories

enum MediaConsistencyServiceError: Error {
    case noMediaFileForGivenEntity
    case movingToNewIsNotAllowed
    case notPossibleToManageMediaFile
    case notPossibleToArchiveMediaFile
    case notPossibleToDeleteMediaFile // not used ATM
}

public protocol MediaConsistencyServiceInterface: XCoordinatorServiceLifeCycleProtocol {

    /// Delete a new or managed file.
    /// - Parameter entity: file to delete.
    func delete(entity: LectureDataEntity) throws

    /// Update the lecture and the underlinging file system according with
    /// the changes included in the given Entity
    /// - Parameter entity: Entity with modifications.
    /// - Returns: The modified entity matching the file system (URL)
    func update(entity: LectureDataEntity) throws -> LectureDataEntity
}
