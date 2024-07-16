// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import struct XEntities.LectureEntity
import XToolKit

public protocol QueueManagementServiceProtocol: AutoMockable {

    // MARK: - Getting lectures from the queue.

    /// Get the sorted queue.
    /// - Returns: Sorted queue of lectures.
    func getQueue() -> [LectureEntity]

    /// Get current lecture at the top
    /// - Returns: Current lecture at the top or nil if the queue is empty.
    func getNext() -> LectureEntity?

    // MARK: - Playing information from lectures in the Queue

    /// Inform the Manager that a lecture started to play.
    ///  - Parameters:
    ///   - id: The id of the lecture
    ///   - second: the play possition in seconds when it started.
    func startedPlayingLecture(id: UUID, in second: Int) async

    /// Inform the Manager that a lecture was paused.
    ///  - Parameters:
    ///   - id: The id of the lecture
    ///   - second: the play possition in seconds when it paused.
    func pausedLecture(id: UUID, in second: Int) async

    /// Skip a lecture.
    /// - Parameters:
    ///   - id: id of the lecture to skip
    func skippedLecture(id: UUID) async

    /// Finished playing a lecture
    /// - Parameter id: the id of the lecture.
    func donePlayingLecture(id: UUID) async

    // MARK: - Play Request for any lecture

    /// Request to play a lecture that might or not be in the queue.
    /// It will be added to the queue and set to play next
    /// - Parameter id: <#id description#>
    func playLecture(id: UUID) async

    // MARK: - Adding and Removing

    /// Add a lecture to the top of the queue (first to next)
    /// - Parameter id: the id of the lecture to add.
    func addToQueueOnTop(id: UUID) async

    /// Add a lecture at the bottom of the queue (last to next)
    /// - Parameter id: the id of the lecture to add.
    func addToQueueAtBottom(id: UUID) async

    /// Remove a lecture from the queue
    /// - Parameter id: the id of the lecture to remove.
    func removeFromQueue(id: UUID) async

    // MARK: - Sorting

    /// Change the position of a Lecture in the Queue.
    /// Index starts at 0.
    /// e.g:
    ///     [a, b(1), c, d, e]
    ///
    ///     ChangeOrder(b, 1, 4)
    ///
    ///     will result in [a, c, d, b(4), e]
    ///
    /// - Parameters:
    ///   - id: Id of the lecture to change
    ///   - origin: Initial Possition before moving it.
    ///   - destination: Final Position when the movement is done.
    func changeOrder(id: UUID, from origin: Int, to destination: Int) async
}
