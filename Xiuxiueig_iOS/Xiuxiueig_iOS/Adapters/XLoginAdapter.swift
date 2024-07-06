// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XLogin
import XPreferences

final class XLoginAdapter: XLoginServicesInterface {

    let prefereces = XPreferencesManagerBuilder.build()

    init() {
        prefereces.declarePreference(key: PreferencesKeys.userName.rawValue,
                                     defaultValue: nil as String?,
                                     mode: .universal)
    }

    func saveUser(name: String) async throws {
        prefereces.savePreference(for: PreferencesKeys.userName.rawValue, value: name)
    }
}
