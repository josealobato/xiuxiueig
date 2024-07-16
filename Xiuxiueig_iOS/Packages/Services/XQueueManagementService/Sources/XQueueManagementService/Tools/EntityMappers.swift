// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XRepositories
import struct XEntities.CategoryEntity
import struct XEntities.LectureEntity

// MARK: - Mappers

extension LectureDataEntity {

    func entity() -> LectureEntity {

        LectureEntity(id: self.id,
                      title: self.title,
                      category: self.category?.entity(),
                      mediaURL: self.mediaURL,
                      imageURL: self.imageURL,
                      queuePosition: self.queuePosition,
                      playPosition: self.playPosition,
                      played: self.played)
    }
}

extension CategoryDataEntity {

    func entity() -> CategoryEntity {

        CategoryEntity(id: self.id,
                       title: self.title,
                       imageURL: self.imageURL,
                       defaultImage: self.defaultImage)
    }
}

extension LectureEntity {

    func dataEntity() -> LectureDataEntity {

        LectureDataEntity(id: self.id,
                          title: self.title,
                          category: self.category?.dataEntity(),
                          mediaURL: self.mediaURL,
                          queuePosition: self.queuePosition,
                          playPosition: self.playPosition,
                          played: self.played)
    }
}

extension CategoryEntity {

    func dataEntity() -> CategoryDataEntity {

        CategoryDataEntity(id: self.id,
                           title: self.title,
                           imageURL: self.imageURL)
    }
}
