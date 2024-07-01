// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import SwiftData
import XToolKit

@ModelActor
/// The actor that contains access to the data store.
final actor ModelStore {
    let logger = XLog.logger(category: "ModelStore")

    // Easy access to the model Context.
    public var context: ModelContext { modelContext }
}
