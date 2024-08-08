// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XEntities
import XQueueCollection
import XQueueManagementService

final class XQueueCollectionAdapter: XQueueCollectionServiceInterface {

    let queueManager: QueueManagementServiceInterface

    init(queueManager: QueueManagementServiceInterface) {
        self.queueManager = queueManager
    }

    // MARK: - QueueManagementServiceInterface

    func queuedLectures() async throws -> [LectureEntity] {
        queueManager.getQueue()
    }

    func dequeueLecture(id: UUID) async throws {
        await queueManager.removeFromQueue(id: id)
    }
}
