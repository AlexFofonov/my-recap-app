//
//  ContactField.swift
//
//  AlexFofonov in 2024
//

import SwiftUI

@Observable final class ContactField: Identifiable {
    init(
        id: UUID = .init(),
        sortIndex: Int = 0,
        title: String = "",
        link: String = ""
    ) {
        self.id = id
        self.sortIndex = sortIndex
        self.title = title
        self.link = link
    }

    init(from model: ContactFieldModel) {
        id = model.id
        sortIndex = model.sortIndex
        title = model.title
        link = model.link
    }

    let id: UUID
    var sortIndex: Int
    var title: String
    var link: String
}

extension ContactField: Equatable {
    static func == (lhs: ContactField, rhs: ContactField) -> Bool {
        lhs.id == rhs.id &&
            lhs.sortIndex == rhs.sortIndex &&
            lhs.title == rhs.title &&
            lhs.link == rhs.link
    }
}

extension ContactField: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(link)
    }
}
