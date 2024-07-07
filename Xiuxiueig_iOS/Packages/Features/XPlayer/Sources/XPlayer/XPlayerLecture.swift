// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

/// For convenience I use a protocol here.
/// This may cause issues if Equatable or Identifiable is needed
/// as any moment (any), but since it is not needed yet It simplyfy things.
public protocol XPlayerLecture {

    var id: String { get }
    var title: String { get }
    var mediaURL: URL { get }
}
