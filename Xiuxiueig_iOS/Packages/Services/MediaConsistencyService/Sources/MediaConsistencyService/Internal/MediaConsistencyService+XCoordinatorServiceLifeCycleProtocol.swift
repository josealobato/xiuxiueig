// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XCoordinator

extension MediaConsistencyService: XCoordinatorServiceLifeCycleProtocol {

    func start() {

    }

    func stop() {

    }

    func willEnterForeground() {

        processorSerialQueue.async {

            Task {
                self.logger.debug("MCS Consistency Check Start -> ")

                // Notice that we are ignoring all exeptions here.

                // New files
                try? await self.scanForNewFiles()
                try? await self.checkNewFilesEntitiesConsistency()

                // Managed files
                try? await self.checkManagedFilesConsistency()
                try? await self.checkManagedEntitiesConsistency()

                // Archived files
                try? await self.checkArchivedFilesConsistency()
                try? await self.checkArchivedEntitiesConsistency()
                self.logger.debug("<- MCS Consistency Check End")
            }
        }
    }

}
