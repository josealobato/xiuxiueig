// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XToolKit
import struct XEntities.GoalEntity

public protocol XGoalPickerServiceInterface: AutoMockable {

    /// Get all existing goals.
    func getAvailableGoals() async throws -> [GoalEntity]
}
