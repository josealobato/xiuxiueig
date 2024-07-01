// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

/// User defaults happens to conform easily with the `PreferencesStorageProtocol`
/// It is the storage the Preference Manager will use by default.
extension UserDefaults: PreferencesStorageProtocol { }

/// Use the `PreferencesManagerFactory` to create a fully functional `XPreferencesInterface`
/// that uses the `UserDefaults` as storage facility.
public enum XPreferencesManagerBuilder {

    public static func build() -> XPreferencesInterface {

        let storage = UserDefaults(suiteName: "com.josealobato.xiuxiueig").unsafelyUnwrapped
        return PreferencesManager(internalStorage: storage)
    }

    public static func buildRestricted(restrictionKey: String) -> XPreferencesInterface {

        let storage = UserDefaults(suiteName: "com.josealobato.xiuxiueig").unsafelyUnwrapped
        let manager = PreferencesManager(internalStorage: storage)
        manager.restrictionKey = restrictionKey
        return manager
    }
}
