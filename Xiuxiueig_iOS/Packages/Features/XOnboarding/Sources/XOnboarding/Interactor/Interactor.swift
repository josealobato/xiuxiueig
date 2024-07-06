// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XCoordinator

final class Interactor: InteractorInput {

    var output: InteractorOutput?
    let services: XOnboardingServicesInterface
    let coordinator: XCoordinationRequestProtocol

    let userName: String

    init(output: InteractorOutput? = nil,
         services: XOnboardingServicesInterface,
         coordinator: XCoordinationRequestProtocol,
         userName: String) {
        self.output = output
        self.services = services
        self.coordinator = coordinator
        self.userName = userName
    }

    // MARK: - Interactor input

    func request(_ event: InteractorEvents.Input) async {

        switch event {
        case .loadInitialData: await onLoadInitialData()
        case .done: await onDone()
        }
    }

    // MARK: - Intercator output

    func render(_ event: InteractorEvents.Output) {

        self.output?.dispatch(event)
    }

    // MARK: - On actions

    private func onLoadInitialData() async {
        render(.userName(userName))
    }

    private func onDone() async {
        services.onboardingCompleted()
        coordinator.coordinate(from: .xOnboarding, request: .done)
    }
}
