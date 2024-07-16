// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XPlayer
import XEntities
import XQueueManagementService

class XPlayerAdapter: XPlayerServiceInterface {

    let queueManagement: QueueManagementServiceInterface

    init(queueManagement: QueueManagementServiceInterface) {
        self.queueManagement = queueManagement
    }

    func nextLecture() async throws -> XPlayerLecture? {
        queueManagement.getNext()
    }

    func playing(id: UUID, in second: Int) async {
        await queueManagement.startedPlayingLecture(id: id, in: second)
    }

    func paused(id: UUID, in second: Int) async {
        await queueManagement.pausedLecture(id: id, in: second)
    }

    func skipped(id: UUID, in second: Int) async {
        await queueManagement.skippedLecture(id: id)
    }

    func donePlaying(id: UUID) async throws {
        await queueManagement.donePlayingLecture(id: id)
    }
}

extension LectureEntity: XPlayerLecture { }
