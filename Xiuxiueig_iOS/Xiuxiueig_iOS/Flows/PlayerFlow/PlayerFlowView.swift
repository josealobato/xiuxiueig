// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI

/// Base View associated to the Collecction flow. It works in tandem with the
/// view coordinator to manage coordination requests on the Settings Flow.
struct PlayerFlowView: View {

    @ObservedObject var coordinator: PlayerFlowCoordinator

    init(coordinator: PlayerFlowCoordinator) {
        self.coordinator = coordinator
    }

    @State var onFirstLoad = true

    var body: some View {

        // The Main work of the view is holding a Navigation View
        // (pushing) and presenting shets and covers. The building of those
        // views is deferred to the Coordinator.

        NavigationStack(path: $coordinator.path) {
            coordinator.baseCoordinatorView()
                .navigationDestination(for: PlayerFlowCoordinator.Feature.self) { page in
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
            Label(String(localized: "Player", comment: "Tab title"),
                  systemImage: "play")
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
