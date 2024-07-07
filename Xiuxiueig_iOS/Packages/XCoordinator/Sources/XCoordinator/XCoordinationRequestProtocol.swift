// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XToolKit

/// Features use this protocol to request coordination actions to a given coordinator.
public protocol XCoordinationRequestProtocol: AnyObject, AutoMockable {

    /// Request for coordination to a coordinator.
    /// - Parameters:
    ///   - feature: The feature identify itself. This will allow to
    ///   a coordinator to be smart and show things differently for
    ///   diferent feature when needed.
    ///   - request: The coordination action to be performed.
    func coordinate(from feature: XCoordinated, request: XCoordinationRequest)
}
