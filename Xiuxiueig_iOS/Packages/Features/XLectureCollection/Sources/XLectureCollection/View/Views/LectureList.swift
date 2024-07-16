import SwiftUI

struct LectureList: View {

    var lectures: [LectureViewModel]

    var onTap: ((LectureViewModel.ID) -> Void)

    @State private var selectedTab: Int = 1
    private let handlers: ActionHandlers = .init()

    var body: some View {

        List {

            ForEach(lectures) { lecture in
                LectureRow(title: lecture.title,
                           subTitle: lecture.subtitle,
                           imageName: lecture.imageName,
                           isStacked: lecture.isStacked,
                           timesPlayed: lecture.timesPlayed)
                .onPlay { play(id: lecture.id) }
                .onEnqueue { enqueue(id: lecture.id) }
                .onDequeue { dequeue(id: lecture.id) }
                .onDelete { delete(id: lecture.id) }
                .onTapGesture { select(id: lecture.id) }
            }
            .listRowSeparator(.hidden)

        }
        .listStyle(.plain)
        .navigationTitle(LocalizationKey.lectures.localize())
    }

    // MARK: - Actions

    public func onSelect(_ action: @escaping ((UUID) -> Void)) -> Self {
        handlers.onSelect = action
        return self
    }

    public func onPlay(_ action: @escaping ((UUID) -> Void)) -> Self {
        handlers.onPlay = action
        return self
    }

    public func onEnqueue(_ action: @escaping ((UUID) -> Void)) -> Self {
        handlers.onEnqueue = action
        return self
    }

    public func onDequeue(_ action: @escaping ((UUID) -> Void)) -> Self {
        handlers.onDequeue = action
        return self
    }

    public func onDelete(_ action: @escaping ((UUID) -> Void)) -> Self {
        handlers.onDelete = action
        return self
    }
}

private class ActionHandlers {

    var onSelect: ((UUID) -> Void)?
    var onPlay: ((UUID) -> Void)?
    var onEnqueue: ((UUID) -> Void)?
    var onDequeue: ((UUID) -> Void)?
    var onDelete: ((UUID) -> Void)?
}

private extension LectureList {

    func select(id: UUID) {
        handlers.onSelect?(id)
    }

    func play(id: UUID) {
        handlers.onPlay?(id)
    }

    func enqueue(id: UUID) {
        handlers.onEnqueue?(id)
    }

    func dequeue(id: UUID) {
        handlers.onDequeue?(id)
    }

    func delete(id: UUID) {
        handlers.onDelete?(id)
    }
}

struct SwiftUIView_Previews: PreviewProvider {

    // swiftlint:disable line_length
    @State static var models = [
        LectureViewModel(id: UUID(),
                         title: "This a normal title",
                         subtitle: "",
                         timesPlayed: 25,
                         imageName: "book.circle",
                         isStacked: true),
        LectureViewModel(id: UUID(),
                         title: "This is a somehow very long title to see how it behaves",
                         subtitle: "This is a somehow very long title to see how it behaves This is a somehow very long title to see how it behaves This is a somehow very long title to see how it behaves",
                         timesPlayed: 0,
                         imageName: "book.fill",
                         isStacked: false),
        LectureViewModel(id: UUID(),
                         title: "Three",
                         subtitle: "",
                         timesPlayed: 0,
                         imageName: "bookmark",
                         isStacked: true)
    ]
    // swiftlint:enable  line_length

    static var previews: some View {
        NavigationView {
            LectureList(lectures: models,
                        onTap: { _ in })
            .previewDisplayName("Lecture Collection")
            //                .preferredColorScheme(.dark)
        }

    }
}
