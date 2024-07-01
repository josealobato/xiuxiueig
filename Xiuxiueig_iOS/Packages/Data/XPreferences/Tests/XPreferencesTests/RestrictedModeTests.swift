// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import XCTest

@testable import XPreferences

class RestrictedModeTest: XCTestCase {

    // We use the protocol in the type to abstract the details on its usage
    // simulating a real usage on a module.
    var preferences: XPreferencesInterface!
    var storageMock: PreferencesStorageMock!

    override func setUp() {

        storageMock = PreferencesStorageMock()
        // We instanciate it with a real Manager despite its type is the `Preferences` protocol.
    }

    // MARK: - Without restriction key.

    func testNoRestrictionKey() {
        // GIVEN a preferences interface with no restriction key
        preferences = PreferencesManager(internalStorage: storageMock)

        // WHEN declaring a preference as restricted
        preferences.declarePreference(key: "APrefernece", defaultValue: true, mode: .restricted)

        // THEN the preference will be saved anyway
        let value: Bool? = preferences.preference(for: "APrefernece")
        XCTAssert(value!)
    }

    // MARK: - With restriction key.

    func testWithRestrictionKey() {
        // GIVEN a preferences manager with a restriction key
        preferences = PreferencesManager(internalStorage: storageMock)
        (preferences as? PreferencesManager)?.restrictionKey = "ARestrictionKey"

        // WHEN declaring a preference as restricted
        preferences.declarePreference(key: "APrefernece", defaultValue: true, mode: .restricted)

        // THEN the preference will can be recoved
        let value: Bool? = preferences.preference(for: "APrefernece")
        XCTAssert(value!)
    }

    // MARK: - Multiple restriction keys.

    func testSeveralRestrictionKeys() {
        // GIVEN a declare a preference on a manager with a restriction key
        preferences = PreferencesManager(internalStorage: storageMock)
        (preferences as? PreferencesManager)?.restrictionKey = "RestrictionKey1"
        preferences.declarePreference(key: "APrefernece", defaultValue: true, mode: .restricted)

        // WHEN Changing then restriction key
        (preferences as? PreferencesManager)?.restrictionKey = "RestrictionKey2"

        // THEN the declared key is undeclared.
        let valueNotFound: Bool? = preferences.preference(for: "APrefernece")
        XCTAssertNil(valueNotFound)

        // WHEN restoring the restriction key
        (preferences as? PreferencesManager)?.restrictionKey = "RestrictionKey1"

        // THEN the declared key is declared.
        let valueFound: Bool? = preferences.preference(for: "APrefernece")
        XCTAssert(valueFound!)
    }
}
