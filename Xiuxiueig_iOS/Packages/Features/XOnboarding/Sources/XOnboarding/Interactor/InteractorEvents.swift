// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XToolKit

enum InteractorEvents {

    enum Input {
        case loadInitialData
        case done
    }

    enum Output: Equatable {
        case userName(String)
    }
}

protocol InteractorInput: AutoMockable {
    func request(_ event: InteractorEvents.Input) async
}

protocol InteractorOutput: AutoMockable {
    func dispatch(_ event: InteractorEvents.Output)
}
