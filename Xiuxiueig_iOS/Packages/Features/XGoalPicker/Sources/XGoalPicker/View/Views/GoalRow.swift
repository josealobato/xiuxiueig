// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import SwiftUI

struct GoalRow: View {

    var title: String
    var subTitle: String
    var image: String

    var body: some View {
        HStack {
            Image(systemName: image)
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
    }
}

struct LectureRow_Previews: PreviewProvider {
    static var previews: some View {
        let basicRow1 = GoalRow(title: "Long-term learning",
                                subTitle: "No due date",
                                image: "infinity.circle")

        let basicRow2 = GoalRow(title: "Long-term learning",
                                subTitle: "No due date",
                                image: "target")

        Group {
            List {
                basicRow1
                    .previewDisplayName("No Duedate")
                basicRow2
                    .previewDisplayName("With Duedate")
            }
            .listStyle(.plain)
            //            .preferredColorScheme(.dark)
        }
    }
}
