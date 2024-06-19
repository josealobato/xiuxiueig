// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

/// It represent a study piece in the application.
/// It will provide access to the minimum information as well
/// as the media itself.
public struct LectureEntity: Identifiable, Equatable {

    public var id: String
    public var title: String
    public var category: CategoryEntity?
    public var mediaURL: URL
    public let imageURL: URL?
    public var queuePosition: Int?
    public var playPosition: Int?
    public var played: [Date]
    public var state: String

    public let defaultImageName: String = "book.closed"

    public init(id: String,
                title: String,
                category: CategoryEntity? = nil,
                mediaURL: URL,
                imageURL: URL? = nil,
                queuePosition: Int? = nil,
                playPosition: Int? = nil,
                played: [Date] = [],
                state: String = "new"
    ) {
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

    public var isStacked: Bool { queuePosition != nil }
    public var isPlaying: Bool { playPosition != nil }
    public var numberOfPlays: Int { played.count }
}

// MARK: - Image
//         Here we can add the management of the image to be displayed.
