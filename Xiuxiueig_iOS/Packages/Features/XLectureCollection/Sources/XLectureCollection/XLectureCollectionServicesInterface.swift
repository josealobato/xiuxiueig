import Foundation
import XToolKit
import struct XEntities.LectureEntity

/// The services interface declares the needs of the Lecture collection.
/// The later needs an object conforming to this protocol to provide all needed
/// data and action to work.
public protocol XLectureCollectionServicesInterface: AutoMockable {

    /// Get the existing lectures.
    func lectures() async throws -> [LectureEntity]

    /// Add a given id to the queue.
    /// - Parameter id: the id of the Lecture to enqueue.
    func enqueueLecture(id: String) async throws

    /// Remove a given id from the queue.
    /// - Parameter id: the id of the Lecture to dequeue.
    func dequeueLecture(id: String) async throws
}
