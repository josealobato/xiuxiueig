// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

import SwiftUI
import XCoordinator
import XToolKit
import XSettings

/// The coordinator managing the flow on the collection flow.
final class SettingsFlowCoordinator: XCoordinatorProtocol, ObservableObject {

    // It is a `var` due to protocol conformance (`XCoordinatorProtocol`)
    var logger = XLog.logger(category: "SettingsFlowCoordinator")
    var isStarted: Bool = false

    // Making the link to the parent weak to avoid circular reference.
    weak var parentCoordinator: (any XCoordinator.XCoordinationRequestProtocol)?
    var childCoordinators: [any XCoordinator.XCoordinatorProtocol] = []
    let context: SettingsFlowContext
    var services: [XCoordinatorServiceProtocol] = []

    init(context: SettingsFlowContext) {
        logger.debug("init SettingsFlowCoordinator")
        self.context = context
    }

    deinit {
        logger.debug("deinit SettingsFlowCoordinator")
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
extension SettingsFlowCoordinator {

    @ViewBuilder
    /// The view use this method to request the main view it should hold.
    /// - Returns: the navigation root view of the `SettingsFlowView`
    func baseCoordinatorView() -> some View {
        let adapter = XSettingsAdapter()
        XSettingsBuilder.build(services: adapter,
                               coordinator: self,
                               userName: context.userName)
    }
}
