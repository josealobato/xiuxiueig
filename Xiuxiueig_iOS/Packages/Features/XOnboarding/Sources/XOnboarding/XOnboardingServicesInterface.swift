// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XToolKit

public protocol XOnboardingServicesInterface: AutoMockable {

    /// Inform the system that the onboarding has been completed.
    /// It is a request for the system to remember that the user has completed.
    /// It is suggested to save that information for the future.
    func onboardingCompleted()
}
