// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XToolKit

class PreferencesManager: XPreferencesInterface {

    let logger = XLog.logger(category: "PreferencesManager")

    private let identifierPrefix = "PreferencesManager"

    /// When requesting a preference in restricted mode it will be needed
    /// an account identifiers to retrive the appropiate setting.
    /// * When this value is not given, all requests will be `universal`.
    /// * When this value is given, restricted will use this to filter the right values.
    var restrictionKey: String?

    /// Notice that calls to `UserDefaults` are thread save but we allow the public API's be
    /// called from any thread.
    /// **Dev Note**: We are not using an Actor to avoid the api calls to be async.
    private let lock = NSLock()

    /// For every key we save the mode to be used.
    private var modes: [String: XPreferenceMode] = [:]

    /// The preference manager could work with any storage facility as long
    /// as it conforms to the `PreferencesStorageProtocol`
    private var internalStorage: PreferencesStorageProtocol

    init(internalStorage: PreferencesStorageProtocol) {

        self.internalStorage = internalStorage
    }

    // MARK: - Storage

    /// There preferences is saved with two different keys depending on the mode
    /// an whether the restriction key exist.
    private var storageKeyUniversal: String { identifierPrefix + "Universal" }
    private var storageKeyRestricted: String { identifierPrefix + (restrictionKey ?? "Universal") }

    /// We retrive different storages depending on the mode.
    private func storage(for mode: XPreferenceMode) -> [String: Any]? {

        switch mode {
        case .universal: return internalStorage.dictionary(forKey: storageKeyUniversal)
        case .restricted: return internalStorage.dictionary(forKey: storageKeyRestricted)
        }
    }

    /// We save different storages depending on the mode.
    private func saveStorage(data: [String: Any], for mode: XPreferenceMode) {
        switch mode {
        case .universal: internalStorage.set(data, forKey: storageKeyUniversal)
        case .restricted: internalStorage.set(data, forKey: storageKeyRestricted)
        }
    }

    // MARK: - Codification helpers

    private func decode<T: Codable>(data: Data) -> T? { try? JSONDecoder().decode(T.self, from: data) }
    private func encode<T: Codable>(object: T) throws -> Data? { try? JSONEncoder().encode(object) }

    // MARK: - Preferences Interface

    func declarePreference<T: Codable> (key: String, defaultValue: T?, mode: XPreferenceMode) {

        defer { lock.unlock() }
        lock.lock()

        // If the key is already declared, there is nothing to do, otherwise...
        if modes[key] == nil {

            // Otherwise we check if there is any value associated to a key and mode.
            // If there is, we just keep the mode for that key.
            if let storage = storage(for: mode),
               storage[key] != nil {

                modes[key] = mode
            }
            // Else, we will save and create the entry with the defaults
            else {

                modes[key] = mode
                // Before calling another method that is also using the lock
                // we need to unlock it. It is safe to do it since there is
                // no further action in this methods.
                lock.unlock()
                savePreference(for: key, value: defaultValue)
            }
        }
    }

    func preference<T: Codable>(for key: String) -> T? {

        defer { lock.unlock() }
        lock.lock()

        // If any, get the mode for the key and then the storage for that mode...
        if let mode = modes[key],
           let storage = storage(for: mode) {

            // Get the value decode it and return it if any.
            guard let data = storage[key] as? Data else { return nil }
            let object: T? = decode(data: data)
            return object
        }

        return nil
    }

    func savePreference<T: Codable>(for key: String, value: T?) {

        defer { lock.unlock() }
        lock.lock()

        // If a value is given
        if let value = value {
            // if the mode exist for that key.
            if let mode = modes[key] {
                guard let data = try? encode(object: value) else { return }

                var storage = storage(for: mode) ?? [:]
                storage[key] = data
                saveStorage(data: storage, for: mode)
                logger.debug("Saved value for key \(key)")
            }
            // Otherwese the value WONT be saved!
            logger.debug("Value not save since key \(key) not declared")

        } else {
            // otherwise remove the key if any.
            if let mode = modes[key] {
                var storage = storage(for: mode) ?? [:]
                storage.removeValue(forKey: key)
                saveStorage(data: storage, for: mode)
                logger.debug("Removed key \(key)")
            }
        }
    }
}
