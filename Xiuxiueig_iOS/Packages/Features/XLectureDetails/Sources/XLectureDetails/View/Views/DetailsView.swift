import SwiftUI

struct DetailsView: View {

    @Binding var lecture: ViewModel
    @State var shouldPresentCategorySelectionSheet = false

    private var handlers: ActionHandlers = .init()

    init(lecture: Binding<ViewModel>) {

        self._lecture = lecture
    }

    var body: some View {

        VStack(alignment: .leading) {

            Text(LocalizationKey.titleLabel.localize())
            TextField(LocalizationKey.titleHint.localize(), text: $lecture.title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Text(LocalizationKey.titleAdvice.localize())
                .font(.footnote)
                .foregroundColor(.gray)

            HStack {
                Text(LocalizationKey.categoryLabel.localize())
                Spacer()
                // Not sure yet if I want to show also the category image.
                //                Image(systemName: lecture.categoryImageName)
                Button(lecture.category?.name ?? LocalizationKey.noCategory.localize()) {
                    shouldPresentCategorySelectionSheet.toggle()
                }
            }
            .padding(.top)
            .sheet(isPresented: $shouldPresentCategorySelectionSheet) {
                CategorySelectionView(selection: $lecture.category, categories: lecture.categories)

            }
            Text(LocalizationKey.categoryAdvice.localize())
                .font(.footnote)
                .padding(.top, 1)
                .foregroundColor(.gray)

            Spacer()

            HStack {
                Spacer()
                Button(LocalizationKey.save.localize(),
                       action: { save() })
                .disabled(!lecture.readyToSave)
            }
        }
        .padding()
        .navigationTitle(LocalizationKey.navigationTitle.localize())
    }

    // MARK: - Actions

    public func onSave(_ action: @escaping ((ViewModel) -> Void)) -> Self {
        handlers.onSave = action
        return self
    }
}

private class ActionHandlers {

    var onSave: ((ViewModel) -> Void)?
}

private extension DetailsView {

    func save() {
        handlers.onSave?(lecture)
    }
}

struct SwiftUIView_Previews: PreviewProvider {

    static var categories = [
        CategoryViewModel(name: "Phylosophy", image: "pencil.circle"),
        CategoryViewModel(name: "Geography", image: "eraser")
    ]

    struct BindingTestHolder: View {
        @State var model: ViewModel = ViewModel(originalLecture: nil,
                                                title: "This a normal title",
                                                category: nil,
                                                categories: categories,
                                                categoryImageName: "questionmark.circle")
        var body: some View {
            DetailsView(lecture: $model)
        }
    }

    static var previews: some View {
        NavigationView {
            BindingTestHolder()
                .previewDisplayName("Details View")
        }

    }
}
