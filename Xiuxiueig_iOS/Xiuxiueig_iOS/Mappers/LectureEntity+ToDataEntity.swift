// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import struct XEntities.LectureEntity
import struct XRepositories.LectureDataEntity

extension LectureEntity {

    func toDataLecture() -> LectureDataEntity? {

        let categoryData = category?.toDataCategory()

        return LectureDataEntity(id: id,
                                 title: title,
                                 category: categoryData,
                                 mediaTailURL: mediaTailURL,
                                 queuePosition: queuePosition,
                                 playPosition: playPosition,
                                 played: played,
                                 state: LectureDataEntity.State(rawValue: state) ?? .managed)
    }
}
