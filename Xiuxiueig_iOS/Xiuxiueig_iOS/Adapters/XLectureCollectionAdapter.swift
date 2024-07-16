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
            self.repository = try LectureRepositoryBuilder.build()
        } catch  {
            logger.error("XLectureCollectionAdapter error creating repository")
            self.repository = nil
        }
        self.queueManagement = queueManagement
    }

    // MARK: - XLectureCollectionServicesInterface

    func lectures() async throws -> [XEntities.LectureEntity] {

        // For now this method shows demo data, uncomment this and remove demo data when ready.

//        try await repository?.lectures().map { $0.toLectureEntity() }

        [
            LectureEntity(id: UUID(),
                          title: "What is a square root?",
                          category: CategoryEntity(id: UUID(),
                                                   title: "Mathematics",
                                                   imageURL: nil,
                                                   defaultImage: "pyramid"),
                          mediaURL: URL(string: "https://whatever.com")!),
            LectureEntity(id: UUID(),
                          title: "The Spanish inquisition",
                          category: CategoryEntity(id: UUID(),
                                                   title: "History",
                                                   imageURL: nil,
                                                   defaultImage: "map"),
                          mediaURL: URL(string: "https://whatever.com")!)
        ]
    }

    func enqueueLecture(id: UUID) async throws {
        await queueManagement.addToQueueAtBottom(id: id)
    }

    func dequeueLecture(id: UUID) async throws {
        await queueManagement.removeFromQueue(id: id)
    }
}
