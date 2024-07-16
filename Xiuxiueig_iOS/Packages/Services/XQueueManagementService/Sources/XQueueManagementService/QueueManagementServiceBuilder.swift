// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XRepositories

public struct QueueManagementServiceBuilder {

    public static func build(storage: LectureRepositoryInteface) -> QueueManagementServiceProtocol {

        QueueManagementService(storage: storage)
    }
}
