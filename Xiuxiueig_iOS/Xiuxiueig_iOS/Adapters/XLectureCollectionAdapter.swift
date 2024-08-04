// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XLectureCollection
import XToolKit
import XEntities
import XRepositories
import XQueueManagementService

final class XLectureCollectionAdapter: XLectureCollectionServicesInterface {

    let logger = XLog.logger(category: "XLectureCollectionAdapter")
    let repository: LectureRepositoryInteface
    let queueManagement: QueueManagementServiceInterface

    init(
        queueManagement: QueueManagementServiceInterface,
        lectureRepository: LectureRepositoryInteface
    ) {
        self.repository = lectureRepository
        self.queueManagement = queueManagement
    }

    // MARK: - XLectureCollectionServicesInterface

    func lectures() async throws -> [XEntities.LectureEntity] {
        try await repository.lectures().map { $0.toLectureEntity() }
    }

    func enqueueLecture(id: UUID) async throws {
        await queueManagement.addToQueueAtBottom(id: id)
    }

    func dequeueLecture(id: UUID) async throws {
        await queueManagement.removeFromQueue(id: id)
    }
}
