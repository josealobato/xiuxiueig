import XCTest
@testable import XEntities

final class LectureURLTests: XCTestCase {

    let documentBaseURL: URL = URL(string: "file:///user/document/")!

    override func setUp() {
        super.setUp()

        LectureEntity.baseURL = { self.documentBaseURL }
    }

    func testExample() throws {
        // GIVEN a lecture with a given url component section
        var components = URLComponents()
        components.path = "Inbox/herewego.mp3"
        let lecture = LectureEntity(id: UUID(),
                                    title: "A test Lecture",
                                    mediaTailURL: components)
        // WHEN getting the whole URL
        let fullURL = lecture.mediaURL

        // THEN We should get the base and the tail
        XCTAssertEqual(
            fullURL.absoluteString,
            "file:///user/document/Inbox/herewego.mp3"
        )
    }
}
