// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import XCTest
import XEntities
import XRepositories
@testable import XQueueManagementService

final class QMSPausedTests: XCTestCase {

    var qmsut: QueueManagementService!
    var storageMock: LectureRepositoryIntefaceMock!

    override func setUp() async throws {

        storageMock = LectureRepositoryIntefaceMock()
    }

    // MARK: - Lesson not in queue

    func testNothinHappenWhenNotInQueue_QMS0090() async throws {

        // GIVEN a QMS started with an queue:
        qmsut = QueueManagementService(storage: storageMock)
        //       prepare storage for inital lectures, where none is playing
        storageMock.lecturesReturnValue = initialLecturesNonePlaying
        //       start the service:
        await qmsut.start()

        // WHEN informing about pause a lecture not in the list
        await qmsut.pausedLecture(id: uuid("6"), in: 10)

        // THEN No lecture is playing (nothing happen)
        let lectures = qmsut.getQueue()
        XCTAssertFalse(lectures[0].isPlaying)
        XCTAssertFalse(lectures[1].isPlaying)
    }

    // MARK: - Lesson at the top of queue

    func testPausingLessonAtTheTopOfTheQueueWhenPlaying_QMS0091() async throws {

        // GIVEN a QMS started with an queue:
        qmsut = QueueManagementService(storage: storageMock)
        //       prepare storage for inital lectures:
        storageMock.lecturesReturnValue = initialLecturesOnePlaying
        //       start the service:
        await qmsut.start()

        // WHEN informing about playing a lecture at the top of the list
        await qmsut.pausedLecture(id: uuid("1"), in: 60)

        // THEN The lecture at the top will get a new playPossition
        let lectures = qmsut.getQueue()
        XCTAssertTrue(lectures[0].isPlaying)
        XCTAssertTrue(lectures[0].playPosition == 60)
        // ...and persisted the modified lecture
        let storeInvocations = storageMock.updateLectureReceivedInvocations
        XCTAssert(storeInvocations.contains(lectures[0].dataEntity()))
        // ... but not the rest.
        XCTAssertFalse(storeInvocations.contains(lectures[1].dataEntity()))
    }

    func testPausingLessonAtTheTopOfTheQueueWhenNotPlaying_QMS0091() async throws {

        // GIVEN a QMS started with an queue:
        qmsut = QueueManagementService(storage: storageMock)
        //       prepare storage for inital lectures:
        storageMock.lecturesReturnValue = initialLecturesNonePlaying
        //       start the service:
        await qmsut.start()

        // WHEN informing about playing a lecture at the top of the list
        await qmsut.pausedLecture(id: uuid("1"), in: 60)

        // THEN The lecture at the top will get a new playPossition
        let lectures = qmsut.getQueue()
        XCTAssertTrue(lectures[0].isPlaying)
        XCTAssertTrue(lectures[0].playPosition == 60)
        // ...and persisted the modified lecture
        let storeInvocations = storageMock.updateLectureReceivedInvocations
        XCTAssert(storeInvocations.contains(lectures[0].dataEntity()))
        // ... but not the rest.
        XCTAssertFalse(storeInvocations.contains(lectures[1].dataEntity()))
    }

    // MARK: - Lesson NOT at the top of queue

    // **NOTE**: In theory this should not happen. When it does we will have a "playing" lesson
    // not at the top of the queue. It will be solved when infoming stated to play again.

    func testPausingLessonNotAtTheTopOfTheQueueWhenPlaying_QMS0091() async throws {

        // GIVEN a QMS started with an queue:
        qmsut = QueueManagementService(storage: storageMock)
        //       prepare storage for inital lectures:
        storageMock.lecturesReturnValue = initialLecturesOnePlaying
        //       start the service:
        await qmsut.start()

        // WHEN informing about playing a lecture at the top of the list
        await qmsut.pausedLecture(id: uuid("2"), in: 60)

        // THEN The lecture at the top will get a new playPossition
        let lectures = qmsut.getQueue()
        XCTAssertTrue(lectures[1].isPlaying)
        XCTAssertTrue(lectures[1].playPosition == 60)
        // ...and persisted the modified lecture
        let storeInvocations = storageMock.updateLectureReceivedInvocations
        XCTAssert(storeInvocations.contains(lectures[1].dataEntity()))
        // ... but not the rest.
        XCTAssertFalse(storeInvocations.contains(lectures[0].dataEntity()))
    }

    func testPausingLessonNotAtTheTopOfTheQueueWhenNotPlaying_QMS0091() async throws {

        // GIVEN a QMS started with an queue:
        qmsut = QueueManagementService(storage: storageMock)
        //       prepare storage for inital lectures:
        storageMock.lecturesReturnValue = initialLecturesNonePlaying
        //       start the service:
        await qmsut.start()

        // WHEN informing about playing a lecture at the top of the list
        await qmsut.pausedLecture(id: uuid("2"), in: 60)

        // THEN The lecture at the top will get a new playPossition
        let lectures = qmsut.getQueue()
        XCTAssertTrue(lectures[1].isPlaying)
        XCTAssertTrue(lectures[1].playPosition == 60)
        // ...and persisted the modified lecture
        let storeInvocations = storageMock.updateLectureReceivedInvocations
        XCTAssert(storeInvocations.contains(lectures[1].dataEntity()))
        // ... but not the rest.
        XCTAssertFalse(storeInvocations.contains(lectures[0].dataEntity()))
    }

    // MARK: - Testing assets

    // swiftlint:disable:next  blanket_disable_command
    // swiftlint:disable line_length

    private var initialLecturesNonePlaying: [LectureDataEntity] {
        [
            LectureDataEntity(id: uuid("1"), title: "title 01", mediaTailURL: URLComponents(string: "/Inbox/myFile.mp3")!, queuePosition: 1, playPosition: nil),
            LectureDataEntity(id: uuid("2"), title: "title 02", mediaTailURL: URLComponents(string: "/Inbox/myFile.mp3")!, queuePosition: 2, playPosition: nil)
        ]
    }

    private var initialLecturesOnePlaying: [LectureDataEntity] {
        [
            LectureDataEntity(id: uuid("1"), title: "title 01", mediaTailURL: URLComponents(string: "/Inbox/myFile.mp3")!, queuePosition: 1, playPosition: 10),
            LectureDataEntity(id: uuid("2"), title: "title 02", mediaTailURL: URLComponents(string: "/Inbox/myFile.mp3")!, queuePosition: 2, playPosition: nil)
        ]
    }
}
