// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import XCTest

@testable import XPreferences

class DifferentTypesTest: XCTestCase {

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

    func testDeclaringABoolean() {
        /// GIVEN a preferences interface
        /// WHEN declaring a boolean preference with default value.
        preferences.declarePreference(key: "ABool", defaultValue: true, mode: .universal)

        /// THEN we can recover that value.
        let value: Bool = preferences.preference(for: "ABool")!
        XCTAssert(value)
    }

    func testSavingABoolean() {
        /// GIVEN a preferences interface
        /// WHEN declaring a boolean preference with default value, and changing it value later.
        preferences.declarePreference(key: "ABool", defaultValue: true, mode: .universal)
        preferences.savePreference(for: "ABool", value: false)

        /// THEN we can recover that value.
        let value: Bool = preferences.preference(for: "ABool")!
        XCTAssertFalse(value)
    }

    // MARK: - An Integer

    func testDeclaringAnInteger() {
        /// GIVEN a preferences interface
        /// WHEN declaring an integer preference with default value.
        preferences.declarePreference(key: "AnInt", defaultValue: 3, mode: .universal)

        /// THEN we can recover that value.
        let value: Int = preferences.preference(for: "AnInt")!
        XCTAssert(value == 3)
    }

    func testSavingAnInteger() {
        /// GIVEN a preferences interface
        /// WHEN declaring a boolean preference with default value, and changing it value later.
        preferences.declarePreference(key: "AnInt", defaultValue: 3, mode: .universal)
        preferences.savePreference(for: "AnInt", value: 66)

        /// THEN we can recover that value.
        let value: Int = preferences.preference(for: "AnInt")!
        XCTAssert(value == 66)
    }

    // MARK: - A Struct

    struct TestStruct: Codable, Equatable {
        var anInt: Int
        var aString: String
        var aBool: Bool
    }

    func testDeclaringACodableStruct() {
        /// GIVEN a preferences interface and codable struct to save
        let ts1 = TestStruct(anInt: 1, aString: "two", aBool: false)

        /// WHEN declaring a preference with default value.
        preferences.declarePreference(key: "AnTS", defaultValue: ts1, mode: .universal)

        /// THEN we can recover that preferece.
        let value: TestStruct = preferences.preference(for: "AnTS")!
        XCTAssertEqual(value, ts1)
    }

    func testSavingACodableStruct() {
        /// GIVEN a preferences interface and codable struct to save
        let ts1 = TestStruct(anInt: 1, aString: "two", aBool: false)

        /// WHEN declaring a preference with default value and change its value
        preferences.declarePreference(key: "AnTS", defaultValue: ts1, mode: .universal)
        let ts2 = TestStruct(anInt: 2, aString: "three", aBool: true)
        preferences.savePreference(for: "AnTS", value: ts2)

        /// THEN we can recover that preferece.
        let value: TestStruct = preferences.preference(for: "AnTS")!
        XCTAssertEqual(value, ts2)
    }

    // MARK: - Mixing types

    func testDeclaringDifferentTypes() {
        /// GIVEN a preferences interface
        /// WHEN declaring a boolean and an int preferences with default value.
        preferences.declarePreference(key: "ABool", defaultValue: true, mode: .universal)
        preferences.declarePreference(key: "AnInt", defaultValue: 3, mode: .universal)

        /// THEN we can recover those values.
        let boolValue: Bool = preferences.preference(for: "ABool")!
        XCTAssert(boolValue)
        let intValue: Int = preferences.preference(for: "AnInt")!
        XCTAssert(intValue == 3)
    }

    func testSavingDifferentTypes() {
        /// GIVEN a preferences interface
        /// WHEN declaring a boolean and an int preferences with default value and changing them
        preferences.declarePreference(key: "ABool", defaultValue: true, mode: .universal)
        preferences.declarePreference(key: "AnInt", defaultValue: 3, mode: .universal)

        preferences.savePreference(for: "ABool", value: false)
        preferences.savePreference(for: "AnInt", value: 66)

        /// THEN we can recover those values.
        let boolValue: Bool = preferences.preference(for: "ABool")!
        XCTAssertFalse(boolValue)
        let intValue: Int = preferences.preference(for: "AnInt")!
        XCTAssert(intValue == 66)
    }
}
