// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI

struct LoggedInFlowView: View {

    // Coordinator associated to this view.
    @ObservedObject var coordinator: LoggedInFlowCoordinator

    init(coordinator: LoggedInFlowCoordinator) {
        self.coordinator = coordinator
    }

    // Access to the system environment.
    @Environment(\.scenePhase) var scenePhase

    // To detect first load of the view and start the coordinator.
    @State var onFirstLoad = true

    var body: some View {
        coordinator.baseCoordinatorView()
            .onAppear {
                if onFirstLoad {
                    onFirstLoad = false
                    coordinator.start()
                    // Let's generate a load event on the services when
                    // the LoggedIn screen shows.
                    coordinator.process(systemEvent: .willEnterForeground)
                }
            }
            // Example of Getting system events that are system level.
            .onChange(of: scenePhase, initial: false) { _, newPhase  in
                switch newPhase {
                case .background:
                    coordinator.process(systemEvent: .didEnterBackground)
                case .inactive:
                    coordinator.process(systemEvent: .willEnterBackground)
                case .active:
                    coordinator.process(systemEvent: .willEnterForeground)
                    coordinator.process(systemEvent: .didEnterForeground)
                @unknown default:
                    break
                }
            }
            .onDisappear {
                coordinator.stop()
            }
    }
}

// No need for preview on this view. In case of need add something like this:
// ``
// #Preview {
//    LoggedInFlowView()
// }
// ```
