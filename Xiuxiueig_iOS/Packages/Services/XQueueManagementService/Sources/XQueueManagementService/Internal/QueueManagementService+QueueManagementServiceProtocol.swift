// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XEntities
import XCoordinator
import XRepositories
import XToolKit

extension QueueManagementService: QueueManagementServiceInterface {

    // MARK: - Getting lectures from the queue.

    func getQueue() -> [LectureEntity] {
        return queue
    }

    func getNext() -> LectureEntity? {

        return queue.count > 0 ? queue[0] : nil
    }

    // MARK: - Playing

    func startedPlayingLecture(id: UUID, in second: Int) async {

        // if the object is not in the queue do nothing.
        guard isLectureInQueue(id: id) else { return }

        do {

            // if the lecture is not the first we sort it first.
            if let playingIndex = queue.firstIndex(where: { $0.id == id }) {
                if playingIndex != 0 {
                    await changeOrder(id: id, from: playingIndex, to: 0)
                }
            }

            // Set the play position.
            queue[0].playPosition = second

            // TODO: Notify externally about new playing lecture

            // Persist
            try await storage.update(lecture: queue[0].dataEntity())

        } catch {
            logger.error("Error updating storage while starting playing lecture: \(error)")
        }
    }

    func pausedLecture(id: UUID, in second: Int) async {

        // if the object is not in the queue do nothing.
        guard let index = indexInQueue(id: id) else { return }

        do {

            // Set the play position.
            queue[index].playPosition = second

            // TODO: Notify externally about new playing lecture

            // Persist
            try await storage.update(lecture: queue[index].dataEntity())

        } catch {
            logger.error("Error updating storage while pausing playing lecture: \(error)")
        }
    }

    func skippedLecture(id: UUID) async {

        // if the object is not in the queue do nothing.
        guard let index = indexInQueue(id: id) else { return }

        // Removed play possition.
        queue[index].playPosition = nil

        // Move it to the end.
        await changeOrder(id: id, from: index, to: queue.count - 1)
    }

    func donePlayingLecture(id: UUID) async {

        // if the object is not in the queue do nothing:
        guard let index = indexInQueue(id: id) else { return }

        // Get the lecture and remove it for the queue:
        var playedLecture = queue[index]
        queue.remove(at: index)

        // Set the time stamp, done playing, and clean queue possition:
        playedLecture.played.append(timeProvider.now)
        playedLecture.playPosition = nil
        playedLecture.queuePosition = nil

        do {
            // Save it:
            try await storage.update(lecture: playedLecture.dataEntity())

            // Adjust the indexes and save.
            consolidateIndexInQueue()
            await persistQueue()
        } catch {
            logger.error("Error updating storage while done playing lecture: \(error)")
        }
    }

    // MARK: - Play Request for any lecture

    func playLecture(id: UUID) async {

        do {
            if !isLectureInQueue(id: id) {

                // Get the new lecture and if does not exist get out.
                guard let newDataLecture = try await storage.lecture(withId: id) else { return }

                // Insert it at top
                queue.insert(newDataLecture.entity(), at: 0)
            }

            guard let index = indexInQueue(id: id) else { return }

            // Move it to top if needed.
            if index != 0 {
                await changeOrder(id: id, from: index, to: 0)
            }

            // Adjust the indexes and save.
            consolidateIndexInQueue()
            await persistQueue()

        } catch {
            logger.error("Error updating storage while request for playing lecture: \(error)")
        }
    }

    // MARK: - Adding and Removing

    func addToQueueOnTop(id: UUID) async {

        // if the object is already there do nothing.
        guard !isLectureInQueue(id: id) else { return }

        // get the object from the store.
        if let dataLecture = try? await storage.lecture(withId: id) {

            // add to the queue.
            queue.insert(dataLecture.entity(), at: 0)

            // adjust the indexes.
            consolidateIndexInQueue()
            await persistQueue()
        }
    }

    func addToQueueAtBottom(id: UUID) async {

        // if the object is already there do nothing.
        guard !isLectureInQueue(id: id) else { return }

        // get the object from the store.
        if let dataLecture = try? await storage.lecture(withId: id) {

            // add to the queue.
            queue.append(dataLecture.entity())

            // adjust the indexes and store
            consolidateIndexInQueue()
            await persistQueue()
        }
    }

    func removeFromQueue(id: UUID) async {

        // if the object is not in queue do nothing.
        guard isLectureInQueue(id: id) else { return }

        if let index = queue.firstIndex(where: { $0.id == id }) {

            // Remove the object
            var removedLecture = queue.remove(at: index)

            // Save the removed object out of the queue
            removedLecture.queuePosition = nil
            do {
                try await storage.update(lecture: removedLecture.dataEntity())
            } catch {
                logger.error("Error updating storage while removing from queue: \(error)")
            }

            // adjust the indexes and store
            consolidateIndexInQueue()
            await persistQueue()
        }
    }

    // MARK: - Sorting

    func changeOrder(id: UUID, from origin: Int, to destination: Int) async {

        // Index should be valid
        guard isIndexInRange(index: origin) && isIndexInRange(index: destination)
          else { return }

        // ... and different.
        guard origin != destination else { return }

        if origin < destination {

            let lecture = queue[origin]
            queue.remove(at: origin)
            queue.insert(lecture, at: destination)

        } else {

            let lecture = queue[origin]
            queue.remove(at: origin)
            queue.insert(lecture, at: destination)
        }

        consolidateIndexInQueue()
        await persistQueue()
    }

    /// Update the Queue possition of the current state of the queue,
    /// making sure that they represent the current possition on the queue.
    private func consolidateIndexInQueue() {

        for index in 0..<queue.count {

            queue[index].queuePosition = index + 1
        }
    }

    /// Persiste the current state of the queue to the storage.
    private func persistQueue() async {

        do {
            for lecture in queue {
                try await storage.update(lecture: lecture.dataEntity())
            }
        } catch {
            logger.error("Error updating storage while persisting queue: \(error)")
        }
    }

    /// Verifies that the given index is inside the boudaries of the queue
    /// - Parameter index: The index to test.
    /// - Returns: True when it is a valid index (in range)
    private func isIndexInRange(index: Int) -> Bool {

        let range = 0 ..< queue.count
        return range.contains(index)
    }

    /// Check if exist in the queue a lecture with the given id.
    /// - Parameter id: the id to look for.
    /// - Returns: true if there exist a lecture with the given id.
    private func isLectureInQueue(id: UUID) -> Bool {
        indexInQueue(id: id) != nil
    }

    /// Get the index of a lecture in the queue if any
    /// - Parameter id: Id of the lecture
    /// - Returns: Index if any.
    private func indexInQueue(id: UUID) -> Int? {
        queue.firstIndex(where: { $0.id == id })
    }
}
