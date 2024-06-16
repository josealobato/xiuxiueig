// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

/// It represent a category in the application.
///
/// Categories the basic form of grouping inside the application.
/// It can be a subject, a season, a course, etc.
public struct CategoryEntity: Identifiable, Equatable {

    public let id: String
    public let title: String

    // A categorey will always have a default image
    // but the user can also create a category and assign an image.
    public let imageURL: URL?
    public let defaultImage: String

    public init(id: String,
                title: String,
                imageURL: URL?,
                defaultImage: String) {
        self.id = id
        self.title = title
        self.imageURL = imageURL
        self.defaultImage = defaultImage
    }
}
