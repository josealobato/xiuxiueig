// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI
import XCoordinator
import XRepositories

extension AppFlowCoordinator {

    func addSeedData() {

        Task {

            /// The data added here is just for demo purposes.
            /// The final implementation will be done by copying the files included in the project
            /// to act as new files in the system (unmanaged).

            let lectureRepo = try? LectureRepositoryBuilder.build()

            let tutorialCategory = CategoryDataEntity(id: UUID(), title: "Tutorial", imageURL: nil)

            let lecture1 = LectureDataEntity(
                id: UUID(),
                title: "Introduction to Xiuxiueig part 1",
                category: tutorialCategory,
                mediaTailURL: URLComponents(),
                imageURL: nil,
                queuePosition: nil,
                playPosition: nil,
                played: [],
                state: .managed
            )

            try? await lectureRepo?.add(lecture: lecture1)

            let lecture2 = LectureDataEntity(
                id: UUID(),
                title: "Introduction to Xiuxiueig part 2",
                category: tutorialCategory,
                mediaTailURL: URLComponents(),
                imageURL: nil,
                queuePosition: nil,
                playPosition: nil,
                played: [],
                state: .managed
            )

            try? await lectureRepo?.add(lecture: lecture2)

            try? await lectureRepo?.persist()
        }
    }
}
