// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import SwiftData

@Model
final class CategoryModel {
    var id: UUID?
    var title: String?
    var imageURL: URL?

    init(id: UUID? = nil, title: String? = nil, imageURL: URL?) {
        self.id = id
        self.title = title
        self.imageURL = imageURL
    }
}
