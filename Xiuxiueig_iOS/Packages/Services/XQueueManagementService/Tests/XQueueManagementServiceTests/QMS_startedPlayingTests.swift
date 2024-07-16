// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import XCTest
import XEntities
import XRepositories
@testable import XQueueManagementService

final class QMSStartedPlayingTests: XCTestCase {

    var qmsut: QueueManagementService!
    var storageMock: LectureRepositoryIntefaceMock!

    override func setUp() async throws {

        storageMock = LectureRepositoryIntefaceMock()
    }

    // MARK: - Lesson not in queue

    func testNothinHappenWhenNotInQueue_QMS0080() async throws {

        // GIVEN a QMS started with an queue:
        qmsut = QueueManagementService(storage: storageMock)
        //       prepare storage for inital lectures:
        storageMock.lecturesReturnValue = initialLectures
        //       start the service:
        await qmsut.start()

        // WHEN informing about playing a lecture not in the list
        await qmsut.startedPlayingLecture(id: uuid("6"), in: 10)

        // THEN No lecture is playing
        let lectures = qmsut.getQueue()
        XCTAssertFalse(lectures[0].isPlaying)
        XCTAssertFalse(lectures[1].isPlaying)
    }

    // MARK: - Lesson in queue

    func testPlayingLessonAtTheTopOfTheQueue_QMS0081() async throws {

        // GIVEN a QMS started with an queue:
        qmsut = QueueManagementService(storage: storageMock)
        //       prepare storage for inital lectures:
        storageMock.lecturesReturnValue = initialLectures
        //       start the service:
        await qmsut.start()

        // WHEN informing about playing a lecture at the top of the list
        await qmsut.startedPlayingLecture(id: uuid("1"), in: 10)

        // THEN The lecture at the top will start playing...
        let lectures = qmsut.getQueue()
        XCTAssertTrue(lectures[0].id == uuid("1"))
        XCTAssertTrue(lectures[0].isPlaying)
        XCTAssertTrue(lectures[1].id == uuid("2"))
        XCTAssertFalse(lectures[1].isPlaying)
        // ...and persisted the modified lecture
        let storeInvocations = storageMock.updateLectureReceivedInvocations
        XCTAssert(storeInvocations.contains(lectures[0].dataEntity()))
        // ... but not the rest.
        XCTAssertFalse(storeInvocations.contains(lectures[1].dataEntity()))
    }

    func testPlayingLessonNotAtTheTopOfTheQueue_QMS0081() async throws {

        // GIVEN a QMS started with an queue:
        qmsut = QueueManagementService(storage: storageMock)
        //       prepare storage for inital lectures:
        storageMock.lecturesReturnValue = initialLectures
        //       start the service:
        await qmsut.start()

        // WHEN informing about playing a lecture at is not at the top of the list
        await qmsut.startedPlayingLecture(id: uuid("2"), in: 20)

        // THEN The lecture will be move at the top, start playing,...
        let lectures = qmsut.getQueue()
        XCTAssertTrue(lectures[0].id == uuid("2"))
        XCTAssertTrue(lectures[0].isPlaying)
        XCTAssertTrue(lectures[0].isPlaying)
        XCTAssertTrue(lectures[1].id == uuid("1"))
        XCTAssertFalse(lectures[1].isPlaying)
        // ...and persisted all changed lectures (notice the possition in the queue has changed)
        let storeInvocations = storageMock.updateLectureReceivedInvocations
        XCTAssert(storeInvocations.contains(lectures[0].dataEntity()))
        XCTAssert(storeInvocations.contains(lectures[1].dataEntity()))
    }

    // MARK: - Testing assets

    // swiftlint:disable:next  blanket_disable_command
    // swiftlint:disable line_length

    private var initialLectures: [LectureDataEntity] {
        [
            LectureDataEntity(id: uuid("1"), title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 1),
            LectureDataEntity(id: uuid("2"), title: "title 02", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 2)
        ]
    }
}
