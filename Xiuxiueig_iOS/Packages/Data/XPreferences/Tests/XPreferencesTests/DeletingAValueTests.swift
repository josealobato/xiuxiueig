// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import XCTest

@testable import XPreferences

class DeletingAValueTests: XCTestCase {

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

    func testSavingANiValueDeletesADefaultValue() {
        /// GIVEN a declared preference with default value.
        preferences.declarePreference(key: "ABool", defaultValue: true, mode: .universal)

        /// WHEN saving nil on that value
        preferences.savePreference(for: "ABool", value: nil as Bool?)

        /// THEN we can recover that value and will be nil.
        let value: Bool? = preferences.preference(for: "ABool")
        XCTAssertNil(value)
    }

    func testSavingANiValueDeletesAValue() {
        /// GIVEN a declared preference with default value, that has received a new value
        preferences.declarePreference(key: "ABool", defaultValue: false, mode: .universal)
        preferences.savePreference(for: "ABool", value: true)

        /// WHEN saving nil on that value
        preferences.savePreference(for: "ABool", value: nil as Bool?)

        /// THEN we can recover that value and will be nil.
        let value: Bool? = preferences.preference(for: "ABool")
        XCTAssertNil(value)
    }
}
