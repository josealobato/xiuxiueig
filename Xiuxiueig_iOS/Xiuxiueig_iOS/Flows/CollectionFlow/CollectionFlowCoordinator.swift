// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

import SwiftUI
import XCoordinator
import XToolKit
import XLectureCollection

/// The coordinator managing the flow on the collection tab.
final class CollectionFlowCoordinator: XCoordinatorProtocol, ObservableObject {

    let logger = XLog.logger(category: "CollectionFlowCoordinator")
    var isStarted: Bool = false
    var parentCoordinator: (any XCoordinator.XCoordinationRequestProtocol)?
    var childCoordinators: [any XCoordinator.XCoordinatorProtocol] = []

    init() {
        logger.debug("init CollectionFlowCoordinator")
    }

    deinit {
        logger.debug("deinit CollectionFlowCoordinator")
    }

    func start() {
        logger.debug("start CollectionFlowCoordinator")
        isStarted = true
    }

    func stop() {
        logger.debug("stop CollectionFlowCoordinator")
        isStarted = false
    }

    // Navigation
    @Published var path = NavigationPath()
    @Published var sheet: Feature?
    @Published var screenCover: Feature?

    private func present(sheet: Feature) { self.sheet = sheet }
    private func present(screenCover: Feature) { self.screenCover = screenCover }
    private func dismissSheet() { sheet = nil; screenCover = nil}
    private func dismissScreenCover() { screenCover = nil }
    private func backToRoot() { path.removeLast(path.count) }
}

///
/// This extension provides the view associated with the Coordinator
///
extension CollectionFlowCoordinator {

    @ViewBuilder
    func baseCoordinatorView() -> some View {
        let adapter = XLectureCollectionAdapter()
        XLectureCollectionBuilder.build(services: adapter,
                                        coordinator: self)
    }
}

// MARK: - CoordinatorRequestProtocol

///
/// Conformance of the `XCoordinatorRequestProtocol` of the `AppFlowCoordinator`
///
extension CollectionFlowCoordinator: XCoordinationRequestProtocol {

    func coordinate(from feature: XCoordinator.XCoordinated, request: XCoordinator.XCoordinationRequest) {

        switch feature {
        default:
            logger.debug(
                "Coordinator: Nothing to coordinate for feature \(feature.rawValue) and request \(request)"
            )
        }
    }
}
