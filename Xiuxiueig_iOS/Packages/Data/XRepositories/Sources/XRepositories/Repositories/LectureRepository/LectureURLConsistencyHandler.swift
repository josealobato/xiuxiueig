// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XToolKit

/// We a entity is updated, externally we need a handler that modify the URL
/// and make it consistent with the media file system. That handler should
/// conform to this protocol for the Lecture repository interact with it.
public protocol LectureURLConsistencyHandler: AutoMockable {

    /// The Lecture repository will use this method to request an updated
    /// entity with a fresh URL from the given modified entity
    /// - Parameter entity: The suposely modified entity.
    /// - Returns: A new entity with the same data than the previous one but
    ///            with an updated URL according to the changes in the input
    ///            entity.
    func update(entity: LectureDataEntity) throws -> LectureDataEntity
}
