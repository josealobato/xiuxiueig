// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

import SwiftUI
import XCoordinator
import XToolKit
import XLectureCollection
import XRepositories

/// The coordinator managing the flow on the collection flow.
final class CollectionFlowCoordinator: XCoordinatorProtocol, ObservableObject {

    // It is a `var` due to protocol conformance (`XCoordinatorProtocol`)
    var logger = XLog.logger(category: "CollectionFlowCoordinator")
    var isStarted: Bool = false

    // Making the link to the parent weak to avoid circular reference.
    weak var parentCoordinator: (any XCoordinator.XCoordinationRequestProtocol)?
    var childCoordinators: [any XCoordinator.XCoordinatorProtocol] = []
    let context: CollectionFlowContext
    var services: [XCoordinatorServiceProtocol] = []

    init(context: CollectionFlowContext) {
        logger.debug("init CollectionFlowCoordinator")
        self.context = context
    }

    deinit {
        logger.debug("deinit CollectionFlowCoordinator")
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
extension CollectionFlowCoordinator {

    @ViewBuilder
    /// The view use this method to request the main view it should hold.
    /// - Returns: the navigation root view of the `CollectionFlowView`
    func baseCoordinatorView() -> some View {

        if let repository = try? context.lectureRepositoryFactory() {
            let adapter = XLectureCollectionAdapter(
                queueManagement: context.queueManagementService,
                lectureRepository: repository
            )
            XLectureCollectionBuilder.build(services: adapter,
                                            coordinator: self)
        } else {
            // Nothice that we do not want to build the view without the
            // repository.
            Text(verbatim: "Ups! Something went wrong")
        }
    }
}
