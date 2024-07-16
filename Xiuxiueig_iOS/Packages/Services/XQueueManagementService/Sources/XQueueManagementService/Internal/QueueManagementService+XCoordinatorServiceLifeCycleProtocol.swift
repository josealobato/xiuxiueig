// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XCoordinator

extension QueueManagementService: XCoordinatorServiceLifeCycleProtocol {

    public func start() {

        Task {
            await start()
        }
    }

    func start() async {

        do {
            let dataLectures = try await storage.lectures()
            let dataLecturesOnQueue = dataLectures.filter { $0.queuePosition != nil }
            let lectures = dataLecturesOnQueue.map { $0.entity() }
            let sortedLectures = lectures.sorted { lhLecture, rhLecture in

                // Notice that the possition could be null.
                // But, that won't happen becuase they have already been filtered.
                if let lhPosition = lhLecture.queuePosition,
                    let rhPosition = rhLecture.queuePosition {
                    return lhPosition < rhPosition
                } else { return false }
            }
            queue.append(contentsOf: sortedLectures)
        } catch {
            logger.error("Error getting storage while starting queue management service: \(error)")
        }
    }

    public func stop() { /* Nothing to do */ }
}
