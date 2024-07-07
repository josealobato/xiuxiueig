// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI

public struct XPlayerBuilder {

    public static func build(
        services: XPlayerServiceInterface
    ) -> some View {

        let interactor = Interactor(services: services,
                                    audioEngineBuider: AudioEngineBuilder())
        let presenter = Presenter(interactor: interactor)
        interactor.output = presenter

        let view = PlayerView(presenter: presenter)

        return view
    }
}
