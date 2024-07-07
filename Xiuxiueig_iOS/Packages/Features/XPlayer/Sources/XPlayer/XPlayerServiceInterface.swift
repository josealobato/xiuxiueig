// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XToolKit
import struct XEntities.LectureEntity

public protocol XPlayerServiceInterface: AutoMockable {

    // MARK: - Requests

    /// Get the existing lectures if any
    func nextLecture() async throws -> XPlayerLecture?

    // MARK: - Information

    /// Started playing media.
    /// - Parameters:
    ///   - id: The id of the media
    ///   - second: the second at the moment of start. `0` when it is at the beginning.
    func playing(id: String, in second: Int) async

    /// Paused playing media.
    /// - Parameters:
    ///   - id: The id of the media
    ///   - second: the second at the moment of pause.
    func paused(id: String, in second: Int) async

    /// skipped media.
    /// - Parameters:
    ///   - id: The id of the media
    ///   - second: the second at the moment of skipt request.
    func skipped(id: String, in second: Int) async

    /// Inform that it finishes completly playing a file.
    /// - Parameter id: the id of the media finished.
    func donePlaying(id: String) async throws
}
