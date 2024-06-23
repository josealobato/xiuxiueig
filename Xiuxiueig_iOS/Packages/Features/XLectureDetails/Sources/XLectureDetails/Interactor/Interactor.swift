// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import struct XEntities.LectureEntity
import struct XEntities.CategoryEntity

final class Interactor: InteractorInput {

    var output: InteractorOutput?
    let services: XLectureDetailsServiceInterface
    let entityId: String
    var lecture: LectureEntity?
    var categories: [CategoryEntity] = []

    init(entityId: String,
         services: XLectureDetailsServiceInterface) {
        self.entityId = entityId
        self.services = services
    }

    // MARK: - Intercator input

    func request(_ event: InteractorEvents.Input) async {

        switch event {

        case .loadInitialData: await fetchData()
        case .save(let modifiedData): await onSave(changedLecture: modifiedData)
        }
    }

    // MARK: - Intercator output

    func render(_ event: InteractorEvents.Output) {

        DispatchQueue.main.async {

            self.output?.dispatch(event)
        }
    }

    // MARK: - Error

    private func renderError(_ error: Error, retryAction: (() -> Void)? = nil) {
        // Work with coordinator and the SnackBar.
    }

    // MARK: - On actions

    private func onSave(changedLecture: ViewModel) async {

        lecture?.title = changedLecture.title
        lecture?.category = categories.first(where: { $0.title == changedLecture.category?.name })

        do {

            if let lecture = lecture {

                try await services.save(lecture: lecture)
                // After saving we render the data again to update any
                // visual state.
                await fetchData()
            }

        } catch {

            renderError(error)
        }
    }
}

private extension Interactor {

    func fetchData() async {

        render(.startLoading)

        do {

            lecture = try await services.lecture(withId: entityId)
            categories = try await services.categories()
            if let lecture = lecture {

                render(.refresh(lecture, categories))
            }
        } catch {

            renderError(error)
        }
    }
}
