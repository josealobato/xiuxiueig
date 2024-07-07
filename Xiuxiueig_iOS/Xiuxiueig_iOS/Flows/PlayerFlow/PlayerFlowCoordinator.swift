// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

import SwiftUI
import XCoordinator
import XToolKit
import XPlayer

/// The coordinator managing the flow on the collection flow.
final class PlayerFlowCoordinator: XCoordinatorProtocol, ObservableObject {

    let logger = XLog.logger(category: "PlayerFlowCoordinator")
    var isStarted: Bool = false

    // Making the link to the parent weak to avoid circular reference.
    weak var parentCoordinator: (any XCoordinator.XCoordinationRequestProtocol)?
    var childCoordinators: [any XCoordinator.XCoordinatorProtocol] = []
    let context: PlayerFlowContext

    init(context: PlayerFlowContext) {
        logger.debug("init PlayerFlowCoordinator")
        self.context = context
    }

    deinit {
        logger.debug("deinit PlayerFlowCoordinator")
    }

    func start() {
        logger.debug("start PlayerFlowCoordinator")
        isStarted = true
    }

    func stop() {
        logger.debug("stop PlayerFlowCoordinator")
        isStarted = false
        childCoordinators.forEach { $0.parentCoordinator = nil }
        removeAllChilds()
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
extension PlayerFlowCoordinator {

    @ViewBuilder
    /// The view use this method to request the main view it should hold.
    /// - Returns: the navigation root view of the `PlayerFlowView`
    func baseCoordinatorView() -> some View {
        let adapter = XPlayerAdapter()
        XPlayerBuilder.build(services: adapter)
    }
}
