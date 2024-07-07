// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

/// PreferenceMode is selected when declaring a key to save, and informs the preferences
/// engine about the desired storage type.
public enum XPreferenceMode: String {

    // In this mode the same value is available always without restrictions.
    // For example a value that should be available at the level of the device.
    case universal
    // In this mode the value is restricted to some given `retrictionKey`.
    // For example a value that can only be retrived fora given user or account.
    // The restriction key should be set on the engine and you might have many restriction
    // keys.
    case restricted
}

/// The `Preferences` protocol is to be use anywhere we need to persist preferences.
/// This can be useful on the UI for drafts or UI setting, or in the app initial state
/// anywhere in the application.
///
/// **How to use it:**
///
/// NOTE: The the engine should be initialized first (see README.md)
///
/// You should always declare your setting before using it and provide a default value.
/// If the key was already in place it will do nothing.
///
/// ```swift
/// preferences.declarePreference(key: "MessageEditor.CheckboxStatus",
///                               defaultValue: false,
///                               mode: .restricted)
/// ```
///
/// From that moment on you can read or write freely:
///
/// ```swift
/// //...
/// checkboxStatus = preferences.preference(for: "MessageEditor.CheckboxStatus")
/// //...
/// preferences.savePreference(for: "MessageEditor.CheckboxStatus", value: checkboxStatus)
/// //...
/// ```
///
/// **Technical note:**
/// This is a generic interface so it needs the type to use the right method. When giving `nil`
/// values you can indicate the type with `nil as <Type>?`, as follows:
/// ```swift
/// preferences.declarePreference(key: "APref", defaultValue: nil as Bool?, mode: .universal)
/// preferences.savePreference(for: "APref", value: nil as Bool?)
/// ```
///
public protocol XPreferencesInterface {

    /// Declare a preference with an optional default value.
    /// - Parameters:
    ///   - key: Key to use to save and recover the value afterwards.
    ///   - defaultValue: Default value if any.
    ///   - mode: Select in which mode this preference will be available.
    func declarePreference<T: Codable> (key: String, defaultValue: T?, mode: XPreferenceMode)

    /// Retrieving a preference.
    /// - Parameter key: Key associated to the preference.
    /// - Returns: The preference value. It will be nil when the preference does not exist,
    ///            or doesn't have value because it has no default or has been deleted.
    func preference<T: Codable>(for key: String) -> T?

    /// Save a preference.
    /// - Parameters:
    ///   - key: The key of the preference to save.
    ///   - value: The value to save or `nil` to delete the value.
    func savePreference<T: Codable>(for key: String, value: T?)

    /// Clear all the preferences for the given mode
    /// - Parameter mode: The mode to clean up
    func clearPreferences(for mode: XPreferenceMode)

    /// Clear all preferences for all modes
    func clearAllPreferences()
}
