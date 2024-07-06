// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XToolKit

enum InteractorEvents {

    enum Input {
        case done(String)
    }

    enum Output: Equatable {

        case errorOnSave
    }
}

protocol InteractorInput: AutoMockable {
    func request(_ event: InteractorEvents.Input) async
}

protocol InteractorOutput: AutoMockable {
    func dispatch(_ event: InteractorEvents.Output)
}
