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

    func testTitleWithIDWithHyphensAndSpacesReal() throws {
        let fileName = "0252D708-A238-4109-B4A3-8E940E70D63B-My modified new lecture file.mp3"
        let (id, name) = MediaFile.extractUUIDAndName(fileName)!
        XCTAssertEqual(id, "0252D708-A238-4109-B4A3-8E940E70D63B")
        XCTAssertEqual(name, "My modified new lecture file")
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

    // MARK: Name from URL

    func testNameFromURL() throws {
        // swiftlint:disable:next line_length
        let url = URL(string: "file:///Users/josealobato/Library/Developer/XCTestDevices/0F786E2E-DCFB-4FB2-885F-7ED344EC72BB/data/Containers/Data/Application/C57EAABF-5D53-4E25-9821-35AB0B8D3C39/Documents/Managed/0252D708-A238-4109-B4A3-8E940E70D63B-My%20modified%20new%20lecture%20file.mp3")!
        let name = try MediaFile.nameFromURL(url: url)
        XCTAssertEqual(name, "My modified new lecture file")
    }

    // MARK: ID from URL

    func testIdFromURL() throws {
        // swiftlint:disable:next line_length
        let url = URL(string: "file:///Users/josealobato/Library/Developer/XCTestDevices/0F786E2E-DCFB-4FB2-885F-7ED344EC72BB/data/Containers/Data/Application/C57EAABF-5D53-4E25-9821-35AB0B8D3C39/Documents/Managed/0252D708-A238-4109-B4A3-8E940E70D63B-My%20modified%20new%20lecture%20file.mp3")!
        let id = try MediaFile.idFromURL(url: url)
        XCTAssertEqual(id, "0252D708-A238-4109-B4A3-8E940E70D63B")
    }
}
