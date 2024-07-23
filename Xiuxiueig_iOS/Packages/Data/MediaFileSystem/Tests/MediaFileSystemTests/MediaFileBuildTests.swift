// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import XCTest
import XToolKit
@testable import MediaFileSystem

final class MediaFileBuildTests: XCTestCase {

    // MARK: - New file

    func testCreateANewFileFromURL_MFS1010() throws {

        // GIVEN a url without hypens
        let url = URL(string: "file:///Users/ana.maria/this%20is%20a%20sample%20file%20name.mp3")!

        // WHEN a media file is created from that
        let mediaFile = MediaFile(url: url, isNew: true)!

        // THEN the Media file should have nil ID and the rest is name
        XCTAssertNil(mediaFile.id)
        XCTAssertEqual(mediaFile.name, "this is a sample file name")
    }

    func testCreateANewFileFromURLWithHyphens_MFS1010() throws {

        // GIVEN a url with hypens
        let url = URL(string: "file:///Users/ana.maria/this%20is%20a-%20sample%20file-%20name.mp3")!

        // WHEN a media file is created from that
        let mediaFile = MediaFile(url: url, isNew: true)!

        // THEN the Media file should have nil ID and the rest is name with the hyphens
        XCTAssertNil(mediaFile.id)
        XCTAssertEqual(mediaFile.name, "this is a- sample file- name")
    }

    func testCreateANewFileFromURLWithHyphensAndSpaces_MFS1010() throws {

        // GIVEN a url with hypens and spaces
        let url = URL(string: "file:///Users/ana.maria/this%20is%20a-%20sample%20file-%20name%20.mp3")!

        // WHEN a media file is created from that
        let mediaFile = MediaFile(url: url, isNew: true)!

        // THEN the Media file should have nil ID and the rest is name with the hyphens and not extra spaces.
        XCTAssertNil(mediaFile.id)
        XCTAssertEqual(mediaFile.name, "this is a- sample file- name")
    }

    // MARK: - Not new file

    func testCreateAFileFromURL_MFS1020() throws {

        // GIVEN a url without hypens
        let uuid = XToolKit.uuidString("1")
        let url = URL(string: "file:///Users/ana.maria/\(uuid)-this%20is%20a%20sample%20file%20name.mp3")!

        // WHEN a media file is created from that
        let mediaFile = MediaFile(url: url)!

        // THEN the Media file should have ID and the rest is name.
        XCTAssertEqual(mediaFile.id, uuid)
        XCTAssertEqual(mediaFile.name, "this is a sample file name")
    }

    func testCreateAFileFromURLWithSpaces_MFS1020() throws {

        // GIVEN a url without hypens
        let uuid = XToolKit.uuidString("1")
        let url = URL(string: "file:///Users/ana.maria/\(uuid)%20-%20this%20is%20a%20sample%20file%20name.mp3")!

        // WHEN a media file is created from that
        let mediaFile = MediaFile(url: url)!

        // THEN the Media file id should be reveded without the extra spaces.
        XCTAssertEqual(mediaFile.id, uuid)
        XCTAssertEqual(mediaFile.name, "this is a sample file name")
    }

    func testCreateAFileFromURLWithSpacesAndHyphens_MFS1020() throws {

        // GIVEN a url without hypens
        let uuid = XToolKit.uuidString("1")
        let url = URL(string: "file:///Users/ana.maria/\(uuid)%20-%20this%20is%20a-%20sample%20file-%20name%20.mp3")!

        // WHEN a media file is created from that
        let mediaFile = MediaFile(url: url)!

        // THEN the Media file id should be reveded without the extra spaces and hyphens.
        XCTAssertEqual(mediaFile.id, uuid)
        XCTAssertEqual(mediaFile.name, "this is a- sample file- name")
    }

    // MARK: - Errors

    func testCreateNonNewFileMediaFailsIfDoesNotContainsIdAndName_MFS1020() throws {

        // GIVEN a url with no separation hyphens
        let uuid = XToolKit.uuidString("1")
        let url = URL(string: "file:///Users/ana.maria/\(uuid).mp3")!

        // WHEN a media file is created from that
        let mediaFile = MediaFile(url: url)

        // THEN it fails
        XCTAssertNil(mediaFile)
    }
}
