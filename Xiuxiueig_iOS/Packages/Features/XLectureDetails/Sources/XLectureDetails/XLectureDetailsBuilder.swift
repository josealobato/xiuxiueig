// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI

/// Facility to Build the lecture details
public struct XLectureDetailsBuilder {

    public static func build(
        entityId: UUID,
        services: XLectureDetailsServiceInterface
    ) -> some View {

        let interactor = Interactor(entityId: entityId,
                                    services: services)

        let presenter = Presenter(interactor: interactor)
        interactor.output = presenter

        let view = PackageView(presenter: presenter,
                               interactor: interactor)

        return view
    }
}
