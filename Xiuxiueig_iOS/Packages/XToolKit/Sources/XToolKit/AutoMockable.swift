// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

/// AutoMockable is a empty protocol that is used to tag interfaces.
///
/// When an interface is tagged with `AutoMockable` (conforming to it)
/// the mock generation tool will generate a mock for it. It will be used
/// almost in all interfaces for easy testing.
public protocol AutoMockable { }
