// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import XCTest
import XToolKit
@testable import MediaFileSystem

final class NameMatchingTests: XCTestCase {

    func testTitleWithoutID() throws {
        let fileName = "This is a regular file text.mp3"
        let (id, name) = MediaFile.extractUUIDAndName(fileName)!
        XCTAssertNil(id)
        XCTAssertEqual(name, "This is a regular file text")
    }

    func testTitleWithIDWithoutHyphens() throws {
        let uuid = uuidString("0")
        let fileName = "\(uuid) This is a regular file text.mp3"
        let (id, name) = MediaFile.extractUUIDAndName(fileName)!
        XCTAssertEqual(id, uuid)
        XCTAssertEqual(name, "This is a regular file text")
    }

    func testTitleWithIDWithHyphens() throws {
        let uuid = uuidString("0")
        let fileName = "\(uuid)-This is a regular file text.mp3"
        let (id, name) = MediaFile.extractUUIDAndName(fileName)!
        XCTAssertEqual(id, uuid)
        XCTAssertEqual(name, "This is a regular file text")
    }

    func testTitleWithIDWithHyphensLeft() throws {
        let uuid = uuidString("0")
        let fileName = "\(uuid)- This is a regular file text.mp3"
        let (id, name) = MediaFile.extractUUIDAndName(fileName)!
        XCTAssertEqual(id, uuid)
        XCTAssertEqual(name, "This is a regular file text")
    }

    func testTitleWithIDWithHyphensRight() throws {
        let uuid = uuidString("0")
        let fileName = "\(uuid) -This is a regular file text.mp3"
        let (id, name) = MediaFile.extractUUIDAndName(fileName)!
        XCTAssertEqual(id, uuid)
        XCTAssertEqual(name, "This is a regular file text")
    }

    func testTitleWithIDWithHyphensAndSpaces() throws {
        let uuid = uuidString("0")
        let fileName = "\(uuid) - This is a regular file text.mp3"
        let (id, name) = MediaFile.extractUUIDAndName(fileName)!
        XCTAssertEqual(id, uuid)
        XCTAssertEqual(name, "This is a regular file text")
    }

    // MARK: Fails

    func testTitleWithIDWithoutName() throws {
        let uuid = uuidString("0")
        let fileName = "\(uuid)"
        let value = MediaFile.extractUUIDAndName(fileName)
        XCTAssertNil(value)
    }

    func testTitleWithInvalidID() throws {
        let fileName = "12345678-1234 - This is a regular file text.mp3"
        let (id, name) = MediaFile.extractUUIDAndName(fileName)!
        XCTAssertNil(id)
        XCTAssertEqual(name, "12345678-1234 - This is a regular file text")
    }
}
