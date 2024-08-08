// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

import SwiftUI
import XCoordinator
import XToolKit
import XQueueCollection

/// The coordinator managing the flow on the collection flow.
final class QueueFlowCoordinator: XCoordinatorProtocol, ObservableObject {

    // It is a `var` due to protocol conformance (`XCoordinatorProtocol`)
    var logger = XLog.logger(category: "QueueFlowCoordinator")
    var isStarted: Bool = false

    // Making the link to the parent weak to avoid circular reference.
    weak var parentCoordinator: (any XCoordinationRequestProtocol)?
    var childCoordinators: [any XCoordinatorProtocol] = []
    let context: QueueFlowContext
    var services: [XCoordinatorServiceProtocol] = []

    init(context: QueueFlowContext) {
        logger.debug("init QueueFlowCoordinator")
        self.context = context
    }

    deinit {
        logger.debug("deinit QueueFlowCoordinator")
    }

    // Navigation
    @Published var path = NavigationPath()
    @Published var sheet: Feature?
    @Published var screenCover: Feature?

    func push(_ page: Feature) {
        DispatchQueue.main.async {
            self.path.append(page)
        }
    }
    private func present(sheet: Feature) { self.sheet = sheet }
    private func present(screenCover: Feature) { self.screenCover = screenCover }
    private func dismissSheet() { sheet = nil; screenCover = nil}
    private func dismissScreenCover() { screenCover = nil }
    private func backToRoot() { path.removeLast(path.count) }
}

///
/// This extension serves the view associated with the Coordinator
///
extension QueueFlowCoordinator {

    @ViewBuilder
    /// The view use this method to request the main view it should hold.
    /// - Returns: the navigation root view of the `QueueFlowView`
    func baseCoordinatorView() -> some View {

        let adapter = XQueueCollectionAdapter(
            queueManager: context.queueManagementService
        )
        XQueueCollectionBuilder.build(services: adapter,
                                      coordinator: self)
    }
}
