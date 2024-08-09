// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI
import XCoordinator

/// Facility to build the Goal Picker
public struct XGoalPickerBuilder {

    public static func build(
        services: XGoalPickerServiceInterface,
        coordinator: XCoordinationRequestProtocol,
        onSelectionHandler: @escaping (UUID) -> Void
    ) -> some View {

        let interactor = Interactor(
            services: services,
            onSelect: onSelectionHandler
        )
        let presenter = Presenter(interactor: interactor)
        interactor.output = presenter

        let view = GoalPickerView(
            presenter: presenter,
            interactor: interactor
        )

        return view
    }
}
