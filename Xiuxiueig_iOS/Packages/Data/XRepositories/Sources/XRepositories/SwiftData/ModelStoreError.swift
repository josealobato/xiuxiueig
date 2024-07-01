// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

// This code is based on the Persistence implemenentation of my friend
// Alejandro Ramirez `Jano`.

import Foundation
import SwiftData

enum ModelStoreError: Error, CustomStringConvertible, Equatable {

    // Keep this enumeration sorted alphabetically
    case missingObjectWithId(PersistentIdentifier)

    // CustomStringConvertible
    var description: String {
        switch self {
        case .missingObjectWithId(let id):
            "Expected to find object with id \(id)"

        }
    }
}
