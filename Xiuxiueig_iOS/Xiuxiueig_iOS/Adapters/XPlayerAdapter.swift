// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XPlayer

class XPlayerAdapter: XPlayerServiceInterface {
    func nextLecture() async throws -> (any XPlayer.XPlayerLecture)? {
        nil
    }

    func playing(id: UUID, in second: Int) async {
    }

    func paused(id: UUID, in second: Int) async {
    }

    func skipped(id: UUID, in second: Int) async {
    }

    func donePlaying(id: UUID) async throws {
    }
}
