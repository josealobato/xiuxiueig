// copyright © 2024 jose a lobato. under mit license(https://mit-license.org)

import SwiftUI

struct PlayerView: View {

    enum ViewState {

        case loading
    }

    @StateObject private var presenter: Presenter

    init(presenter: Presenter) {

        self._presenter = StateObject(wrappedValue: presenter)
    }

    var body: some View {

        VStack {
            Spacer()
            PlayerCompositeView(viewModel: $presenter.lecture,
                                onPlayPause: { request(.playToggle) },
                                onForward: { request(.skipForward) },
                                onBackwards: { request(.skipBackwards) })
                .padding()
        }
        .onAppear {
            request(.loadInitialData)
        }
    }

    func request(_ event: InteractorEvents.Input) {

        Task {

            await presenter.request(event)
        }
    }
}

struct PlayerView_Previews: PreviewProvider {

    struct TestContainer: View {

        @State private var previewLecture: LectureViewModel =
        LectureViewModel(id: UUID(),
                         title: "Title of One with some extra text for more space",
                         isEnabled: true,
                         isPlaying: false,
                         totalLenghtInSeconds: 3600,
                         currentPossitionInSeconds: 360)

        var body: some View {
            VStack {
                Spacer()
                PlayerCompositeView(viewModel: $previewLecture,
                                    onPlayPause: { },
                                    onForward: { },
                                    onBackwards: { })
                .padding()
            }
        }
    }

    static var previews: some View {
        TestContainer()
            .previewDisplayName("ContainerView")
    }
}
