// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)
import XCTest
import XRepositories
import XToolKit

@testable import MediaConsistencyService
// By desing ONLY the MediaFileSystem can create MediaFiles. I use testable here
// to be able to create them for testing purposes.
@testable import MediaFileSystem

final class MCSUpdateConsistencyTests: XCTestCase {

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

    func testUpdateAMissingFileWithThrow_MCS0710() throws {
        // GIVEN there is no managed file
        fileSystemMock.fileFromReturnValue = nil

        // WHEN update that entity
        // THEN it will throw
        XCTAssertThrowsError(try mcs.update(entity: aNewModifiedEntity))
    }

    // MARK: - New File No Changes in State

    func testUpdateANewFileWithoutChangeInStateWillUpdateFile_MCS0720() throws {
        // GIVEN there is new file
        fileSystemMock.fileFromReturnValue = aNewFile
        // and a new entity
        let newEntity = aNewModifiedEntity

        // The update will update the title and uuid.
        fileSystemMock.updateFileFileClosure = { updatedFile in
            XCTAssertEqual(updatedFile.name, newEntity.title)
            XCTAssertEqual(updatedFile.id, newEntity.id.uuidString)
            return updatedFile
        }

        // WHEN update the associated entity with changes in title and UUID
        _ = try mcs.update(entity: newEntity)

        // THEN it match expectation (see above)
        XCTAssert(fileSystemMock.updateFileFileCalled)
    }

    func testUpdateANewFileWithoutChangeInStateWillReturnUpdatedEntity_MCS0730() throws {
        // GIVEN there is new file
        fileSystemMock.fileFromReturnValue = aNewFile
        // and a new entity
        let newEntity = aNewModifiedEntity

        // The file system will update the file and return an updated file.
        // (The URL will change)
        fileSystemMock.updateFileFileClosure = { _ in
            return self.aNewModifiedFile
        }

        // WHEN update the associated entity with changes in title and UUID
        let updatedEntity = try mcs.update(entity: newEntity)

        // THEN it match expectation (see above)
        XCTAssertEqual(updatedEntity.mediaURL.absoluteString, "file://a/new/url.mp3")
    }

    // MARK: - Managed File No Changes in State (To Manage)

    // NOTE to update a managed file we manage it.
    func testUpdateAManageFileWithoutChangeInStateWillManageFile_MCS0720() throws {
        // GIVEN there is manage file
        fileSystemMock.fileFromReturnValue = aManagedFile
        let modifiedManagedEntity = aModifiedManagedEntity

        // expectation
        fileSystemMock.manageFileFileClosure = { managedFile in
            XCTAssertEqual(managedFile.name, modifiedManagedEntity.title)
            XCTAssertEqual(managedFile.id, modifiedManagedEntity.id.uuidString)
            return managedFile
        }

        // WHEN update the associated entity with changes in title and UUID
        _ = try mcs.update(entity: modifiedManagedEntity)

        // THEN it match expectation (see above)
        XCTAssert(fileSystemMock.manageFileFileCalled)
    }

    // MARK: - Managed File No Changes in State (To Archive)

    // NOTE to update (archive) a managed file we archive it.
    func testUpdateAManageFileWithoutChangeInStateWillArchivedFile_MCS0720() throws {
        // GIVEN there is manage file
        fileSystemMock.fileFromReturnValue = aManagedFile
        // And an archived entity
        let modifiedArchivedEntity = aModifiedArchivedEntity

        // On archive a managed entity it will update its values
        fileSystemMock.archiveFileFileClosure = { managedFile in
            XCTAssertEqual(managedFile.name, modifiedArchivedEntity.title)
            XCTAssertEqual(managedFile.id, modifiedArchivedEntity.id.uuidString)
            return managedFile
        }

        // WHEN update the associated entity with changes in title and UUID
        _ = try mcs.update(entity: modifiedArchivedEntity)

        // THEN it match expectation (see above)
        XCTAssert(fileSystemMock.archiveFileFileCalled)
    }

    // MARK: - Changes in State

    func testUpdateAManagedFileWithNewEntity_MCS0710() throws {
        // GIVEN there is managed file
        fileSystemMock.fileFromReturnValue = aManagedFile

        // WHEN update with entity in state new
        // THEN it will throw
        XCTAssertThrowsError(try mcs.update(entity: aNewModifiedEntity))
    }

    func testManagingANewFile_MCS0750() throws {
        // GIVEN a new file
        fileSystemMock.fileFromReturnValue = aNewFile

        // The file is managed (call) and the data is updated from the entity
        let managedEntity = aManagedEntity
        fileSystemMock.manageFileFileClosure = { fileToManage in
            XCTAssertEqual(fileToManage.id, managedEntity.id.uuidString)
            XCTAssertEqual(fileToManage.name, managedEntity.title)
            // and an updated file is returned.
            return self.aManagedModifedFile
        }

        // WHEN update to manage it
        let updatedEntity = try mcs.update(entity: managedEntity)

        // THEN (see expectation above)
        // AND the resulting entity is managed with URL Updated.
        XCTAssertEqual(updatedEntity.mediaURL.absoluteString, "file://a/new/url.mp3")
    }

    func testArchiveANewFile_MCS0760() throws {
        // GIVEN a new file
        fileSystemMock.fileFromReturnValue = aNewFile
        // and an archive entity for the request
        let archivedEntity = aArchivedEntity

        // Expectation: The file is archived(call) and the data is updated from the entity
        fileSystemMock.archiveFileFileClosure = { fileToArchive in
            XCTAssertEqual(fileToArchive.id, archivedEntity.id.uuidString)
            XCTAssertEqual(fileToArchive.name, archivedEntity.title)
            // and an updated file is returned.
            return self.aManagedModifedFile
        }

        // WHEN update to archive it
        let updatedEntity = try mcs.update(entity: archivedEntity)

        // THEN (see expectation above)
        // AND the resulting entity is managed with URL Updated.
        XCTAssertEqual(updatedEntity.mediaURL.absoluteString, "file://a/new/url.mp3")
    }

    func testArchivieAManagedFile_MCS0770() throws {
        // GIVEN a managed file
        fileSystemMock.fileFromReturnValue = aManagedFile
        // and an archive entity for the request
        let archivedEntity = aArchivedEntity

        // Expectation: The file is managed and the data is updated from the entity
        fileSystemMock.archiveFileFileClosure = { fileToArchive in
            XCTAssertEqual(fileToArchive.id, archivedEntity.id.uuidString)
            XCTAssertEqual(fileToArchive.name, archivedEntity.title)
            // and an updated file is returned.
            return self.aManagedModifedFile
        }

        // WHEN update to archive it it
        let updatedEntity = try mcs.update(entity: archivedEntity)

        // THEN (see expectation above)
        // AND the resulting entity is managed with URL Updated.
        XCTAssertEqual(updatedEntity.mediaURL.absoluteString, "file://a/new/url.mp3")
    }

    // MARK: - Support Methods

    // MARK: - Test Data

    // New

    var aNewFile: MediaFile {
        let url = URL(string: "file:///Users/ana.maria/this%20is%20a%20sample%20file%20name.mp3")!
        return MediaFile(url: url, isNew: true)!
    }

    var aNewModifiedFile: MediaFile {
        // the url has change with respect to "aNewFile"
        let url = URL(string: "file://a/new/url.mp3")!
        return MediaFile(url: url, isNew: true)!
    }

    var aNewModifiedEntity: LectureDataEntity {
        let uuidString = uuidString("0")
        let url = URL(string: "file:///Users/ana.maria/\(uuidString)-this%20is%20a%20sample%20file%20name.mp3")!
        var entity = LectureDataEntity(id: uuid("0"), title: "this is a sample file name", mediaURL: url)
        entity.state = .new
        // Modify because we change the title.
        entity.title = "Updated Title"
        return entity
    }

    // Managed

    var aManagedFile: MediaFile {
        let uuidString = uuidString("0")
        let url = URL(string: "file:///Users/ana.maria/\(uuidString)-this%20is%20a%20sample%20file%20name.mp3")!
        return MediaFile(url: url, isNew: false)!
    }

    var aManagedModifedFile: MediaFile {
        // The URL is different and (without UUID).
        let url = URL(string: "file://a/new/url.mp3")!
        return MediaFile(url: url, isNew: false)!
    }

    var aManagedEntity: LectureDataEntity {
        let uuid = uuidString("0")
        let url = URL(string: "file:///Users/ana.maria/\(uuid)-this%20is%20a%20sample%20file%20name.mp3")!
        var entity = LectureDataEntity(id: UUID(), title: "this is a sample file name", mediaURL: url)
        entity.state = .managed
        entity.title = "Updated Title"
        return entity
    }

    var aModifiedManagedEntity: LectureDataEntity {
        let uuid = uuidString("0")
        let url = URL(string: "file:///Users/ana.maria/\(uuid)-this%20is%20a%20sample%20file%20name.mp3")!
        var entity = LectureDataEntity(id: UUID(), title: "this is a sample file name", mediaURL: url)
        entity.state = .managed
        entity.title = "A Modified Title"
        return entity
    }

    // Archived

    var aArchivedEntity: LectureDataEntity {
        let uuid = uuidString("0")
        let url = URL(string: "file:///Users/ana.maria/\(uuid)-this%20is%20a%20sample%20file%20name.mp3")!
        var entity = LectureDataEntity(id: UUID(), title: "this is a sample file name", mediaURL: url)
        entity.state = .archived
        entity.title = "Updated Title"
        return entity
    }

    var aModifiedArchivedEntity: LectureDataEntity {
        let url = URL(string: "file://a/new/url.mp3")!
        var entity = LectureDataEntity(id: uuid("0"), title: "this is a sample file name", mediaURL: url)
        entity.state = .archived
        entity.title = "The new Modified title"
        return entity
    }
}
