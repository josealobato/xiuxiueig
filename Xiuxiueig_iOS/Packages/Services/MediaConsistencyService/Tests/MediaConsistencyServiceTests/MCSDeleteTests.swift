// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import XCTest
import XRepositories
import XToolKit

@testable import MediaConsistencyService
// By desing ONLY the MediaFileSystem can create MediaFiles. I use testable here
// to be able to create them for testing purposes.
@testable import MediaFileSystem

final class MCSDeleteTests: XCTestCase {

    var mcs: MediaConsistencyServiceInterface!
    var fileSystemMock: MediaFileSystemIntefaceMock!
    var repoMock: LectureRepositoryIntefaceMock!

    override func setUp() {
        super.setUp()
        fileSystemMock = MediaFileSystemIntefaceMock()
        repoMock = LectureRepositoryIntefaceMock()
        mcs = MediaConsistencyServiceBuilder.build(fileSystem: fileSystemMock, repository: repoMock)

        // set up the mocks for other actions that the MCS does not related to managed files
        fileSystemMock.unmanagedFilesReturnValue = []
        fileSystemMock.archivedFilesReturnValue = []
        repoMock.lecturesReturnValue = []

    }

    override func tearDown() {
        mcs = nil
        super.tearDown()
    }

    func testDeleteAnEnetityWithNoAssociatedFile_MCS0910() {
        // GIVEN there not file associated
        fileSystemMock.unmanagedFilesReturnValue = []
        fileSystemMock.managedFilesReturnValue = []
        // to a given entity
        let anEntity = aNewEntity

        // WHEN deleting the entity
        // THEN it will throw
        XCTAssertThrowsError(try mcs.delete(entity: anEntity))
    }

    func testDeleteANewEntity_MCS0920() throws {
        // GIVEN there is a new file associated
        fileSystemMock.unmanagedFilesReturnValue = [aNewFile]
        fileSystemMock.managedFilesReturnValue = []
        // to a given entity
        let anEntity = aNewEntity

        // WHEN deleting the entity
        try mcs.delete(entity: anEntity)

        // THEN it will delete the file.
        XCTAssert(fileSystemMock.deleteFileFileCalled)
        let deletedFile = fileSystemMock.deleteFileFileReceivedFile!
        XCTAssert(deletedFile.url == aNewFile.url)
    }

    func testDeleteAManagedEntity_MCS0930() throws {
        // GIVEN there is a managed file associated
        fileSystemMock.unmanagedFilesReturnValue = []
        fileSystemMock.managedFilesReturnValue = [aManagedFile]
        // to a given entity
        let anEntity = aManagedEntity

        // WHEN deleting the entity
        try mcs.delete(entity: anEntity)

        // THEN it will delete the file.
        XCTAssert(fileSystemMock.deleteFileFileCalled)
        let deletedFile = fileSystemMock.deleteFileFileReceivedFile!
        XCTAssert(deletedFile.url == aManagedFile.url)
    }

    func testDeleteAnArchivedEntity_MCS0940() throws {
        // GIVEN there is a managed file associated
        fileSystemMock.unmanagedFilesReturnValue = []
        fileSystemMock.managedFilesReturnValue = [aManagedFile]
        // to a given entity
        let anEntity = aArchivedEntity

        // WHEN deleting the entity
        try mcs.delete(entity: anEntity)

        // THEN it will delete the file.
        XCTAssert(fileSystemMock.deleteFileFileCalled)
        let deletedFile = fileSystemMock.deleteFileFileReceivedFile!
        XCTAssert(deletedFile.url == aManagedFile.url)
    }

    // MARK: - Test Data

    // New

    var aNewFile: MediaFile {
        let url = URL(string: "file:///Users/ana.maria/this%20is%20a%20sample%20file%20name.mp3")!
        return MediaFile(url: url, isNew: true)!
    }

    var aNewEntity: LectureDataEntity {
        let url = URL(
            string: "file:///Users/ana.maria/this%20is%20a%20sample%20file%20name.mp3"
        )!
        var entity = LectureDataEntity(id: uuid("0"),
                                       title: "this is a sample file name",
                                       mediaURL: url)
        entity.state = .new
        return entity
    }

    // Managed

    var aManagedFile: MediaFile {
        let uuid = uuidString("0")
        let url = URL(string: "file:///Users/ana.maria/\(uuid)-this%20is%20a%20sample%20file%20name.mp3")!
        return MediaFile(url: url, isNew: false)!
    }

    var aManagedEntity: LectureDataEntity {
        let uuidString = uuidString("0")
        let url = URL(string: "file:///Users/ana.maria/\(uuidString)-this%20is%20a%20sample%20file%20name.mp3")!
        var entity = LectureDataEntity(id: uuid("0"), title: "this is a sample file name", mediaURL: url)
        entity.state = .managed
        return entity
    }

    // Archived

    var aArchivedEntity: LectureDataEntity {
        let uuidString = uuidString("0")
        let url = URL(string: "file:///Users/ana.maria/\(uuidString)-this%20is%20a%20sample%20file%20name.mp3")!
        var entity = LectureDataEntity(id: uuid("0"), title: "this is a sample file name", mediaURL: url)
        entity.state = .archived
        return entity
    }
}
