//
//  ContactFieldModel.swift
//
//  AlexFofonov in 2024
//

import Foundation
import SwiftData

@Model final class ContactFieldModel: Identifiable {
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

    init(from contactField: ContactField) {
        id = contactField.id
        sortIndex = contactField.sortIndex
        title = contactField.title
        link = contactField.link
    }

    let id: UUID
    let sortIndex: Int
    let title: String
    let link: String
}
