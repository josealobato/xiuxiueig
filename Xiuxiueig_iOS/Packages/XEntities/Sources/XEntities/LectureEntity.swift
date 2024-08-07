// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

/// It represent a study piece in the application.
/// It will provide access to the minimum information as well
/// as the media itself.
public struct LectureEntity: Identifiable, Equatable {

    public var id: UUID
    public var title: String
    public var category: CategoryEntity?
    public var mediaTailURL: URLComponents
    public let imageURL: URL?
    public var queuePosition: Int?
    public var playPosition: Int?
    public var played: [Date]
    public var state: String

    public let defaultImageName: String = "book.closed"

    // For now I have decided getting access to the docs directory directly here.
    // Another posibility is adding a dependency to the Media File System where the
    // `MediaFile` is offering this method and is (and probably should be) the only
    // place where we create the base path.
    static var baseURL: () -> URL? = {
        let fileMng = FileManager.default
        let docsURL = try? fileMng.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        )
        return docsURL
    }

    // TODO: When working with the player, convert this to optional.
    //       Eventhough the URL has to be there always for an entity to be valid,
    //       we will give the prayer the posibility to show a nice error in case
    //       of problems.
    //       (Instead of returning a fake URL)
    public var mediaURL: URL {
        guard let baseURL = LectureEntity.baseURL(),
              let reconstructuredURL = mediaTailURL.url(relativeTo: baseURL)
        else { return URL(string: "https://fail.com")! }

        return reconstructuredURL
    }

    public init(id: UUID,
                title: String,
                category: CategoryEntity? = nil,
                mediaTailURL: URLComponents,
                imageURL: URL? = nil,
                queuePosition: Int? = nil,
                playPosition: Int? = nil,
                played: [Date] = [],
                state: String = "new"
    ) {
        self.id = id
        self.title = title
        self.category = category
        self.mediaTailURL = mediaTailURL
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
