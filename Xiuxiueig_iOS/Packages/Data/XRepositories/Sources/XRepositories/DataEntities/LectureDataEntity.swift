// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

public struct LectureDataEntity: Identifiable, Equatable {

    public let id: UUID
    public var title: String
    public var category: CategoryDataEntity?
    public var mediaTailURL: URLComponents
    public var imageURL: URL?
    public var queuePosition: Int?
    public var playPosition: Int?
    public var played: [Date]

    public enum State: String, Codable, Equatable {
        case new
        case managed
        case archived
    }
    public var state: State

    public init(id: UUID,
                title: String,
                category: CategoryDataEntity? = nil,
                mediaTailURL: URLComponents,
                imageURL: URL? = nil,
                queuePosition: Int? = nil,
                playPosition: Int? = nil,
                played: [Date] = [],
                state: State = State.new) {

        self.id = id
        self.title = title
        self.category = category
        self.mediaTailURL = mediaTailURL
        self.imageURL = imageURL
        self.queuePosition = queuePosition
        self.playPosition = playPosition
        self.played = played
        self.state = state
    }
}

// MARK: - Extensions to convert to and from model

extension LectureDataEntity {

    func lectureModel() -> LectureModel {

        var state: LectureModel.State
        switch self.state {
        case .archived: state = .archived
        case .new: state = .new
        case .managed: state = .managed
        }

        return LectureModel(externalId: self.id,
                            title: self.title,
                            category: self.category?.categoryModel(),
                            mediaTailURLPath: self.mediaTailURL.path,
                            imageURL: self.imageURL,
                            queuePosition: self.queuePosition,
                            playPosition: self.playPosition,
                            played: self.played,
                            state: state)
    }

    static func from(model: LectureModel) -> Self? {

        guard let mediaTailURLPath = model.mediaTailURLPath,
              let mediaTailURLComponents = URLComponents(string: mediaTailURLPath)
        else { return nil }

        var categoryDataEntity: CategoryDataEntity?
        if let categoryModel = model.category {
            categoryDataEntity = CategoryDataEntity.from(model: categoryModel)
        }

        var state: State
        switch model.state {
        case .archived: state = .archived
        case .new: state = .new
        case .managed: state = .managed
        default: state = .new
        }

        return LectureDataEntity(id: model.externalId ?? UUID(),
                                 title: model.title ?? "",
                                 category: categoryDataEntity,
                                 mediaTailURL: mediaTailURLComponents,
                                 imageURL: model.imageURL ?? nil,
                                 queuePosition: model.queuePosition,
                                 playPosition: model.playPosition,
                                 played: model.played ?? [],
                                 state: state)
    }
}
