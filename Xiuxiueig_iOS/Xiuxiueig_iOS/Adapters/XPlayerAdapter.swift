// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XPlayer

class XPlayerAdapter: XPlayerServiceInterface {
    func nextLecture() async throws -> (any XPlayer.XPlayerLecture)? {
        nil
    }

    func playing(id: String, in second: Int) async {
    }

    func paused(id: String, in second: Int) async {
    }

    func skipped(id: String, in second: Int) async {
    }

    func donePlaying(id: String) async throws {
    }
}
