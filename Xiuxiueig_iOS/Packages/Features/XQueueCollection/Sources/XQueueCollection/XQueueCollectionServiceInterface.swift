// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XToolKit
import struct XEntities.LectureEntity

public protocol XQueueCollectionServiceInterface: AutoMockable {

    /// Get the existing lectures.
    func queuedLectures() async throws -> [LectureEntity]

    /// Remove a given id from the queue.
    /// - Parameter id: the id of the Lecture to dequeue.
    func dequeueLecture(id: UUID) async throws
}
