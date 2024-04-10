//
//  ResumeModel.swift
//
//  AlexFofonov in 2024
//

import Foundation
import SwiftData
import SwiftUI

@Model final class ResumeModel {
    init(
        name: String = "",
        bDate: Date = .init(),
        job: String = "",
        contacts: [ContactFieldModel] = [],
        fields: [ResumeFieldModel] = [],
        imageData: Data? = nil
    ) {
        self.name = name
        self.bDate = bDate
        self.job = job
        self.contacts = contacts
        self.fields = fields
        self.imageData = imageData
    }

    init(from resume: Resume) {
        name = resume.name
        bDate = resume.bDate
        job = resume.job
        contacts = resume.contacts
            .compactMap { contact in
                if contact.title == "", contact.link == "" {
                    return nil
                } else {
                    return .init(from: contact)
                }
            }
            .sorted(by: { $0.sortIndex < $1.sortIndex })
        fields = resume.fields
            .compactMap { field in
                if field.title == "", field.description == "" {
                    return nil
                } else {
                    return .init(from: field)
                }
            }
            .sorted(by: { $0.sortIndex < $1.sortIndex })
        imageData = resume.imageData
    }

    let name: String
    let bDate: Date
    let job: String
    @Relationship(deleteRule: .cascade) let contacts: [ContactFieldModel]
    @Relationship(deleteRule: .cascade) let fields: [ResumeFieldModel]
    @Attribute(.externalStorage) var imageData: Data?
}
