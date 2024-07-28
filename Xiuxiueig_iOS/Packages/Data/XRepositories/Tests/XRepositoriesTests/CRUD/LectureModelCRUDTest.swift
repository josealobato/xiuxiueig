// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftData
import XCTest

@testable import XRepositories

final class LectureModelCRUDTest: CRUDModelBaseTestCase<LectureModel> {

    // MARK: - Build facilities.

    let createModel = {
        LectureModel(externalId: UUID(), title: "My great lessson")
    }
    let createModels = {
        [
            LectureModel(externalId: UUID(), title: "My great lessson"),
            LectureModel(externalId: UUID(), title: "My other great lessson")
        ]
    }
    let modelPredicate = #Predicate<LectureModel> { $0.title == "My great lessson" }

    // MARK: - Crud - Create

    func testInsertModel() async throws {
        try await _testInsertModel { createModel() }
    }

    func testInsertModels() async throws {
        try await _testInsertModels { createModels() }
    }

    // MARK: - cRud - Retrive

    func testFetchWithoutDescriptor() async throws {
        try await _testFetchWithoutDescriptor { createModel() }
    }

    func testFetchWithDescriptor() async throws {
        try await _testFetchWithDescriptor(
            { createModel() },
            descriptor: FetchDescriptor(predicate: modelPredicate)
        )
    }

    // MARK: - crUd - Update

    // Not clear yet how to test this.

    // MARK: - cruD - Delete

    func testDeleteWithoutPredicate() async throws {
        try await _testDeleteWithoutPredicate { createModel() }
    }

    func testDeleteWithPredicate() async throws {
        try await _testDeleteWithPredicate(
            input: { createModel() },
            predicate: modelPredicate
        )
    }

    func testDeleteWithID() async throws {
        try await _testDeleteWithID { createModel() }
    }
}
