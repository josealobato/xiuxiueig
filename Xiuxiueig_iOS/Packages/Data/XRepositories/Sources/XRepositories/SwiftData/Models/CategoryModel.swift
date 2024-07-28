// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import SwiftData

@Model
final class CategoryModel {
    var externalId: UUID?
    var title: String?
    var imageURL: URL?

    init(externalId: UUID? = nil, title: String? = nil, imageURL: URL?) {
        self.externalId = externalId
        self.title = title
        self.imageURL = imageURL
    }
}
