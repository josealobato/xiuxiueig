// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import XCTest
import XEntities
import XRepositories
@testable import XQueueManagementService

final class QMSSkippedTests: XCTestCase {

    var qmsut: QueueManagementService!
    var storageMock: LectureRepositoryIntefaceMock!

    override func setUp() async throws {

        storageMock = LectureRepositoryIntefaceMock()
    }

    // MARK: - Lesson not in queue

    func testNothinHappenWhenNotInQueue_QMS0100() async throws {

        // GIVEN a QMS started with an queue:
        qmsut = QueueManagementService(storage: storageMock)
        //       prepare storage for inital lectures, where none is playing
        storageMock.lecturesReturnValue = initialDataLectures
        //       start the service:
        await qmsut.start()

        // WHEN informing about skiping a lecture not in the list
        await qmsut.skippedLecture(id: uuid("6"))

        // THEN nothing happen
        let lectures = qmsut.getQueue()
        XCTAssertEqual(lectures, initialUnchangedLectures)
    }

    // MARK: - Lesson in queue

    func testSkippingWhenInQueue_QMS0101() async throws {

        // GIVEN a QMS started with an queue:
        qmsut = QueueManagementService(storage: storageMock)
        //       prepare storage for inital lectures
        storageMock.lecturesReturnValue = initialDataLectures
        //       start the service:
        await qmsut.start()

        // WHEN informing about skipped in list
        await qmsut.skippedLecture(id: uuid("1"))

        // THEN The lecture is sent to the end and play possition removed.
        let lectures = qmsut.getQueue()
        XCTAssertEqual(lectures, finalChangedLectures)
        // and the changes stored.
        let storeInvocations = storageMock.updateLectureReceivedInvocations
        XCTAssert(storeInvocations.count == 3)
        for dataLecture in storeInvocations {
            XCTAssert(finalDataLectures.contains(dataLecture))
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

    private var initialUnchangedLectures: [LectureEntity] {
        [
            LectureEntity(id: uuid("1"), title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 1, playPosition: 10),
            LectureEntity(id: uuid("2"), title: "title 02", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 2),
            LectureEntity(id: uuid("3"), title: "title 03", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 3)
        ]
    }

    private var finalChangedLectures: [LectureEntity] {
        [
            LectureEntity(id: uuid("2"), title: "title 02", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 1),
            LectureEntity(id: uuid("3"), title: "title 03", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 2),
            LectureEntity(id: uuid("1"), title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 3, playPosition: nil)
        ]
    }

    private var finalDataLectures: [LectureDataEntity] {
        [
            LectureDataEntity(id: uuid("2"), title: "title 02", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 1, playPosition: nil),
            LectureDataEntity(id: uuid("3"), title: "title 03", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 2, playPosition: nil),
            LectureDataEntity(id: uuid("1"), title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 3, playPosition: nil)
        ]
    }
}
