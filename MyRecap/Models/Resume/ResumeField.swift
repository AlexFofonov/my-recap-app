//
//  ResumeField.swift
//
//  AlexFofonov in 2024
//

import Foundation

@Observable final class ResumeField: Identifiable {
    init(
        id: UUID = .init(),
        sortIndex: Int = 0,
        title: String = "",
        description: String = ""
    ) {
        self.id = id
        self.sortIndex = sortIndex
        self.title = title
        self.description = description
    }

    init(from model: ResumeFieldModel) {
        id = model.id
        sortIndex = model.sortIndex
        title = model.title
        description = model.descriptionField
    }

    let id: UUID
    var sortIndex: Int
    var title: String
    var description: String
}

extension ResumeField: Equatable {
    static func == (lhs: ResumeField, rhs: ResumeField) -> Bool {
        lhs.id == rhs.id &&
            lhs.sortIndex == rhs.sortIndex &&
            lhs.title == rhs.title &&
            lhs.description == rhs.description
    }
}

extension ResumeField: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(description)
    }
}
