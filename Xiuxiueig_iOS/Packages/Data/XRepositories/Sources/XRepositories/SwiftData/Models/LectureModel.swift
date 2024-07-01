// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import SwiftData

@Model
final class LectureModel {
    var id: UUID?
    var title: String?

    @Relationship(deleteRule: .nullify)
    var category: CategoryModel?

    var mediaURL: URL?
    var imageURL: URL?

    var queuePosition: Int?
    var playPosition: Int?
    var played: [Date]?

    enum State: String, Codable {
        case new
        case managed
        case archived
    }
    var state: State?

    init(id: UUID? = nil,
         title: String? = nil,
         category: CategoryModel? = nil,
         mediaURL: URL? = nil,
         imageURL: URL? = nil,
         queuePosition: Int? = nil,
         playPosition: Int? = nil,
         played: [Date]? = nil,
         state: State? = nil) {
        self.id = id
        self.title = title
        self.category = category
        self.mediaURL = mediaURL
        self.imageURL = imageURL
        self.queuePosition = queuePosition
        self.playPosition = playPosition
        self.played = played
        self.state = state
    }
}
