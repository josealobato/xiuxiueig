// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import OSLog

/// A simple wrapper around OSLog logger.
/// But, this wrapper does not pretend to be a full wrap but just a
/// facility to do not leak details of the log (like the subsystem).
///
/// How to use it:
/// 1. Create a logger selecting a category relevant for your logs.
/// ```
/// let logger = XLog.logger(category: "AppFlowCoordinator")
/// ```
///
/// 2. Used it as you will use any Logger from OSLog.
/// ```
/// logger.debug("This is happening!")
/// ```
public struct XLog {

    static let subsystem = "com.josealobato.xiuxiueig"

    /// Get a logger for a category
    /// - Parameter category: A category for the log. It is suggested
    /// to use an area of your application like Coordinator.
    /// - Returns: A logger ready to use.
    public static func logger(category: String) -> Logger {
        Logger(subsystem: subsystem, category: category)
    }
}
