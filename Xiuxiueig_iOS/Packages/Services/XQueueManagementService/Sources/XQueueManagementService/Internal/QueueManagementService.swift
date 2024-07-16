// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XEntities
import XCoordinator
import XRepositories
import XToolKit

public class QueueManagementService {

    let logger = XLog.logger(category: "QueueManagementService")

    let storage: LectureRepositoryInteface
    var timeProvider: TimeProvider

    var queue: [LectureEntity] = []

    public weak var coordinator: XCoordinationRequestProtocol?

    convenience public init(storage: LectureRepositoryInteface) {
        self.init(storage: storage, timeProvider: LocalTimeProvider())
    }

    init(storage: LectureRepositoryInteface, timeProvider: TimeProvider) {
        /// Dev Note: The designated initializer is of package internal use so that
        /// we can instantiate the time provider for proper testing.
        self.storage = storage
        self.timeProvider = timeProvider
    }
}
