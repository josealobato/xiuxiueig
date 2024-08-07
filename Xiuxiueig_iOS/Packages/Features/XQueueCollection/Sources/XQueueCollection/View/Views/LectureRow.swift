// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI

struct LectureRow: View {

    var title: String
    var subTitle: String
    var imageName: String

    private let handlers: ActionHandlers = .init()

    var body: some View {
        HStack {
            Image(systemName: imageName)
                .scaledToFit()
                .frame(width: 40, height: 40)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .lineLimit(2)
                if !subTitle.isEmpty {
                    Text(subTitle)
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                        .lineLimit(4)
                }

            }
        }
        .swipeActions(edge: .trailing) {
            Button { dequeue() } label: {
                Label("Dequeue",
                      systemImage: "rectangle.stack.badge.minus")
            }
            .tint(.red)
        }
        .swipeActions(edge: .trailing) {
            Button { play() } label: {
                Label("Play",
                      systemImage: "play")
            }
            .tint(.blue)
        }
        .swipeActions(edge: .leading) {
            Button { delete() } label: {
                Label("Delete",
                      systemImage: "trash")
            }
            .tint(.red)
        }
        .contextMenu {

            Button { dequeue() } label: {
                Label("Dequeue",
                      systemImage: "rectangle.stack.badge.minus")
            }
            Button { play() } label: {
                Label("Play",
                      systemImage: "play")
            }

            Divider()
            Button(role: .destructive) { delete() } label: {
                Label("Delete",
                      systemImage: "trash")
            }
        }
    }

    // MARK: - Actions

    public func onPlay(_ action: @escaping (() -> Void)) -> Self {
        handlers.onPlay = action
        return self
    }

    public func onDequeue(_ action: @escaping (() -> Void)) -> Self {
        handlers.onDequeue = action
        return self
    }

    public func onDelete(_ action: @escaping (() -> Void)) -> Self {
        handlers.onDelete = action
        return self
    }
}

private class ActionHandlers {

    var onPlay: (() -> Void)?
    var onDequeue: (() -> Void)?
    var onDelete: (() -> Void)?
}

private extension LectureRow {

    func play() {
        handlers.onPlay?()
    }

    func dequeue() {
        handlers.onDequeue?()
    }

    func delete() {
        handlers.onDelete?()
    }
}

struct LectureRow_Previews: PreviewProvider {
    static var previews: some View {
        let basicRow1 = LectureRow(title: "Egypt rivers",
                                   subTitle: "In all their glory",
                                   imageName: "pin")
            .onPlay { print("onPlay") }
            .onDelete { print("onDelete") }
        let basicRow2 = LectureRow(title: "The best book ever written",
                                   subTitle: "It is about love of course",
                                   imageName: "book.closed")

        let basicRow3 = LectureRow(title: "The best book ever written",
                                   subTitle: "",
                                   imageName: "book.closed")
        Group {
            List {
                basicRow1
                    .previewDisplayName("Short title")

                basicRow2
                    .previewDisplayName("Long Row")
                basicRow3
                    .previewDisplayName("No Subtitle")
            }
            .listStyle(.plain)
            //            .preferredColorScheme(.dark)
        }
    }
}
