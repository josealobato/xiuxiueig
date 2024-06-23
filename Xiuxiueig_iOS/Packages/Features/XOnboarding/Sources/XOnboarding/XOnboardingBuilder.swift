// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI
import XCoordinator

/// Facility to Build the lecture details
public struct XOnboardingBuilder {

    public static func build(
        services: XOnboardingServicesInterface,
        coordinator: XCoordinationRequestProtocol
    ) -> some View {

        let interactor = Interactor(
            services: services,
            coordinator: coordinator
        )

        let presenter = Presenter()
        interactor.output = presenter

        let view = OnboardingView(presenter: presenter,
                             interactor: interactor)

        return view
    }
}
