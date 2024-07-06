// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XToolKit

public protocol XLoginServicesInterface: AutoMockable {

    /// Request to save the current user name.
    func saveUser(name: String) async throws
}
