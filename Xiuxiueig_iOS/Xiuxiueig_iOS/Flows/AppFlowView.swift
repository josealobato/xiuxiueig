// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI

struct AppFlowView: View {

    // Coordinator associated to this view
    @StateObject private var coordinator = AppFlowCoordinator()

    // To detect first load of the view and start the coordinator.
    @State var onFirstLoad = true

    var body: some View {
        coordinator.baseCoordinatorView()
            .onAppear {
                if onFirstLoad {
                    onFirstLoad = false
                    coordinator.start()
                }
            }
            .onDisappear {
                coordinator.stop()
            }
    }
}
