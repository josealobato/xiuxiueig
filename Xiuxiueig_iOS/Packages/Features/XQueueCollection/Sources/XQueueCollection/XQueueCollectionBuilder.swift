// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI
import XCoordinator

/// Facility to build the Queue Collection
public struct XQueueCollectionBuilder {

    public static func build(
        services: XQueueCollectionServiceInterface,
        coordinator: XCoordinationRequestProtocol
    ) -> some View {

        let interactor = Interactor(services: services)
        let presenter = Presenter(interactor: interactor)
        interactor.output = presenter

        let view = QueueCollectionView(presenter: presenter,
                                         interactor: interactor)

        return view
    }
}
