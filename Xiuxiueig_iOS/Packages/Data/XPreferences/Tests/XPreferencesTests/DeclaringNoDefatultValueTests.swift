// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import XCTest

@testable import XPreferences

class DeclaringNoDefatultValueTests: XCTestCase {

    // We use the protocol in the type to abstract the details on its usage
    // simulating a real usage on a module.
    var preferences: XPreferencesInterface!
    var storageMock: PreferencesStorageMock!

    override func setUp() {

        storageMock = PreferencesStorageMock()
        // We instanciate it with a real Manager despite its type is the `Preferences` protocol.
        preferences = PreferencesManager(internalStorage: storageMock)
    }

    // MARK: - A boolean

    func testDeclaringAPreferenceWithNoDefault() {
        /// GIVEN a preferences interface
        /// WHEN declaring a preference without default value,
        preferences.declarePreference(key: "ABool", defaultValue: nil as Bool?, mode: .universal)

        /// THEN we can recover nil as default value.
        let value: Bool? = preferences.preference(for: "ABool")
        XCTAssertNil(value)
    }

    func testDeclaringAPreferenceWithNoDefaultAndGivingValue() {
        /// GIVEN a prefece with no default.
        preferences.declarePreference(key: "ABool", defaultValue: nil as Bool?, mode: .universal)

        /// WHEN the preference receives a value,
        preferences.savePreference(for: "ABool", value: true)

        /// THEN we can recover that value.
        let value: Bool = preferences.preference(for: "ABool")!
        XCTAssert(value)
    }
}
