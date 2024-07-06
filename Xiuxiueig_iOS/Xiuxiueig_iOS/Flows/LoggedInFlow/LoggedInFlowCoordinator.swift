// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI
import XCoordinator
import XToolKit

/// The `LoggedInFlowCoordinator` is the main coordinator when the user
/// is logged in.
///
/// It holds the tabview with a navigation flow for every tab.
final class LoggedInFlowCoordinator: XCoordinatorProtocol, ObservableObject {

    let logger = XLog.logger(category: "LoggedInFlowCoordinator")
    var isStarted: Bool = false
    let context: LoggedInFlowContext

    var parentCoordinator: (any XCoordinator.XCoordinationRequestProtocol)?

    var childCoordinators: [any XCoordinator.XCoordinatorProtocol] = []

    init(context: LoggedInFlowContext) {
        logger.debug("init LoggedInFlowCoordinator")
        self.context = context
        initializeTabs()
    }

    deinit {
        logger.debug("init LoggedInFlowCoordinator")
    }

    func start() {
        logger.debug("start LoggedInFlowCoordinator")
        isStarted = true
    }

    func stop() {
        logger.debug("stop LoggedInFlowCoordinator")
        isStarted = false
    }

    var tabs: [XCoordinatorProtocol] = []
    func initializeTabs() {
        let tabOneCoordinator = SampleTabFlowCoordinator()
        tabOneCoordinator.parentCoordinator = self
        tabs.append(tabOneCoordinator)
        playerTabCoordinator = tabOneCoordinator

        let collectionFlowContext = CollectionFlowContext(userName: context.userName)
        let tabTwoCoordinator = CollectionFlowCoordinator(context: collectionFlowContext)
        tabTwoCoordinator.parentCoordinator = self
        tabs.append(tabOneCoordinator)
        collectitonTabCoordinator = tabTwoCoordinator

        let settingsFlowContext = SettingsFlowContext(userName: context.userName)
        let tabThreeCoordinator = SettingsFlowCoordinator(context: settingsFlowContext)
        tabThreeCoordinator.parentCoordinator = self
        tabs.append(tabThreeCoordinator)
        settingsTabCoordinator = tabThreeCoordinator
    }

    var playerTabCoordinator: SampleTabFlowCoordinator?
    var collectitonTabCoordinator: CollectionFlowCoordinator?
    var settingsTabCoordinator: SettingsFlowCoordinator?
}

///
/// This extension provides the view associated with the Coordinator
///
extension LoggedInFlowCoordinator {

    @ViewBuilder
    func baseCoordinatorView() -> some View {
        VStack {
            TabView {
                // NOTE: I tried to do with with a loop over the coordinator
                //       collection but it added a ton of complexity that is not
                //       needed yet on the application. Approach to be reviewed in
                //       the future.

                // Tab 1
                if let playerTabCoordinator = playerTabCoordinator {
                    SampleTabFlowView(coordinator: playerTabCoordinator)
                }

                // Tab 2
                if let collectitonTabCoordinator = collectitonTabCoordinator {
                    CollectionFlowView(coordinator: collectitonTabCoordinator)
                }

                // Tab 2
                if let settingsTabCoordinator = settingsTabCoordinator {
                    SettingsFlowView(coordinator: settingsTabCoordinator)
                }
            }
        }
    }
}

// MARK: - CoordinatorRequestProtocol

///
/// Conformance of the `XCoordinatorRequestProtocol` of the `LoggedInFlowCoordinator`
///
extension LoggedInFlowCoordinator: XCoordinationRequestProtocol {

    func coordinate(from feature: XCoordinator.XCoordinated, request: XCoordinator.XCoordinationRequest) {

        guard isStarted else { return }

        switch feature {
        default:
            logger.debug(
                """
                LoggedInFlowCoordinator: Nothing to coordinate for feature \(feature.rawValue)
                and request \(request). Deferring to parent.
                """
            )
            parentCoordinator?.coordinate(from: feature, request: request)
        }
    }
}
