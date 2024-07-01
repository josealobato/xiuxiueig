// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

public struct CategoryDataEntity: Identifiable, Equatable {

    public let id: UUID
    public var title: String
    public var imageURL: URL?

    // This is the FS symbol associated with every.
    // one like `text.book.closed` can be set by default.
    public var defaultImage: String {
        "text.book.closed"
    }

    public init(id: UUID,
                title: String,
                imageURL: URL?) {

        self.id = id
        self.title = title
        self.imageURL = imageURL
    }
}

// MARK: - Extensions to convert to and from model

extension CategoryDataEntity {

    func categoryModel() -> CategoryModel {
        CategoryModel(id: self.id,
                      title: self.title,
                      imageURL: self.imageURL)
    }

    static func from(model: CategoryModel) -> Self {

        CategoryDataEntity(id: model.id ?? UUID(),
                           title: model.title ?? "",
                           imageURL: model.imageURL)

    }
}
