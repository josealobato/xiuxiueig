// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI
import XCoordinator

/// Facility to Build the lecture details
public struct XSettingsBuilder {

    public static func build(
        services: XSettingsServicesInterface,
        coordinator: XCoordinationRequestProtocol,
        userName: String
    ) -> some View {

        let interactor = Interactor(
            services: services,
            coordinator: coordinator,
            userName: userName
        )

        let presenter = Presenter()
        interactor.output = presenter

        let view = SettingsView(presenter: presenter,
                             interactor: interactor)

        return view
    }
}
