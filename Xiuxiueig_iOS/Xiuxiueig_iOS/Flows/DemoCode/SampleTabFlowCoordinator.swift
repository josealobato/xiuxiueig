// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI
import XCoordinator
import XToolKit

/// This file was created as an example to be able to develop the Coordinator approach.
/// Should be removed when the other coordinators are in place.

/// The `AppFlowCoordinator` is the root coordinator of the application.
/// It will be the last coordinator on attending an event.
final class SampleTabFlowCoordinator: XCoordinatorProtocol, ObservableObject {

    let logger = XLog.logger(category: "SampleTabFlowCoordinator")
    var isStarted: Bool = false
    var parentCoordinator: (any XCoordinator.XCoordinatorRequestProtocol)?
    var childCoordinators: [any XCoordinator.XCoordinatorProtocol] = []

    init() {
        logger.debug("init SampleTabFlowCoordinator")
    }

    deinit {
        logger.debug("init SampleTabFlowCoordinator")
    }

    func start() {
        logger.debug("start SampleTabFlowCoordinator")
        isStarted = true
    }

    func stop() {
        logger.debug("stop SampleTabFlowCoordinator")
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
extension SampleTabFlowCoordinator {

    @ViewBuilder
    private func rootView() -> some View {
        Text("RootView!!")
    }

    @ViewBuilder
    func baseCoordinatorView() -> some View {
            rootView()
    }
}
