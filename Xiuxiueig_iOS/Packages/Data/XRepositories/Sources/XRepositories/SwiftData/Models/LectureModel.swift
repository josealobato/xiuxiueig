// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import SwiftData

@Model
final class LectureModel {
    var externalId: UUID?
    var title: String?

    @Relationship(deleteRule: .nullify)
    var category: CategoryModel?

    var mediaTailURLPath: String?
    var imageURL: URL?

    var queuePosition: Int?
    var playPosition: Int?
    var played: [Date]?

    enum State: String, Codable {
        case new
        case managed
        case archived

        static func from(entityState: LectureDataEntity.State) -> State {
            switch entityState {
            case .new: return .new
            case .managed: return .managed
            case .archived: return .archived
            }
        }
    }
    var state: State?

    init(externalId: UUID? = nil,
         title: String? = nil,
         category: CategoryModel? = nil,
         mediaTailURLPath: String? = nil,
         imageURL: URL? = nil,
         queuePosition: Int? = nil,
         playPosition: Int? = nil,
         played: [Date]? = nil,
         state: State? = nil) {
        self.externalId = externalId
        self.title = title
        self.category = category
        self.mediaTailURLPath = mediaTailURLPath
        self.imageURL = imageURL
        self.queuePosition = queuePosition
        self.playPosition = playPosition
        self.played = played
        self.state = state
    }
}

extension LectureModel {

    func updateWith(entity: LectureDataEntity) {
        // id is not updated
        title = entity.title
        // Not updating the category here.
        mediaTailURLPath = entity.mediaTailURL.path
        queuePosition = entity.queuePosition
        playPosition = entity.playPosition
        played = entity.played
        state = State.from(entityState: entity.state)
    }
}
