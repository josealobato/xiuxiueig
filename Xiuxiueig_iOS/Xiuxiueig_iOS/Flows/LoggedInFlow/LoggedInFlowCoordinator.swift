// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI
import XCoordinator
import XToolKit
import XQueueManagementService
import XRepositories

/// The `LoggedInFlowCoordinator` is the main coordinator when the user
/// is logged in.
///
/// It holds the tabview with a navigation flow for every tab.
final class LoggedInFlowCoordinator: XCoordinatorProtocol, ObservableObject {

    // It is a `var` due to protocol conformance (`XCoordinatorProtocol`)
    var logger = XLog.logger(category: "LoggedInFlowCoordinator")
    var isStarted: Bool = false
    let context: LoggedInFlowContext
    var services: [XCoordinatorServiceProtocol] = []

    // Making the link to the parent weak to avoid circular reference.
    weak var parentCoordinator: (any XCoordinator.XCoordinationRequestProtocol)?

    var childCoordinators: [any XCoordinator.XCoordinatorProtocol] = []

    init(context: LoggedInFlowContext) {
        logger.debug("init LoggedInFlowCoordinator")
        self.context = context

        initializeServices()
    }

    func initializeServices() {
        services.append(context.queueManagementService)
    }

    deinit {
        logger.debug("deinit LoggedInFlowCoordinator")
    }

    func stop() {
        logger.debug("stop LoggedInFlowCoordinator")
        stopServices()
        isStarted = false
        childCoordinators.forEach {
            // NOTE: Usually stop of a coordinator will be performed by its view, but these ones are
            // located in tabs and their `onDisapear` is called on every tab switch. For this
            // reason we stop them when the parent (this one) is stopped.
            $0.stop()
            $0.parentCoordinator = nil
        }
        removeAllChilds()
    }

    func buildPlayerTabCoordinatorIfNeeded() -> PlayerFlowCoordinator {
        if let coordinator = getChild(ofType: PlayerFlowCoordinator.self) as? PlayerFlowCoordinator {
            return coordinator
        } else {
            let context = PlayerFlowContext(userName: context.userName,
                                            queueManagementService: context.queueManagementService)
            let coordinator = PlayerFlowCoordinator(context: context)
            coordinator.parentCoordinator = self
            addChild(coordinator)
            return coordinator
        }
    }

    func buildCollectionTabCoordinatorIfNeeded() -> CollectionFlowCoordinator {
        if let coordinator = getChild(ofType: CollectionFlowCoordinator.self) as? CollectionFlowCoordinator {
            return coordinator
        } else {
            let context = CollectionFlowContext(userName: context.userName,
                                                queueManagementService: context.queueManagementService)
            let coordinator = CollectionFlowCoordinator(context: context)
            coordinator.parentCoordinator = self
            addChild(coordinator)
            return coordinator
        }
    }

    func buildSettingsTabCoordinatorIfNeeded() -> SettingsFlowCoordinator {
        if let coordinator = getChild(ofType: SettingsFlowCoordinator.self) as? SettingsFlowCoordinator {
            return coordinator
        } else {
            let context = SettingsFlowContext(userName: context.userName)
            let coordinator = SettingsFlowCoordinator(context: context)
            coordinator.parentCoordinator = self
            addChild(coordinator)
            return coordinator
        }
    }
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
                PlayerFlowView(coordinator: buildPlayerTabCoordinatorIfNeeded())

                // Tab 2
                CollectionFlowView(coordinator: buildCollectionTabCoordinatorIfNeeded())

                // Tab 3
                SettingsFlowView(coordinator: buildSettingsTabCoordinatorIfNeeded())
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
