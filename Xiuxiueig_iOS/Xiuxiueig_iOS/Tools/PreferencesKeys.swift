// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

/// Enum containing all keys for user preferences.
/// These are defined at the application to access prefereces using  the `XPreverences`
/// package. It is mostly the Adapters that will handle them to the features, altho they
/// could also be used on the Use Cases.
enum PreferencesKeys: String {

    /// Login user name
    case userName

    /// Remembering that the user already perform the onboarding
    case onboardingPerformed
}
