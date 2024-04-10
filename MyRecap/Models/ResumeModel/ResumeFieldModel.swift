//
//  ResumeFieldModel.swift
//
//  AlexFofonov in 2024
//

import Foundation
import SwiftData

@Model final class ResumeFieldModel: Identifiable {
    init(
        id: UUID = .init(),
        sortIndex: Int = 0,
        title: String = "",
        description: String = ""
    ) {
        self.id = id
        self.sortIndex = sortIndex
        self.title = title
        descriptionField = description
    }

    init(from resumeField: ResumeField) {
        id = resumeField.id
        sortIndex = resumeField.sortIndex
        title = resumeField.title
        descriptionField = resumeField.description
    }

    let id: UUID
    let sortIndex: Int
    let title: String
    let descriptionField: String
}
