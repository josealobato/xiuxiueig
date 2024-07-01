import Foundation
@testable import XPreferences

class PreferencesStorageMock: PreferencesStorageProtocol {

    var storage: [String: Any] = [:]

    func dictionary(forKey defaultName: String) -> [String: Any]? {
        storage[defaultName] as? [String: Any]
    }

    func set(_ value: Any?, forKey defaultName: String) {
        storage[defaultName] = value
    }
}
