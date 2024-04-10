//
//  Resume.swift
//
//  AlexFofonov in 2024
//

import Foundation
import SwiftUI

@Observable final class Resume {
    init(
        name: String = "",
        bDate: Date = .init(),
        job: String = "",
        contacts: [ContactField] = [],
        fields: [ResumeField] = [],
        imageData: Data? = nil
    ) {
        self.name = name
        self.bDate = bDate
        self.job = job
        self.contacts = contacts
        self.fields = fields
        self.imageData = imageData
    }

    init(from model: ResumeModel) {
        name = model.name
        bDate = model.bDate
        job = model.job
        contacts = model.contacts
            .map { .init(from: $0) }
            .sorted(by: { $0.sortIndex < $1.sortIndex })
        fields = model.fields
            .map { .init(from: $0) }
            .sorted(by: { $0.sortIndex < $1.sortIndex })
        imageData = model.imageData
    }

    var name: String
    var bDate: Date
    var job: String
    var contacts: [ContactField]
    var fields: [ResumeField]
    var imageData: Data?

    var uiImage: UIImage? {
        guard let imageData else {
            return nil
        }

        return UIImage(data: imageData)
    }

    var age: String {
        let age: Int? = Calendar(identifier: .gregorian).dateComponents(
            [.year],
            from: bDate,
            to: .now
        ).year

        if let age, age > 0 {
            return L10n.ages(age)
        } else {
            return ""
        }
    }

    var isEmpty: Bool {
        name == "" && age == "" && job == "" && contacts.isEmpty && fields.isEmpty && imageData == nil
    }
}

extension Resume: Equatable {
    static func == (lhs: Resume, rhs: Resume) -> Bool {
        lhs.name == rhs.name &&
            lhs.bDate == rhs.bDate &&
            lhs.job == rhs.job &&
            lhs.contacts.filter {
                $0.title != "" || $0.link != ""
            } == rhs.contacts.filter {
                $0.title != "" || $0.link != ""
            } &&
            lhs.fields.filter {
                $0.title != "" || $0.description != ""
            } == rhs.fields.filter {
                $0.title != "" || $0.description != ""
            } &&
            lhs.imageData == rhs.imageData
    }
}

extension Resume: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(bDate)
        hasher.combine(job)
        hasher.combine(contacts)
        hasher.combine(fields)
        hasher.combine(imageData)
    }
}
