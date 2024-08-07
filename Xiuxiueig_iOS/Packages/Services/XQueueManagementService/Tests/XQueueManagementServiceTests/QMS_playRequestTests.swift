// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import XCTest
import XEntities
import XRepositories
@testable import XQueueManagementService

final class QMSPlayRequestTests: XCTestCase {

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

    // MARK: - Lesson in queue

    func testPlayALessonInTheQueue_QMS0120() async throws {

        // GIVEN a QMS started with an queue:
        qmsut = QueueManagementService(storage: storageMock)
        //       prepare storage for inital lectures
        storageMock.lecturesReturnValue = initialDataLectures
        //       start the service:
        await qmsut.start()

        // WHEN requesting to play a lecture existing in the queue
        await qmsut.playLecture(id: uuid("2"))

        // THEN the lecture will be set at the top and persisted.
        let storeInvocations = storageMock.updateLectureReceivedInvocations
        for dataEntity in finalDataLecturesForExistingLecture {
            XCTAssert(storeInvocations.contains(dataEntity))
        }
    }

    // MARK: - Lesson not in queue

    func testPlayALessonNotInTheQueue_QMS0121() async throws {

        // GIVEN a QMS started with an queue:
        qmsut = QueueManagementService(storage: storageMock)
        //       prepare storage for inital lectures
        storageMock.lecturesReturnValue = initialDataLectures
        //       prepare storage for the lecture not in queue
        storageMock.lectureWithIdReturnValue = LectureDataEntity(
            id: uuid("6"),
            title: "title 6",
            mediaTailURL: URLComponents(string: "Inbox/MyFile.mp3")!,
            queuePosition: nil,
            playPosition: nil
        )
        //       start the service:
        await qmsut.start()

        // WHEN requesting to play a lecture none existing in the queue
        await qmsut.playLecture(id: uuid("6"))

        // THEN the lecture will be set at the top and persisted.
        let storeInvocations = storageMock.updateLectureReceivedInvocations
        for dataEntity in finalDataLecturesForNoneExistingLecture {
            XCTAssert(storeInvocations.contains(dataEntity))
        }
    }

    func testPlayALessonNotInTheQueueButNotExisting_QMS0121() async throws {

        // GIVEN a QMS started with an queue:
        qmsut = QueueManagementService(storage: storageMock)
        //       prepare storage for inital lectures
        storageMock.lecturesReturnValue = initialDataLectures
        //       prepare storage for the lecture not in queue
        storageMock.lectureWithIdReturnValue = nil
        //       start the service:
        await qmsut.start()

        // WHEN requesting to play a lecture non existing at all.
        await qmsut.playLecture(id: uuid("6"))

        // THEN nothing will happen.
        let storeInvocations = storageMock.updateLectureReceivedInvocations
        XCTAssert(storeInvocations.isEmpty)
        XCTAssert(qmsut.getQueue().count == 3)
    }

    // MARK: - Testing assets

    // swiftlint:disable:next  blanket_disable_command
    // swiftlint:disable line_length

    private var initialDataLectures: [LectureDataEntity] {
        [
            LectureDataEntity(id: uuid("1"), title: "title 01", mediaTailURL: URLComponents(string: "Inbox/MyFile.mp3")!, queuePosition: 1, playPosition: nil),
            LectureDataEntity(id: uuid("2"), title: "title 02", mediaTailURL: URLComponents(string: "Inbox/MyFile.mp3")!, queuePosition: 2, playPosition: nil),
            LectureDataEntity(id: uuid("3"), title: "title 03", mediaTailURL: URLComponents(string: "Inbox/MyFile.mp3")!, queuePosition: 3, playPosition: nil)
        ]
    }

    private var finalDataLecturesForExistingLecture: [LectureDataEntity] {
        [
            LectureDataEntity(id: uuid("2"), title: "title 02", mediaTailURL: URLComponents(string: "Inbox/MyFile.mp3")!, queuePosition: 1, playPosition: nil),
            LectureDataEntity(id: uuid("1"), title: "title 01", mediaTailURL: URLComponents(string: "Inbox/MyFile.mp3")!, queuePosition: 2, playPosition: nil),
            LectureDataEntity(id: uuid("3"), title: "title 03", mediaTailURL: URLComponents(string: "Inbox/MyFile.mp3")!, queuePosition: 3, playPosition: nil)
        ]
    }

    private var finalDataLecturesForNoneExistingLecture: [LectureDataEntity] {
        [
            LectureDataEntity(id: uuid("6"), title: "title 6", mediaTailURL: URLComponents(string: "Inbox/MyFile.mp3")!, queuePosition: 1, playPosition: nil),
            LectureDataEntity(id: uuid("1"), title: "title 01", mediaTailURL: URLComponents(string: "Inbox/MyFile.mp3")!, queuePosition: 2, playPosition: nil),
            LectureDataEntity(id: uuid("2"), title: "title 02", mediaTailURL: URLComponents(string: "Inbox/MyFile.mp3")!, queuePosition: 3, playPosition: nil),
            LectureDataEntity(id: uuid("3"), title: "title 03", mediaTailURL: URLComponents(string: "Inbox/MyFile.mp3")!, queuePosition: 4, playPosition: nil)
        ]
    }
}
