// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XLectureDetails
import XEntities

final class XLectureDetailsAdapter: XLectureDetailsServiceInterface {

    func lecture(withId id: String) async throws -> XEntities.LectureEntity {
        LectureEntity(id: "1",
                      title: "What is a square root?",
                      category: CategoryEntity(id: "id",
                                               title: "Mathematics",
                                               imageURL: nil,
                                               defaultImage: "pyramid"),
                      mediaURL: URL(string: "https://whatever.com")!)
    }

    func categories() async throws -> [XEntities.CategoryEntity] {
        [
            CategoryEntity(id: "id",
                           title: "Mathematics",
                           imageURL: nil,
                           defaultImage: "pyramid"),
            CategoryEntity(id: "id",
                           title: "History",
                           imageURL: nil,
                           defaultImage: "map")
        ]
    }

    func save(lecture: XEntities.LectureEntity) async throws {

    }
}
