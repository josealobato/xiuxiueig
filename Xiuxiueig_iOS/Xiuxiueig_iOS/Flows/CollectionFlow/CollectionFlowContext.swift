// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XQueueManagementService

/// The context for a flow contains all data that is considered constant for the
/// give flow.
///
/// The context's goal is to avoid undertainte abaout the availability of important
/// data for a flow. We skip optionals and reduce complexity by stating that the data
/// is the context is there and unmutable.
struct CollectionFlowContext {

    /// A name that identifier the current user.
    let userName: String

    /// The queue management service for the current user.
    let queueManagementService: QueueManagementServiceInterface
}
