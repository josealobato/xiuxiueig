import Foundation
import struct XEntities.LectureEntity
import struct XEntities.CategoryEntity

struct CategoryViewModel: Equatable, Hashable {
    var name: String
    // This string could change to a Image.
    var image: String

    static func from(_ category: CategoryEntity) -> CategoryViewModel {

        CategoryViewModel(name: category.title,
                          image: category.defaultImage)
    }
}

struct ViewModel: Equatable {

    /// We privately save the original Lecture to be able to identify changes
    /// in the editor.
    private var originalLecture: LectureEntity?

    var title: String
    var category: CategoryViewModel?
    var categories: [CategoryViewModel]
    var categoryImageName: String

    var readyToSave: Bool {
        originalLecture?.title != title ||
        originalLecture?.category?.title != category?.name
    }

    init(originalLecture: LectureEntity? = nil,
         title: String,
         category: CategoryViewModel?,
         categories: [CategoryViewModel] = [],
         categoryImageName: String
    ) {
        self.originalLecture = originalLecture
        self.title = title
        self.category = category
        self.categories = categories
        self.categoryImageName = categoryImageName
    }
}

extension ViewModel {

    static func build(from lecture: LectureEntity, categories: [CategoryEntity]) -> ViewModel {

        // This is the current category to view model.
        var categoryViewModel: CategoryViewModel?
        if let category = lecture.category {
            categoryViewModel = CategoryViewModel.from(category)
        }

        // This is the available categories to view models.
        let categoriesViewModel = categories.compactMap { CategoryViewModel.from($0) }

        return ViewModel(
            originalLecture: lecture,
            title: lecture.title,
            category: categoryViewModel,
            categories: categoriesViewModel,
            categoryImageName: lecture.category?.defaultImage ?? "questionmark.circle")
    }

    static func `default`() -> ViewModel {

        return ViewModel(
            originalLecture: nil,
            title: "Title",
            category: nil,
            categoryImageName: "questionmark.circle")
    }
}
