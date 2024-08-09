// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XToolKit
import struct XEntities.GoalEntity

enum InteractorEvents {

    enum Input {

        case loadInitialData
        case select(UUID)
    }

    enum Output: Equatable {

        case startLoading
        case refresh([GoalEntity])

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
