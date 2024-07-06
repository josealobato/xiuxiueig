// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XToolKit

public protocol XSettingsServicesInterface: AutoMockable {

    // Here we will need to collect all settings that we want to show.

    /// Request to get rid of all settings of the application
    func deleteAllSettings() async
}
