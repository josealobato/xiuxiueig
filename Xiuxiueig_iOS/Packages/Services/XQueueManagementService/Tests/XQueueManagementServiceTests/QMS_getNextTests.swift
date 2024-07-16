// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import XCTest
import XEntities
import XRepositories
@testable import XQueueManagementService

final class QMSGetNextTests: XCTestCase {

    var qmsut: QueueManagementService!
    var storageMock: LectureRepositoryIntefaceMock!

    override func setUp() async throws {

        storageMock = LectureRepositoryIntefaceMock()
    }

    func testGetNextWithNoValuesLecture_QMS0060() async throws {

        // GIVEN a QMS started with no lectures
        qmsut = QueueManagementService(storage: storageMock)
        //       prepare storage:
        storageMock.lecturesReturnValue = []
        //       start the service:
        await qmsut.start()

        // WHEN requesting the first lecture
        let lecture = qmsut.getNext()

        // THEN the lecture at the top will be requested.
        XCTAssertNil(lecture)
    }

    func testGetNextWithSomeValuesLecture_QMS0060() async throws {

        // GIVEN a QMS started with some lectures
        qmsut = QueueManagementService(storage: storageMock)
        //       prepare storage:
        storageMock.lecturesReturnValue = lecturesWithTwoOnList
        //       start the service:
        await qmsut.start()

        // WHEN requesting the first lecture
        let lecture = qmsut.getNext()

        // THEN the lecture at the top will be requested.
        XCTAssert(lecture!.id == uuid("3"))
    }

    // MARK: - Testing assets

    // swiftlint:disable:next  blanket_disable_command
    // swiftlint:disable line_length

    private var lecturesWithTwoOnList: [LectureDataEntity] {
        [
            LectureDataEntity(id: uuid("1"), title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: nil),
            LectureDataEntity(id: uuid("2"), title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 3),
            LectureDataEntity(id: uuid("3"), title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 1),
            LectureDataEntity(id: uuid("4"), title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 2),
            LectureDataEntity(id: uuid("5"), title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: nil)
        ]
    }
}
