// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI
import XCoordinator

/// Facility to Build the lecture collection
public struct XLectureCollectionBuilder {

    /// Build the lecture Collection View.
    ///
    /// - Parameters:
    ///   - services: Object that provide conformace to the needs of the Lecture
    ///               collection by conforming to `XLectureCollectionServicesInterface`
    ///   - coordinator: Facility to allow the Lecture Collection request for coordination.
    /// - Returns: The view that contains the collection.
    public static func build(
        services: XLectureCollectionServicesInterface,
        coordinator: XCoordinationRequestProtocol
    ) -> some View {

        let interactor = Interactor(services: services,
                                    coordinator: coordinator)

        let presenter = Presenter()
        interactor.output = presenter

        let view = LectureCollectionView(presenter: presenter,
                                         interactor: interactor)

        return view
    }
}
