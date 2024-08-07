// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import XCTest
import XEntities
import XRepositories
@testable import XQueueManagementService

final class QMSChangeOrderIncreasingTests: XCTestCase {

    var qmsut: QueueManagementService!
    var storageMock: LectureRepositoryIntefaceMock!

    override func setUp() async throws {

        storageMock = LectureRepositoryIntefaceMock()
    }

    func testChangeOnderIncreasing_QMS0040() async throws {

        // GIVEN a QMS started with some sorted lectures
        qmsut = QueueManagementService(storage: storageMock)
        //       prepare storage:
        storageMock.lecturesReturnValue = lecturesInOrder
        //       start the service:
        await qmsut.start()

        // WHEN requesting to sort a lecture to forward position
        await qmsut.changeOrder(id: uuid("2"), from: 2, to: 4)

        // THEN the new possitions should match the request
        let lectures = qmsut.getQueue()
        let resultingIds = lectures.map { $0.id }
        XCTAssertEqual(resultingIds, [uuid("1"),
                                      uuid("2"),
                                      uuid("4"),
                                      uuid("5"),
                                      uuid("3"),
                                      uuid("6")])
    }

    func testChangeOnderIncreasingQueuePosition_QMS0040() async throws {

        // GIVEN a QMS started with some sorted lectures
        qmsut = QueueManagementService(storage: storageMock)
        //       prepare storage:
        storageMock.lecturesReturnValue = lecturesInOrder
        //       start the service:
        await qmsut.start()

        // WHEN requesting to sort a lecture to forward position
        await qmsut.changeOrder(id: uuid("2"), from: 2, to: 4)

        // THEN the queue position are adjusted to be the same
        let lectures = qmsut.getQueue()
        let resultingIds = lectures.map { $0.queuePosition! }
        XCTAssertEqual(resultingIds, [1, 2, 3, 4, 5, 6])
    }

    func testChangeOnderIncreasingStore_QMS0040() async throws {

        // GIVEN a QMS started with some sorted lectures
        qmsut = QueueManagementService(storage: storageMock)
        //       prepare storage:
        storageMock.lecturesReturnValue = lecturesInOrder
        //       start the service:
        await qmsut.start()

        // WHEN requesting to sort a lecture to forward position
        await qmsut.changeOrder(id: uuid("2"), from: 2, to: 4)

        // THEN the new order is saved in the store
        let storeInvocations = storageMock.updateLectureReceivedInvocations
        XCTAssert(storeInvocations.count == 6)
        for dataLecture in storeInvocations {
            XCTAssert(lecturesUpdatedStored.contains(dataLecture))
        }
    }

    // swiftlint:disable:next  blanket_disable_command
    // swiftlint:disable line_length

    private var lecturesInOrder: [LectureDataEntity] {
        [
            LectureDataEntity(id: uuid("1"), title: "title 01", mediaTailURL: URLComponents(string: "Inbox/myFile.mp3")!, queuePosition: 1),
            LectureDataEntity(id: uuid("2"), title: "title 02", mediaTailURL: URLComponents(string: "Inbox/myFile.mp3")!, queuePosition: 2),
            LectureDataEntity(id: uuid("3"), title: "title 03", mediaTailURL: URLComponents(string: "Inbox/myFile.mp3")!, queuePosition: 3),
            LectureDataEntity(id: uuid("4"), title: "title 04", mediaTailURL: URLComponents(string: "Inbox/myFile.mp3")!, queuePosition: 4),
            LectureDataEntity(id: uuid("5"), title: "title 05", mediaTailURL: URLComponents(string: "Inbox/myFile.mp3")!, queuePosition: 5),
            LectureDataEntity(id: uuid("6"), title: "title 06", mediaTailURL: URLComponents(string: "Inbox/myFile.mp3")!, queuePosition: 6)
        ]
    }

    private var lecturesUpdatedStored: [LectureDataEntity] {
        [
            LectureDataEntity(id: uuid("1"), title: "title 01", mediaTailURL: URLComponents(string: "Inbox/myFile.mp3")!, queuePosition: 1),
            LectureDataEntity(id: uuid("2"), title: "title 02", mediaTailURL: URLComponents(string: "Inbox/myFile.mp3")!, queuePosition: 2),
            LectureDataEntity(id: uuid("4"), title: "title 04", mediaTailURL: URLComponents(string: "Inbox/myFile.mp3")!, queuePosition: 3),
            LectureDataEntity(id: uuid("5"), title: "title 05", mediaTailURL: URLComponents(string: "Inbox/myFile.mp3")!, queuePosition: 4),
            LectureDataEntity(id: uuid("3"), title: "title 03", mediaTailURL: URLComponents(string: "Inbox/myFile.mp3")!, queuePosition: 5),
            LectureDataEntity(id: uuid("6"), title: "title 06", mediaTailURL: URLComponents(string: "Inbox/myFile.mp3")!, queuePosition: 6)
        ]
    }
}
