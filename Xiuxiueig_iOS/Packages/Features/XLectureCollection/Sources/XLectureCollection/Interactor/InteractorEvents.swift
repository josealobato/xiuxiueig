import Foundation
import XToolKit
import struct XEntities.LectureEntity

enum InteractorEvents {

    enum Input {

        case loadInitialData
        case select(UUID)
        case play(UUID)
        case enqueue(UUID)
        case dequeue(UUID)
        case delete(UUID)
    }

    enum Output: Equatable {

        case startLoading
        case refresh([LectureEntity])

        static func == (lhs: InteractorEvents.Output, rhs: InteractorEvents.Output) -> Bool {

            switch (lhs, rhs) {
            case (.startLoading, .startLoading): return true
            case let (.refresh(lhsValue), .refresh(rhsValue)):
                return lhsValue == rhsValue
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
