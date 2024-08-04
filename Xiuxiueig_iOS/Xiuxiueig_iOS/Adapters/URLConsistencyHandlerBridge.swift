// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XRepositories
import MediaConsistencyService
import XToolKit

/// Errors being thrown by the `URLConsistencyHandlerBridge`
enum DataLectureURLConsistencyHandlerError: Error {
    case noConsistencyServiceAvailable
}

/// A bridge between the Media Consistency Service (MCS) and the
/// Lecture Repository (RL)
///
/// The repository needs someone to keep the file system (files name and URL)
/// consistent when the user modifies and entity. For that it offers an
/// interface (`LectureURLConsistencyHandler`) that gets the dataEntity and
/// retuns it updated after the file system is updated, so keeping it all 
/// consistent.
///
/// But the object in charge of keeping this consistency is the MCS, and
/// this one already use a repository for bach processing of the file system.
/// As a result we might end up with a memory retention loop:
///
///  ┌─────────────────────┐           ┌────────────────────────┐
///  │  LectureRepository  │◀─────────▶│ MediaConsistecyService │
///  └─────────────────────┘           └────────────────────────┘
///
/// To solve this issue we introduce a bridge that holds a weak like to the
/// MCS as follows
///
///  ┌─────────────────────┐           ┌────────────────────────┐
///  │  LectureRepository  │◀──────────│ MediaConsistecyService │
///  └─────────────────────┘           └────────────────────────┘
///             │                                   ▲
///             │                                   │
///             │                                 weak
///             │ ┌──────────────────────────────┐  │
///             └▶│ URLConsistencyHandlerBridge  │──┘
///               └──────────────────────────────┘
///
/// Notice that there will be only one instace of the MCS and bridge hold
/// in the coordinator (LoggedIn). Whom we provide a factory to create
/// new Lecture Repository guaranteen the same mechanism.
///
class URLConsistencyHandlerBridge: LectureURLConsistencyHandler {

    var logger = XLog.logger(category: "URLConsistencyHandler")

    weak var consistencyService: MediaConsistencyServiceInterface?

    func update(entity: LectureDataEntity) throws -> LectureDataEntity {

        guard let consistencyService = self.consistencyService else {
            logger.error("No data lecture URL Consistency handler available")
            throw DataLectureURLConsistencyHandlerError.noConsistencyServiceAvailable
        }
        return try consistencyService.update(entity: entity)
    }
}
