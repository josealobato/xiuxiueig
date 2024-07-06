// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import XCoordinator

final class Interactor: InteractorInput {

    var output: InteractorOutput?
    let services: XLoginServicesInterface
    let coordinator: XCoordinationRequestProtocol

    init(output: InteractorOutput? = nil,
         services: XLoginServicesInterface,
         coordinator: XCoordinationRequestProtocol) {
        self.output = output
        self.services = services
        self.coordinator = coordinator
    }

    // MARK: - Interactor input

    func request(_ event: InteractorEvents.Input) async {

        switch event {
        case .done(let name): await onDone(with: name)
        }
    }

    // MARK: - Intercator output

    func render(_ event: InteractorEvents.Output) {

        self.output?.dispatch(event)
    }

    // MARK: - On actions

    private func onDone(with name: String) async {

        do {
            try await services.saveUser(name: name)
            coordinator.coordinate(from: .xLogin, request: .done)
        } catch {

            render(.errorOnSave)
        }
    }
}
