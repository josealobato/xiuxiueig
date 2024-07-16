// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import XCTest
import XEntities
import XRepositories
@testable import XQueueManagementService

final class QMSDonePlayingTests: XCTestCase {

    struct TimeProviderMock: TimeProvider {

        var now = Date()
    }

    var qmsut: QueueManagementService!
    var storageMock: LectureRepositoryIntefaceMock!
    var timeProviderMock: TimeProviderMock!

    override func setUp() async throws {

        storageMock = LectureRepositoryIntefaceMock()
        timeProviderMock = TimeProviderMock()
    }

    // MARK: - Lesson not in queue

    func testNothinHappenWhenNotInQueue_QMS0110() async throws {

        // GIVEN a QMS started with an queue:
        qmsut = QueueManagementService(storage: storageMock)
        //       prepare storage for inital lectures, where none is playing
        storageMock.lecturesReturnValue = initialDataLectures
        //       start the service:
        await qmsut.start()

        // WHEN informing about a lecture being done not in the list
        await qmsut.donePlayingLecture(id: uuid("6"))

        // THEN No lecture is playing (nothing happen)
        let lectures = qmsut.getQueue()
        XCTAssertEqual(lectures, initialUnchangedLectures)
    }

    // MARK: - Lesson in queue

    func testDoneLectureInQueueIsRemoved_QMS0111() async throws {

        // GIVEN a QMS started with an queue:
        qmsut = QueueManagementService(storage: storageMock)
        //       prepare storage for inital lectures
        storageMock.lecturesReturnValue = initialDataLectures
        //       start the service:
        await qmsut.start()

        // WHEN informing about lecture in queue done
        await qmsut.donePlayingLecture(id: uuid("1"))

        // THEN The lecture is removed...
        let lectures = qmsut.getQueue()
        XCTAssert(lectures.count == 2)
        // and the queue resorted
        XCTAssert(lectures[0].id == uuid("2"))
        XCTAssert(lectures[0].queuePosition == 1)
        XCTAssert(lectures[1].id == uuid("3"))
        XCTAssert(lectures[1].queuePosition == 2)
    }

    func testDoneLectureInQueueMarkedAsDone_QMS0111_QMS0112() async throws {

        // GIVEN a QMS started with an queue:
        qmsut = QueueManagementService(storage: storageMock, timeProvider: timeProviderMock)
        //       prepare storage for inital lectures
        storageMock.lecturesReturnValue = initialDataLectures
        //       start the service:
        await qmsut.start()

        // WHEN informing about lecture in queue done
        await qmsut.donePlayingLecture(id: uuid("1"))

        // THEN The lecture marked as played, not playing, not in queue and saved.
        let savedLecture = LectureDataEntity(id: uuid("1"),
                                             title: "title 01",
                                             mediaURL: URL(string: "https://whatsup.com")!,
                                             queuePosition: nil,
                                             playPosition: nil,
                                             played: [timeProviderMock.now])
        let storeInvocations = storageMock.updateLectureReceivedInvocations
        XCTAssert(storeInvocations.contains(savedLecture))
    }

    func testDoneLectureWithPlayedTimeGetAddedNewTime_QMS0111_QMS0112() async throws {

        // GIVEN a QMS started with an queue:
        qmsut = QueueManagementService(storage: storageMock, timeProvider: timeProviderMock)
        //       prepare storage for inital lectures with played time
        storageMock.lecturesReturnValue = initialDataLecturesWithPlayedTime
        //       start the service:
        await qmsut.start()

        // WHEN informing about lecture in queue done
        await qmsut.donePlayingLecture(id: uuid("1"))

        // THEN The lecture marked as played, not playing, not in queue and saved.
        let savedLecture = LectureDataEntity(id: uuid("1"),
                                             title: "title 01",
                                             mediaURL: URL(string: "https://whatsup.com")!,
                                             queuePosition: nil,
                                             playPosition: nil,
                                             played: [timeProviderMock.now, timeProviderMock.now])
        let storeInvocations = storageMock.updateLectureReceivedInvocations
        XCTAssert(storeInvocations.contains(savedLecture))
    }

    func testDoneLectureInQueueMarkedAsDoneNewQueIsPersisted_QMS0112() async throws {

        // GIVEN a QMS started with an queue:
        qmsut = QueueManagementService(storage: storageMock)
        //       prepare storage for inital lectures
        storageMock.lecturesReturnValue = initialDataLectures
        //       start the service:
        await qmsut.start()

        // WHEN informing about lecture in queue done
        await qmsut.donePlayingLecture(id: uuid("1"))

        // THEN New status of the queue is stored
        let storeInvocations = storageMock.updateLectureReceivedInvocations
        for dataEntity in finalDataLectures {
            XCTAssert(storeInvocations.contains(dataEntity))
        }
    }

    // MARK: - Testing assets

    // swiftlint:disable:next  blanket_disable_command
    // swiftlint:disable line_length

    private var initialDataLectures: [LectureDataEntity] {
        [
            LectureDataEntity(id: uuid("1"), title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 1, playPosition: 10),
            LectureDataEntity(id: uuid("2"), title: "title 02", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 2, playPosition: nil),
            LectureDataEntity(id: uuid("3"), title: "title 03", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 3, playPosition: nil)
        ]
    }

    private var initialDataLecturesWithPlayedTime: [LectureDataEntity] {
        [
            LectureDataEntity(id: uuid("1"), title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 1, playPosition: 10, played: [timeProviderMock.now])
        ]
    }

    private var finalDataLectures: [LectureDataEntity] {
        [
            LectureDataEntity(id: uuid("2"), title: "title 02", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 1, playPosition: nil),
            LectureDataEntity(id: uuid("3"), title: "title 03", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 2, playPosition: nil)
        ]
    }

    private var initialUnchangedLectures: [LectureEntity] {
        [
            LectureEntity(id: uuid("1"), title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 1, playPosition: 10),
            LectureEntity(id: uuid("2"), title: "title 02", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 2),
            LectureEntity(id: uuid("3"), title: "title 03", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 3)
        ]
    }
}
