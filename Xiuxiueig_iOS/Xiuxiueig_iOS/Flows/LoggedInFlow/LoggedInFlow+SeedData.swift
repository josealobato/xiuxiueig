// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XRepositories

/// In this extension we takes care of the default data that should be in the database
/// when the user logs in.
extension LoggedInFlowCoordinator {

    func addSeedDataIfNeeded() {

        addDefaultGoalIfNeeded()
    }

    /// Check if the default Goal is in place and add it if missing.
    private func addDefaultGoalIfNeeded() {

        Task {
            do {
                let title = String(localized: "Long-term learning", comment: "Title of the default goal")

                let goalRepository = try GoalRepositoryBuilder.build()
                let defaultGoal = try await goalRepository.goals().first { $0.title == title }
                if defaultGoal == nil {
                    let newDefatultGoal = GoalDataEntity(id: UUID(),
                                                         title: title,
                                                         dueDate: nil)
                    try await goalRepository.add(goal: newDefatultGoal)
                }

            } catch {
                logger.error("Unable to add default goal: \(error)")
            }
        }
    }
}
