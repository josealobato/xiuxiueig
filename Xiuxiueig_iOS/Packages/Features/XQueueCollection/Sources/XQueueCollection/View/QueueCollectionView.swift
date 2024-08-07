// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI

struct QueueCollectionView: View {

    enum ViewState {

        case loading
    }

    @StateObject private var presenter: Presenter
    let interactor: InteractorInput

    init(presenter: Presenter,
         interactor: InteractorInput) {

        self._presenter = StateObject(wrappedValue: presenter)
        self.interactor = interactor
    }

    var body: some View {
        LectureList(lectures: presenter.lectures, onTap: { _ in })
            .onSelect { request(.select($0)) }
            .onPlay {  request(.play($0)) }
            .onDequeue { request(.dequeue($0)) }
            .onDelete { request(.delete($0)) }
            .navigationTitle("Lecture List")
            .onAppear { request(.loadInitialData) }
            .refreshable { request(.loadInitialData) }
    }

    func request(_ event: InteractorEvents.Input) {

        Task {

            await interactor.request(event)
        }
    }
}

struct QueueCollectionView_Previews: PreviewProvider {

    struct TestContainer: View {

        @State private var previewLectures: [LectureViewModel] = [
            LectureViewModel(id: UUID(),
                             title: "One",
                             subtitle: "",
                             imageName: "book.circle"),
            LectureViewModel(id: UUID(),
                             title: "Two",
                             subtitle: "",
                             imageName: "book.fill"),
            LectureViewModel(id: UUID(),
                             title: "Three",
                             subtitle: "",
                             imageName: "bookmark")
        ]

        var body: some View {
            LectureList(lectures: previewLectures, onTap: {_ in })
        }

    }

    static var previews: some View {
        TestContainer()
            .previewDisplayName("ContainerView")
    }
}
