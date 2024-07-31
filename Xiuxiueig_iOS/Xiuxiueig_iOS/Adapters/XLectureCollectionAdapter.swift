// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XLectureCollection
import XToolKit
import XEntities
import XRepositories
import XQueueManagementService

final class XLectureCollectionAdapter: XLectureCollectionServicesInterface {

    let logger = XLog.logger(category: "XLectureCollectionAdapter")
    let repository: LectureRepositoryInteface?
    let queueManagement: QueueManagementServiceInterface

    init(queueManagement: QueueManagementServiceInterface) {
        do {
            self.repository = try LectureRepositoryBuilder.build(
                uRLConsistencyHandler: DataLectureURLConsistencyHandler()
            )
        } catch {
            logger.error("XLectureCollectionAdapter error creating repository")
            self.repository = nil
        }
        self.queueManagement = queueManagement
    }

    // MARK: - XLectureCollectionServicesInterface

    func lectures() async throws -> [XEntities.LectureEntity] {
        try await repository?.lectures().map { $0.toLectureEntity() } ?? []
    }

    func enqueueLecture(id: UUID) async throws {
        await queueManagement.addToQueueAtBottom(id: id)
    }

    func dequeueLecture(id: UUID) async throws {
        await queueManagement.removeFromQueue(id: id)
    }
}

class DataLectureURLConsistencyHandler: LectureURLConsistencyHandler {
    func update(entity: XRepositories.LectureDataEntity) throws -> XRepositories.LectureDataEntity {
        entity // FIXME extract this to its own file and use it in any adapter.
    }
}
