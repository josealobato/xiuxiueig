// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI
import XCoordinator
import XQueueManagementService
import XRepositories

extension AppFlowCoordinator {

    @ViewBuilder
    func loggedInView(context: LoggedInFlowContext) -> some View {
        LoggedInFlowView(coordinator: buildLoggedInCoordinator(context: context))
    }

    private func buildLoggedInCoordinator(context: LoggedInFlowContext) -> LoggedInFlowCoordinator {
        if let coordinator = getChild(ofType: LoggedInFlowCoordinator.self) as? LoggedInFlowCoordinator {
            return coordinator
        } else {
            let coordinator = LoggedInFlowCoordinator(context: context)
            coordinator.parentCoordinator = self
            addChild(coordinator)
            return coordinator
        }
    }

    /// Tries to build the context for the flow.
    /// Notice that the flow can not be build without context.
    func loggedInFlowContextBuilder() -> LoggedInFlowContext? {
        guard let userName = userName,
              let storage = try? LectureRepositoryBuilder.build()
        else { return nil }

        let queueManagementService = QueueManagementServiceBuilder.build(storage: storage)
        return LoggedInFlowContext(userName: userName,
                                   queueManagementService: queueManagementService)
    }
}
