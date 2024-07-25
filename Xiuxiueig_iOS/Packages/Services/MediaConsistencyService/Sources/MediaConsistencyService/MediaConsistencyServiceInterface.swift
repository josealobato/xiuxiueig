// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import XCoordinator
import XRepositories

public protocol MediaConsistencyServiceInterface: XCoordinatorServiceLifeCycleProtocol {

    /// Manage a new file.
    /// - Parameter entity: new file to manage.
    func manage(entity: LectureDataEntity)

    /// Archive a managed file.
    /// - Parameter entity: managed file to archive.
    func archive(entity: LectureDataEntity)

    /// Delete a new or managed file.
    /// - Parameter entity: file to delete.
    func delete(entity: LectureDataEntity)
}
