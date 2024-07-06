// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XSettings
import XPreferences

final class XSettingsAdapter: XSettingsServicesInterface {

    let preferences = XPreferencesManagerBuilder.build()

    init() { }

    func deleteAllSettings() {
        assert(false, "Missing implementation.")
    }
}
