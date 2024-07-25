// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

/// Based on a seed generate a string that resembles a UUID
/// like:
/// `11111111-1111-1111-1111-111111111111`
///
/// - Parameter seed: the value that will repeat
/// - Returns: a uuid string
public func uuidString(_ seed: String) -> String {

    let hyphen = [7, 11, 15, 19]

    var pattern = ""
    for index in 0..<32 {
        pattern += seed
        if hyphen.contains(index) {
            pattern += "-"
        }
    }
    return pattern
}

/// Based on a seed generate a uuid
/// like:
/// `11111111-1111-1111-1111-111111111111`
///
/// - Parameter seed: the value that will repeat
/// - Returns: the uuid
public func uuid(_ seed: String) -> UUID {

    let uuidString = uuidString(seed)
    return UUID(uuidString: uuidString)!
}
