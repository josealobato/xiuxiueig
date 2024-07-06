// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XOnboarding
import XPreferences

final class XOnboardingAdapter: XOnboardingServicesInterface {

    let prefereces = XPreferencesManagerBuilder.build()

    init() {
        prefereces.declarePreference(key: PreferencesKeys.onboardingPerformed.rawValue,
                                     defaultValue: nil as String?,
                                     mode: .universal)
    }
    func onboardingCompleted() {
        prefereces.savePreference(for: PreferencesKeys.onboardingPerformed.rawValue, value: true)
    }
}
