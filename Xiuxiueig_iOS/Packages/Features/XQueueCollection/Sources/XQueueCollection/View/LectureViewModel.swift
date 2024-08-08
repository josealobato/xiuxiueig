// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import struct XEntities.LectureEntity

struct LectureViewModel: Identifiable, Equatable {

    let id: UUID
    let title: String
    let subtitle: String
    let imageName: String
}

extension LectureViewModel {

    static func build(from lecture: LectureEntity) -> LectureViewModel {

        LectureViewModel(id: lecture.id,
                         title: lecture.title,
                         subtitle: lecture.category?.title ?? "",
                         imageName: lecture.defaultImageName)
    }
}
