// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI
import XCoordinator
import XToolKit

/// The `AppFlowCoordinator` is the root coordinator of the application.
/// It will be the last coordinator on attending an event.
/// It is also the entry point of the application
final class AppFlowCoordinator: XCoordinatorProtocol, ObservableObject {

    let logger = XLog.logger(category: "AppFlowCoordinator")
    var isStarted: Bool = false

    var parentCoordinator: (any XCoordinator.XCoordinationRequestProtocol)?

    var childCoordinators: [any XCoordinator.XCoordinatorProtocol] = []

    init() {
        logger.debug("init AppFlowCoordinator")
        initializeTabs()
    }

    deinit {
        logger.debug("init AppFlowCoordinator")
    }

    func start() {
        logger.debug("start AppFlowCoordinator")
        isStarted = true
    }

    func stop() {
        logger.debug("stop AppFlowCoordinator")
        isStarted = false
    }

    var tabs: [XCoordinatorProtocol] = []
    func initializeTabs() {
        let tabOneCoordinator = SampleTabFlowCoordinator()
        tabOneCoordinator.parentCoordinator = self
        tabs.append(tabOneCoordinator)
        playerTabCoordinator = tabOneCoordinator

        let tabTwoCoordinator = CollectionFlowCoordinator()
        tabTwoCoordinator.parentCoordinator = self
        tabs.append(tabOneCoordinator)
        collectitonTabCoordinator = tabTwoCoordinator
    }

    var playerTabCoordinator: SampleTabFlowCoordinator?
    var collectitonTabCoordinator: CollectionFlowCoordinator?
}

///
/// This extension provides the view associated with the Coordinator
///
extension AppFlowCoordinator {

    @ViewBuilder
    func baseCoordinatorView() -> some View {
        VStack {
            if !isStarted {
                Text("starting")
            } else {
                TabView {
                    // NOTE: I tried to do with with a loop over the coordinator
                    //       collection but it added a ton of complexity that is not
                    //       needed yet on the application. Approach to be reviewed in
                    //       the future.

                    // Tab 1
                    if let playerTabCoordinator = playerTabCoordinator {
                        SampleTabFlowView(coordinator: playerTabCoordinator)
                    }

                    // Tab 1
                    if let collectitonTabCoordinator = collectitonTabCoordinator {
                        CollectionFlowView(coordinator: collectitonTabCoordinator)
                    }
                }
            }
        }
    }
}

// MARK: - CoordinatorRequestProtocol

///
/// Conformance of the `XCoordinatorRequestProtocol` of the `AppFlowCoordinator`
///
extension AppFlowCoordinator: XCoordinationRequestProtocol {

    func coordinate(from feature: XCoordinator.XCoordinated, request: XCoordinator.XCoordinationRequest) {

        switch feature {
        default:
            logger.debug(
                "Coordinator: Nothing to coordinate for feature \(feature.rawValue) and request \(request)"
            )
        }
    }
}
