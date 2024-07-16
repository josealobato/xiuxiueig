import Foundation
import XCoordinator

final class Interactor: InteractorInput {

    var output: InteractorOutput?
    let services: XLectureCollectionServicesInterface
    let coordinator: XCoordinationRequestProtocol

    init(services: XLectureCollectionServicesInterface,
         coordinator: XCoordinationRequestProtocol) {

        self.services = services
        self.coordinator = coordinator
    }

    // MARK: - Intercator input

    func request(_ event: InteractorEvents.Input) async {

        switch event {

        case .loadInitialData: await fetchData()
        case .select(let id): onSelect(withId: id)
        case .play: print("Interactor play")
        case let .enqueue(id): await enqueueLecture(withId: id)
        case let .dequeue(id): await dequeueLecture(withId: id)
        case .delete: print("Interactor delete")
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

    private func onSelect(withId id: UUID) {

        let detailsRequest = XCoordinationRequest.showLectureDetails(id: id)
        coordinator.coordinate(from: .xLectureCollection, request: detailsRequest)

    }

    private func enqueueLecture(withId id: UUID) async {

        do {
            try await services.enqueueLecture(id: id)
            await fetchData()
        } catch {

            renderError(error)
        }
    }

    private func dequeueLecture(withId id: UUID) async {

        do {
            try await services.dequeueLecture(id: id)
            await fetchData()
        } catch {

            renderError(error)
        }
    }
}

private extension Interactor {

    func fetchData() async {

        render(.startLoading)

        do {

            let lectures = try await services.lectures()
            render(.refresh(lectures))
        } catch {

            renderError(error)
        }
    }
}
