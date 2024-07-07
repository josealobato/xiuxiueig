// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI

/// Base View associated to the Collecction flow. It works in tandem with the
/// view coordinator to manage coordination requests on the Settings Flow.
struct SettingsFlowView: View {

    @ObservedObject var coordinator: SettingsFlowCoordinator

    init(coordinator: SettingsFlowCoordinator) {
        self.coordinator = coordinator
    }

    @State var onFirstLoad = true

    var body: some View {

        // The Main work of the view is holding a Navigation View
        // (pushing) and presenting shets and covers. The building of those
        // views is deferred to the Coordinator.

        NavigationStack(path: $coordinator.path) {
            coordinator.baseCoordinatorView()
                .navigationDestination(for: SettingsFlowCoordinator.Feature.self) { page in
                    coordinator.build(feature: page)
                }
                .sheet(item: $coordinator.sheet) { sheet in
                    coordinator.build(feature: sheet)
                }
                .fullScreenCover(item: $coordinator.screenCover) { screenCover in
                    coordinator.build(feature: screenCover)
                }
        }
        .tabItem {
            Label("Settings", systemImage: "gearshape")
        }
        .onAppear {
            if onFirstLoad {
                onFirstLoad = false
                coordinator.start()
            }
        }
        .onDisappear {
            // Usualy you would Stop here the coordinator:
            // `coordinator.stop()`
            // But that doesn't work since this view will be located in tab and
            // this method will be invoqued
        }
    }
}
