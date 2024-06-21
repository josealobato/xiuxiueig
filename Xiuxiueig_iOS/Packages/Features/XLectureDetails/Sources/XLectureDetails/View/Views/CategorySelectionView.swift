import SwiftUI

struct CategorySelectionView: View {
    @Environment(\.dismiss) private var dismiss

    @Binding var selection: CategoryViewModel?

    var categories: [CategoryViewModel]

    var body: some View {
        NavigationView {

            List(categories, id: \.name, selection: $selection) { category in
                HStack {
                    Text(category.name)
                    Spacer()
                    if category == selection {
                        Image(systemName: "checkmark")
                            .foregroundColor(.accentColor)
                    }
                }
                .listRowSeparator(.hidden)
                .onTapGesture {
                    self.selection = category
                    dismiss()
                }
            }
            .navigationTitle(LocalizationKey.categorySelectorTitle.localize())
            .listStyle(.plain)
            .toolbar {

                Button(
                    LocalizationKey.categorySelectorCancelButtonTitle.localize()
                ) { dismiss() }

            }
        }
    }
}

struct CategorySelectionView_Previews: PreviewProvider {

    struct BindingTestHolder: View {
        var categories = [
            CategoryViewModel(name: "Phylosophy", image: "pencil.circle"),
            CategoryViewModel(name: "Geography", image: "eraser")
        ]

        @State var selection: CategoryViewModel? = CategoryViewModel(name: "Phylosophy", image: "pencil.circle")

        var body: some View {
            CategorySelectionView(selection: $selection, categories: categories)
        }
    }

    static var previews: some View {
        BindingTestHolder()

    }
}
