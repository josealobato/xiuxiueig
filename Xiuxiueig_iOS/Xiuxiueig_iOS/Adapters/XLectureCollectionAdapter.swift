// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XLectureCollection
import XEntities

class XLectureCollectionAdapter: XLectureCollectionServicesInterface {
    func lectures() async throws -> [XEntities.LectureEntity] {
        [
            LectureEntity(id: "1",
                          title: "What is a square root?",
                          category: CategoryEntity(id: "id",
                                                   title: "Mathematics",
                                                   imageURL: nil,
                                                   defaultImage: "pyramid"),
                          mediaURL: URL(string: "https://whatever.com")!),
            LectureEntity(id: "2",
                          title: "The Spanish inquisition",
                          category: CategoryEntity(id: "id",
                                                   title: "History",
                                                   imageURL: nil,
                                                   defaultImage: "map"),
                          mediaURL: URL(string: "https://whatever.com")!)
        ]
    }

    func enqueueLecture(id: String) async throws {

    }

    func dequeueLecture(id: String) async throws {

    }
}
