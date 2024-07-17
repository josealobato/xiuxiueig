// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import struct XEntities.LectureEntity
import struct XRepositories.LectureDataEntity

extension LectureDataEntity {

    func toLectureEntity() -> LectureEntity {

        LectureEntity(id: id,
                      title: title,
                      category: category?.toCategoryEntity(),
                      mediaURL: mediaURL,
                      imageURL: imageURL,
                      queuePosition: queuePosition,
                      played: played)
    }
}
