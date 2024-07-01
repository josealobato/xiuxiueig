// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import XCTest

@testable import XPreferences

class DeclaringTests: XCTestCase {

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

    func testDeclaringANONExistingPreferenceWithDefaultsWillSaveTheDefault() {
        /// GIVEN a preferences interface
        /// WHEN declaring a preference with default value,
        preferences.declarePreference(key: "APref", defaultValue: true as Bool?, mode: .universal)

        /// THEN we can recover that  value.
        let value = preferences.preference(for: "APref") as Bool?
        XCTAssert(value!)
    }

    func testReDeclaringAnExistingPreferenceWithDefaultsWillNOTAffectThePreviousValue() {
        /// GIVEN a preferences interface.
        /// with a given value saved.
        preferences.declarePreference(key: "APref", defaultValue: true as Bool?, mode: .universal)

        /// WHEN the preferences engine is reinitialized
        preferences = PreferencesManager(internalStorage: storageMock)
        /// and the preference redeclared
        preferences.declarePreference(key: "APref", defaultValue: false as Bool?, mode: .universal)

        /// THEN the new default value does not affect to the already existing value.
        let value: Bool = preferences.preference(for: "APref")!
        XCTAssert(value)
    }

    // MARK: - Un declared

    func testSavingUndeclaredSettings() {
        /// GIVEN a preferences interface
        /// WHEN saving an undeclared setting
        preferences.savePreference(for: "APref", value: 33)

        /// THEN the value wont be saved.
        let value = preferences.preference(for: "APref") as Int?
        XCTAssertNil(value)
    }

}
