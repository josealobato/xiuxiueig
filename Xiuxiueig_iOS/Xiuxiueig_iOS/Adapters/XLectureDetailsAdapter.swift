// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XLectureDetails
import XEntities

final class XLectureDetailsAdapter: XLectureDetailsServiceInterface {

    func lecture(withId id: UUID) async throws -> XEntities.LectureEntity {
        LectureEntity(id: id,
                      title: "What is a square root?",
                      category: CategoryEntity(id: UUID(),
                                               title: "Mathematics",
                                               imageURL: nil,
                                               defaultImage: "pyramid"),
                      mediaTailURL: URLComponents())
    }

    func categories() async throws -> [XEntities.CategoryEntity] {
        [
            CategoryEntity(id: UUID(),
                           title: "Mathematics",
                           imageURL: nil,
                           defaultImage: "pyramid"),
            CategoryEntity(id: UUID(),
                           title: "History",
                           imageURL: nil,
                           defaultImage: "map")
        ]
    }

    func save(lecture: XEntities.LectureEntity) async throws {

    }
}
