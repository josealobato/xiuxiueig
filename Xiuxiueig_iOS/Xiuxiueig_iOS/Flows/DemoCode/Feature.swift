// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI

enum Feature: String, Identifiable {
    case sampleTab1
    case sampleTab2
    case sampleTab3

    var id: String { self.rawValue }
}
