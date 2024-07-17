// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import struct XEntities.CategoryEntity
import struct XRepositories.CategoryDataEntity

extension CategoryDataEntity {

    func toCategoryEntity() -> CategoryEntity {

        CategoryEntity(id: id,
                       title: title,
                       imageURL: imageURL,
                       defaultImage: defaultImage)

    }
}
