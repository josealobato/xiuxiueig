// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XCoordinator

final class Interactor: InteractorInput {

    var output: InteractorOutput?
    let services: XOnboardingServicesInterface
    let coordinator: XCoordinationRequestProtocol

    init(output: InteractorOutput? = nil,
         services: XOnboardingServicesInterface,
         coordinator: XCoordinationRequestProtocol) {
        self.output = output
        self.services = services
        self.coordinator = coordinator
    }

    // MARK: - Interactor input

    func request(_ event: InteractorEvents.Input) async {

        switch event {
        case .done: await onDone()
        }
    }

    // MARK: - Intercator output

    func render(_ event: InteractorEvents.Output) {

        // This is infact not needed
        //     self.output?.dispatch(event)
    }

    // MARK: - Error

    private func renderError(_ error: Error, retryAction: (() -> Void)? = nil) {
        // Work with coordinator and the SnackBar.
    }

    // MARK: - On actions

    private func onDone() async {
        coordinator.coordinate(from: .xOnboarding, request: .done)
    }
}
