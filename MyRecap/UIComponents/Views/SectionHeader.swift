//
//  SectionHeader.swift
//
//  AlexFofonov in 2024
//

import SwiftUI

struct SectionHeader: View {
    init(_ title: String) {
        self.title = title
    }

    let title: String

    var body: some View {
        Section(title) {}
            .listSectionSpacing(0)
    }
}
