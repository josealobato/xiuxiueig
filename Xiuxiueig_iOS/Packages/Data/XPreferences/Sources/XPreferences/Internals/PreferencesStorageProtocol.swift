// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

/// Low level storage protocol.
///
/// The `PreferencesStorageProtocol` defines the type of storage than can be
/// used by the `PreferencesManager` to store and retrive data.
///
/// Notice that `UserDefaults` already matches this protocol.
public protocol PreferencesStorageProtocol {

    func dictionary(forKey defaultName: String) -> [String: Any]?
    func set(_ value: Any?, forKey defaultName: String)
}
