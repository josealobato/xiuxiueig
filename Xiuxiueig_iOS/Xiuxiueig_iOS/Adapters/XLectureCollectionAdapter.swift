// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XLectureCollection
import XEntities

final class XLectureCollectionAdapter: XLectureCollectionServicesInterface {
    func lectures() async throws -> [XEntities.LectureEntity] {
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

    }

    func dequeueLecture(id: UUID) async throws {

    }
}
