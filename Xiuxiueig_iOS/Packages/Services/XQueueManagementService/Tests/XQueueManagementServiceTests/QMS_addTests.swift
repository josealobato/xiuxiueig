// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import XCTest
import XEntities
import XRepositories
@testable import XQueueManagementService

final class QMSAddTests: XCTestCase {

    var qmsut: QueueManagementService!
    var storageMock: LectureRepositoryIntefaceMock!

    override func setUp() async throws {

        storageMock = LectureRepositoryIntefaceMock()
    }

    // MARK: - Add on top

    func testAddOnTopOfEmptyQueue_QMS0020() async throws {

        // GIVEN a QMS started with an empty queue
        qmsut = QueueManagementService(storage: storageMock)
        //       prepare storage for all lecture:
        storageMock.lecturesReturnValue = []
        //       prepare storage for the lecture to add:
        storageMock.lectureWithIdReturnValue = addedLecture
        //       start the service:
        await qmsut.start()

        // WHEN requesting to add alecture on top
        await qmsut.addToQueueOnTop(id: uuid("9"))

        // THEN that will be the single lecture
        let lectures = qmsut.getQueue()
        let resultingIds = lectures.map { $0.id }
        XCTAssertEqual(resultingIds, [uuid("9")])
        XCTAssertEqual(lectures[0].queuePosition!, 1)
    }

    func testAddOnTopOfQueueWithLectures_QMS0020() async throws {

        // GIVEN a QMS started with an empty queue
        qmsut = QueueManagementService(storage: storageMock)
        //       prepare storage for all lecture:
        storageMock.lecturesReturnValue = initialLectures
        //       prepare storage for the lecture to add:
        storageMock.lectureWithIdReturnValue = addedLecture
        //       start the service:
        await qmsut.start()

        // WHEN requesting to add alecture on top
        await qmsut.addToQueueOnTop(id: uuid("9"))

        // THEN it will be added at possition 1 with queue position 1
        let lectures = qmsut.getQueue()
        let resultingIds = lectures.map { $0.id }
        XCTAssertEqual(resultingIds, [uuid("9"), uuid("1"), uuid("2")])
        let resultingPositions = lectures.map { $0.queuePosition }
        XCTAssertEqual(resultingPositions, [1, 2, 3])
    }

    func testAddOnTopOfQueueWithLecturesSavesToStore_QMS0020() async throws {

        // GIVEN a QMS started with an empty queue
        qmsut = QueueManagementService(storage: storageMock)
        //       prepare storage for all lecture:
        storageMock.lecturesReturnValue = initialLectures
        //       prepare storage for the lecture to add:
        storageMock.lectureWithIdReturnValue = addedLecture
        //       start the service:
        await qmsut.start()

        // WHEN requesting to add alecture on top
        await qmsut.addToQueueOnTop(id: uuid("9"))

        // THEN the result will be updated in the store
        let storeInvocations = storageMock.updateLectureReceivedInvocations
        XCTAssert(storeInvocations.count == 3)
        for dataLecture in storeInvocations {
            XCTAssert(storageUpdatedLecturesWhenAddOnTop.contains(dataLecture))
        }
    }

    // MARK: - Add at bottom

    func testAddAtBottomOfEmptyQueue_QMS0030() async throws {

        // GIVEN a QMS started with an empty queue
        qmsut = QueueManagementService(storage: storageMock)
        //       prepare storage for all lecture:
        storageMock.lecturesReturnValue = []
        //       prepare storage for the lecture to add:
        storageMock.lectureWithIdReturnValue = addedLecture
        //       start the service:
        await qmsut.start()

        // WHEN requesting to add alecture at bottom
        await qmsut.addToQueueAtBottom(id: uuid("9"))

        // THEN that will be the single lecture
        let lectures = qmsut.getQueue()
        let resultingIds = lectures.map { $0.id }
        XCTAssertEqual(resultingIds, [uuid("9")])
        XCTAssertEqual(lectures[0].queuePosition!, 1)
    }

    func testAddAtBottomOfQueueWithLectures_QMS0030() async throws {

        // GIVEN a QMS started with an empty queue
        qmsut = QueueManagementService(storage: storageMock)
        //       prepare storage for all lecture:
        storageMock.lecturesReturnValue = initialLectures
        //       prepare storage for the lecture to add:
        storageMock.lectureWithIdReturnValue = addedLecture
        //       start the service:
        await qmsut.start()

        // WHEN requesting to add alecture at bottom
        await qmsut.addToQueueAtBottom(id: uuid("9"))

        // THEN it will be added at the end
        let lectures = qmsut.getQueue()
        let resultingIds = lectures.map { $0.id }
        XCTAssertEqual(resultingIds, [uuid("1"), uuid("2"), uuid("9")])
        let resultingPositions = lectures.map { $0.queuePosition }
        XCTAssertEqual(resultingPositions, [1, 2, 3])
    }

    func testAddAtBottomOfQueueWithLecturesSavesToStore_QMS0030() async throws {

        // GIVEN a QMS started with an empty queue
        qmsut = QueueManagementService(storage: storageMock)
        //       prepare storage for all lecture:
        storageMock.lecturesReturnValue = initialLectures
        //       prepare storage for the lecture to add:
        storageMock.lectureWithIdReturnValue = addedLecture
        //       start the service:
        await qmsut.start()

        // WHEN requesting to add a lecture at bottom
        await qmsut.addToQueueAtBottom(id: uuid("9"))

        // THEN the result will be updated in the store
        let storeInvocations = storageMock.updateLectureReceivedInvocations
        XCTAssert(storeInvocations.count == 3)
        for dataLecture in storeInvocations {
            XCTAssert(storageUpdatedLecturesWhenAddAtBottom.contains(dataLecture))
        }
    }

    // MARK: - Add existing Object

    func testAddExistingLectureOnTop_QMS0020() async throws {

        // GIVEN a QMS started with an empty queue
        qmsut = QueueManagementService(storage: storageMock)
        //       prepare storage for all lecture:
        storageMock.lecturesReturnValue = initialLectures
        //       prepare storage for the lecture to add:
        storageMock.lectureWithIdReturnValue = initialLectures[0]
        //       start the service:
        await qmsut.start()

        // WHEN requesting to add an existing lecture on top
        await qmsut.addToQueueOnTop(id: uuid("1"))

        // THEN the queue estays the same
        let lectures = qmsut.getQueue()
        let resultingIds = lectures.map { $0.id }
        XCTAssertEqual(resultingIds, [uuid("1"), uuid("2")])
    }

    func testAddExistingLectureAtBottom_QMS0030() async throws {

        // GIVEN a QMS started with an empty queue
        qmsut = QueueManagementService(storage: storageMock)
        //       prepare storage for all lecture:
        storageMock.lecturesReturnValue = initialLectures
        //       prepare storage for the lecture to add:
        storageMock.lectureWithIdReturnValue = initialLectures[0]
        //       start the service:
        await qmsut.start()

        // WHEN requesting to add an existing lecture at bottom.
        await qmsut.addToQueueAtBottom(id: uuid("1"))

        // THEN the queue estays the same
        let lectures = qmsut.getQueue()
        let resultingIds = lectures.map { $0.id }
        XCTAssertEqual(resultingIds, [uuid("1"), uuid("2")])
    }

    // MARK: - Testing assets

    // swiftlint:disable:next  blanket_disable_command
    // swiftlint:disable line_length

    private var initialLectures: [LectureDataEntity] {
        [
            LectureDataEntity(id: uuid("1"), title: "title 01", mediaTailURL: URLComponents(string: "Inbox/MyFile.mp3")!, queuePosition: 1),
            LectureDataEntity(id: uuid("2"), title: "title 02", mediaTailURL: URLComponents(string: "Inbox/MyFile.mp3")!, queuePosition: 2)
        ]
    }

    private var storageUpdatedLecturesWhenAddOnTop: [LectureDataEntity] { // Order not important since it is for update
        [
            LectureDataEntity(id: uuid("9"), title: "title 09", mediaTailURL: URLComponents(string: "Inbox/MyFile.mp3")!, queuePosition: 1),
            LectureDataEntity(id: uuid("1"), title: "title 01", mediaTailURL: URLComponents(string: "Inbox/MyFile.mp3")!, queuePosition: 2),
            LectureDataEntity(id: uuid("2"), title: "title 02", mediaTailURL: URLComponents(string: "Inbox/MyFile.mp3")!, queuePosition: 3)
        ]
    }

    private var storageUpdatedLecturesWhenAddAtBottom: [LectureDataEntity] { // Order not important since it is for update
        [
            LectureDataEntity(id: uuid("9"), title: "title 09", mediaTailURL: URLComponents(string: "Inbox/MyFile.mp3")!, queuePosition: 3),
            LectureDataEntity(id: uuid("1"), title: "title 01", mediaTailURL: URLComponents(string: "Inbox/MyFile.mp3")!, queuePosition: 1),
            LectureDataEntity(id: uuid("2"), title: "title 02", mediaTailURL: URLComponents(string: "Inbox/MyFile.mp3")!, queuePosition: 2)
        ]
    }

    private var addedLecture = LectureDataEntity(id: uuid("9"), title: "title 09", mediaTailURL: URLComponents(string: "Inbox/MyFile.mp3")!, queuePosition: nil)
}
