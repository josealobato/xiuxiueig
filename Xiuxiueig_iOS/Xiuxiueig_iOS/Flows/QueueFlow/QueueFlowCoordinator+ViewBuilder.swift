// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI
import XLectureDetails

/// This extension contains the build facility of the Coordinator.
///

extension QueueFlowCoordinator {

    @ViewBuilder
    /// The cooridnator knows how to build the Views for every functionality (Feature).
    ///
    /// Every feature has a Builder, so the task of the coordinator will be to
    /// fulfill the features needs (usualy the systems interface), build the feature, and
    /// return its view. Notice that the view holds the whole functionality in place.
    /// - Parameter Feature: Feature to build.
    /// - Returns: The feature view.
    func build(feature: Feature) -> some View {
        switch feature {
        case let .lectureDetails(id): buildLectureDetails(with: id)
        }
    }

    // MARK: - Collection of Feature builders.

    @ViewBuilder
    private func buildLectureDetails(with id: UUID) -> some View {
        let adapter = XLectureDetailsAdapter()
        XLectureDetailsBuilder.build(entityId: id, services: adapter)
    }
}
