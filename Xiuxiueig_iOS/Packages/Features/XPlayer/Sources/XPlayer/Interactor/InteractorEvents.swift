// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XToolKit
import struct XEntities.LectureEntity

enum InteractorEvents {

    enum Input {

        case loadInitialData
        case playToggle
        case skipForward
        case skipBackwards
    }

    enum Output: Equatable {

        // swiftlint:disable:next nesting
        struct LectureData: Equatable {

            static func == (
                lhs: InteractorEvents.Output.LectureData,
                rhs: InteractorEvents.Output.LectureData
            ) -> Bool {

                // Implementing Equatable in the PlayerLecture protocol complicate things,
                // so, since the entity is small we do it here manually.
                lhs.lecture.id == rhs.lecture.id &&
                lhs.lecture.title == rhs.lecture.title &&
                lhs.lecture.mediaURL == rhs.lecture.mediaURL &&
                lhs.audio == rhs.audio
            }

            let lecture: XPlayerLecture
            let audio: AudioInfo
        }

        case startLoading
        case noLecture
        case refresh(LectureData)

        static func == (lhs: InteractorEvents.Output, rhs: InteractorEvents.Output) -> Bool {

            switch (lhs, rhs) {
            case (.startLoading, .startLoading): return true
            case (.noLecture, .noLecture): return true
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
