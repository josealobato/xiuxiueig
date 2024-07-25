// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

import XCoordinator
import MediaFileSystem
import XRepositories

public struct MediaConsistencyServiceBuilder {

    static public func build(fileSystem: MediaFileSystemInteface,
                             repository: LectureRepositoryInteface,
                             coordinator: XCoordinationRequestProtocol? = nil) -> MediaConsistencyServiceInterface {

        MediaConsistencyService(fileSystem: fileSystem,
                                repository: repository,
                                coordinator: coordinator)
    }
}
