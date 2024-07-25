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
            
            // New files
            self.scanForNewFiles()
            self.checkNewFilesEntitiesConsistency()

            // Managed files
            self.checkManagedFilesConsistency()
            self.checkManagedEntitiesConsistency()

            // Archived files
            self.checkArchivedFilesConsistency()
            self.checkArchivedEntitiesConsistency()
        }
    }

}
