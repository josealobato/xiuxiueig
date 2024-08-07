import Foundation
import struct XEntities.LectureEntity

struct LectureViewModel: Identifiable, Equatable {

    let id: UUID
    let title: String
    let subtitle: String
    let timesPlayed: Int
    let imageName: String
    let isStacked: Bool
}

extension LectureViewModel {

    static func build(from lecture: LectureEntity) -> LectureViewModel {

        return LectureViewModel(id: lecture.id,
                                title: lecture.title,
                                subtitle: lecture.category?.title ?? "",
                                timesPlayed: lecture.played.count,
                                imageName: lecture.defaultImageName,
                                isStacked: lecture.isStacked)
    }
}
