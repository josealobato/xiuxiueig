// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI

struct SampleTabFlowView: View {

    @ObservedObject var coordinator: SampleTabFlowCoordinator

    init(coordinator: SampleTabFlowCoordinator) {
        self.coordinator = coordinator
    }

    @State var onFirstLoad = true

    var body: some View {

        NavigationStack(path: $coordinator.path) {
            coordinator.baseCoordinatorView()
//                .navigationDestination(for: Feature.self) { page in
//                    flowOneCoordinator.build(feature: page)
//                }
//                .sheet(item: $flowOneCoordinator.sheet) { sheet in
//                    flowOneCoordinator.build(feature: sheet)
//                }
//                .fullScreenCover(item: $flowOneCoordinator.screenCover) { screenCover in
//                    flowOneCoordinator.build(feature: screenCover)
//                }

        }
        .tabItem {
            Label("First", systemImage: "1.circle")
        }
        .onAppear {
            if onFirstLoad {
                onFirstLoad = false
                coordinator.start()
            }
        }
    }
}
