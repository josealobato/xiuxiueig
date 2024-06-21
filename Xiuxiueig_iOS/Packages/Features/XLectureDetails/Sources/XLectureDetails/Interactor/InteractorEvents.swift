import Foundation
import XToolKit
import struct XEntities.LectureEntity
import struct XEntities.CategoryEntity

enum InteractorEvents {

    enum Input {

        case loadInitialData
        case save(ViewModel)
    }

    enum Output: Equatable {

        case startLoading
        case refresh(LectureEntity, [XEntities.CategoryEntity])

        static func == (lhs: InteractorEvents.Output, rhs: InteractorEvents.Output) -> Bool {

            switch (lhs, rhs) {
            case (.startLoading, .startLoading): return true
            case let (.refresh(lhsLecture, lhsCategories), .refresh(rhsLecture, rhsCategories)):
                return lhsLecture == rhsLecture && lhsCategories == rhsCategories
            default: return false
            }
        }
    }
}

protocol InteractorInput: AnyObject, AutoMockable {

    func request(_ event: InteractorEvents.Input) async
}

protocol InteractorOutput: AnyObject, AutoMockable {

    func dispatch(_ event: InteractorEvents.Output)
}
