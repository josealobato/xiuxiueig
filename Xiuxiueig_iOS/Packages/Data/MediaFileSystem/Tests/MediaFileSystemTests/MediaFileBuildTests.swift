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

    func testCreatingANewFileFromRealURL() throws {

        // GIVEN a url with hypens and spaces
        // swiftlint:disable:next line_length
        let url = URL(string: "file:///Users/josealobato/Library/Developer/XCTestDevices/0F786E2E-DCFB-4FB2-885F-7ED344EC72BB/data/Containers/Data/Application/C57EAABF-5D53-4E25-9821-35AB0B8D3C39/Documents/Managed/0252D708-A238-4109-B4A3-8E940E70D63B-My%20modified%20new%20lecture%20file.mp3")!

        // WHEN a media file is created from that
        let mediaFile = MediaFile(url: url, isNew: true)!

        // THEN the Media file should have nil ID and the rest is name with the hyphens and not extra spaces.
        XCTAssertNil(mediaFile.id)
        XCTAssertEqual(mediaFile.name, "My modified new lecture file")
        XCTAssertEqual(mediaFile.fileName, "My modified new lecture file.mp3")
        XCTAssertEqual(mediaFile.managedFileName, "My modified new lecture file.mp3")
        XCTAssertEqual(mediaFile.url.absoluteString, url.absoluteString)
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

    func testCreatingAManagedFileFromRealURL() throws {

        // GIVEN a url with hypens and spaces
        // swiftlint:disable:next line_length
        let url = URL(string: "file:///Users/josealobato/Library/Developer/XCTestDevices/0F786E2E-DCFB-4FB2-885F-7ED344EC72BB/data/Containers/Data/Application/C57EAABF-5D53-4E25-9821-35AB0B8D3C39/Documents/Managed/0252D708-A238-4109-B4A3-8E940E70D63B-My%20modified%20new%20lecture%20file.mp3")!

        // WHEN a media file is created from that
        let mediaFile = MediaFile(url: url, isNew: false)!

        // THEN the Media file should have nil ID and the rest is name with the hyphens and not extra spaces.
        XCTAssertEqual(mediaFile.id, "0252D708-A238-4109-B4A3-8E940E70D63B")
        XCTAssertEqual(mediaFile.name, "My modified new lecture file")
        XCTAssertEqual(mediaFile.fileName, "0252D708-A238-4109-B4A3-8E940E70D63B-My modified new lecture file.mp3")
        XCTAssertEqual(
            mediaFile.managedFileName,
            "0252D708-A238-4109-B4A3-8E940E70D63B-My modified new lecture file.mp3"
        )
        XCTAssertEqual(mediaFile.url.absoluteString, url.absoluteString)
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
