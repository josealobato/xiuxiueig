// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XRepositories
import MediaConsistencyService
import MediaFileSystem

extension LoggedInFlowCoordinator {

    func initializeServices() {

        services.append(context.queueManagementService)

        if let consistencyService = buildConsistencyService() {
            services.append(consistencyService)
        }
    }

    func buildConsistencyService() -> MediaConsistencyServiceInterface? {

        var consistencyService: MediaConsistencyServiceInterface?
        do {

            // For information on the structe of these types go to
            // `URLConsistencyHandlerBridge` documentation.

            let repository = try LectureRepositoryBuilder.build(
                uRLConsistencyHandler: consistencyHandlerBridge,
                autopersist: false)
            consistencyService = MediaConsistencyServiceBuilder.build(
                fileSystem: MediaFileSystemBuilder.shared,
                repository: repository
            )
            consistencyHandlerBridge.consistencyService = consistencyService

        } catch {
            logger.error("Couldn't build consistency service.")
        }

        return consistencyService
    }
}
