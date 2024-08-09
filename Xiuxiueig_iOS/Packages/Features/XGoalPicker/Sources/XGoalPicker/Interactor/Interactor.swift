// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

final class Interactor: InteractorInput {

    var output: InteractorOutput?
    let services: XGoalPickerServiceInterface
    let onSelectHandler: (UUID) -> Void

    init(services: XGoalPickerServiceInterface,
         onSelect: @escaping ((UUID) -> Void)) {
        self.services = services
        self.onSelectHandler = onSelect
    }

    // MARK: - Intercator input

    func request(_ event: InteractorEvents.Input) async {

        switch event {

        case .loadInitialData: await fetchData()
        case let .select(id): await onSelected(withId: id)
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
        // Work with interactor and the SnackBar.
    }

    // MARK: - On actions

    private func onSelected(withId id: UUID) async {

        onSelectHandler(id)
        await fetchData()
    }
}

private extension Interactor {

    func fetchData() async {

        render(.startLoading)

        do {

            let goals = try await services.getAvailableGoals()
            render(.refresh(goals))
        } catch {

            renderError(error)
        }
    }
}
