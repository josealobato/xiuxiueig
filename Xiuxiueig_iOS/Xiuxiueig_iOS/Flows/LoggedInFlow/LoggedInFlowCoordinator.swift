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

    // Making the link to the parent weak to avoid circular reference.
    weak var parentCoordinator: (any XCoordinator.XCoordinationRequestProtocol)?

    var childCoordinators: [any XCoordinator.XCoordinatorProtocol] = []

    init(context: LoggedInFlowContext) {
        logger.debug("init LoggedInFlowCoordinator")
        self.context = context
    }

    deinit {
        logger.debug("deinit LoggedInFlowCoordinator")
    }

    func start() {
        logger.debug("start LoggedInFlowCoordinator")
        isStarted = true
    }

    func stop() {
        logger.debug("stop LoggedInFlowCoordinator")
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

    func buildPlayerTabCoordinatorIfNeeded() -> SampleTabFlowCoordinator {
        if let coordinator = getChild(ofType: SampleTabFlowCoordinator.self) as? SampleTabFlowCoordinator {
            return coordinator
        } else {
            let coordinator = SampleTabFlowCoordinator()
            coordinator.parentCoordinator = self
            addChild(coordinator)
            return coordinator
        }
    }

    func buildCollectionTabCoordinatorIfNeeded() -> CollectionFlowCoordinator {
        if let coordinator = getChild(ofType: CollectionFlowCoordinator.self) as? CollectionFlowCoordinator {
            return coordinator
        } else {
            let context = CollectionFlowContext(userName: context.userName)
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
                SampleTabFlowView(coordinator: buildPlayerTabCoordinatorIfNeeded())

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
