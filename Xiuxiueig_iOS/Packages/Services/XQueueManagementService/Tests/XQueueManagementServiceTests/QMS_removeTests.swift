// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import XCTest
import XEntities
import XRepositories
@testable import XQueueManagementService

final class QMSRemoveTests: XCTestCase {

    var qmsut: QueueManagementService!
    var storageMock: LectureRepositoryIntefaceMock!

    override func setUp() async throws {

        storageMock = LectureRepositoryIntefaceMock()
    }

    // MARK: - Add on top

    func testRemoveFormEmptyQueue_QMS0070() async throws {

        // GIVEN a QMS started with an empty queue
        qmsut = QueueManagementService(storage: storageMock)
        //       prepare storage for all lecture:
        storageMock.lecturesReturnValue = []
        //       start the service:
        await qmsut.start()

        // WHEN requesting to remove a lecture
        await qmsut.removeFromQueue(id: uuid("1"))

        // THEN the queue will stay the same
        let lectures = qmsut.getQueue()
        XCTAssert(lectures.count == 0)
    }

    func testRemoveANonQueuedObject_QMS0070() async throws {

        // GIVEN a QMS started with an empty queue
        qmsut = QueueManagementService(storage: storageMock)
        //       prepare storage for all lecture:
        storageMock.lecturesReturnValue = initialLectures
        //       start the service:
        await qmsut.start()

        // WHEN requesting to remove a lecture
        await qmsut.removeFromQueue(id: uuid("6"))

        // THEN the queue will stay the same
        let lectures = qmsut.getQueue()
        let resultingIds = lectures.map { $0.id }
        XCTAssertEqual(resultingIds, [uuid("1"),
                                      uuid("2"),
                                      uuid("3")])
        let resultingPositions = lectures.map { $0.queuePosition }
        XCTAssertEqual(resultingPositions, [1, 2, 3])
    }

    func testRemoveAQueuedObject_QMS0070() async throws {

        // GIVEN a QMS started with an empty queue
        qmsut = QueueManagementService(storage: storageMock)
        //       prepare storage for all lecture:
        storageMock.lecturesReturnValue = initialLectures
        //       start the service:
        await qmsut.start()

        // WHEN requesting to remove a lecture
        await qmsut.removeFromQueue(id: uuid("2"))

        // THEN it will remove the requested object
        let lectures = qmsut.getQueue()
        let resultingIds = lectures.map { $0.id }
        XCTAssertEqual(resultingIds, [uuid("1"),
                                      uuid("3")])
        let resultingPositions = lectures.map { $0.queuePosition }
        XCTAssertEqual(resultingPositions, [1, 2])
    }

    func testRemoveAQueuedObjectSavesTheQueueAndTheObjectToStore_QMS0070() async throws {

        // GIVEN a QMS started with an empty queue
        qmsut = QueueManagementService(storage: storageMock)
        //       prepare storage for all lecture:
        storageMock.lecturesReturnValue = initialLectures
        //       start the service:
        await qmsut.start()

        // WHEN requesting to remove a lecture
        await qmsut.removeFromQueue(id: uuid("2"))

        // THEN the resulting queue is saved on store
        let storeInvocations = storageMock.updateLectureReceivedInvocations
        XCTAssert(storeInvocations.count == 3)
        for dataLecture in storeInvocations {
            XCTAssert(storageUpdatedLecturesWhenRemove.contains(dataLecture))
        }
    }

    // MARK: - Testing assets

    // swiftlint:disable:next  blanket_disable_command
    // swiftlint:disable line_length

    private var initialLectures: [LectureDataEntity] {
        [
            LectureDataEntity(id: uuid("1"), title: "title 01", mediaTailURL: URLComponents(string: "Inbox/MyFile.mp3")!, queuePosition: 1),
            LectureDataEntity(id: uuid("2"), title: "title 02", mediaTailURL: URLComponents(string: "Inbox/MyFile.mp3")!, queuePosition: 2),
            LectureDataEntity(id: uuid("3"), title: "title 03", mediaTailURL: URLComponents(string: "Inbox/MyFile.mp3")!, queuePosition: 3)
        ]
    }

    private var storageUpdatedLecturesWhenRemove: [LectureDataEntity] {
        [
            LectureDataEntity(id: uuid("1"), title: "title 01", mediaTailURL: URLComponents(string: "Inbox/MyFile.mp3")!, queuePosition: 1),
            LectureDataEntity(id: uuid("3"), title: "title 03", mediaTailURL: URLComponents(string: "Inbox/MyFile.mp3")!, queuePosition: 2),
            LectureDataEntity(id: uuid("2"), title: "title 02", mediaTailURL: URLComponents(string: "Inbox/MyFile.mp3")!, queuePosition: nil)
        ]
    }
}
