//
//  TitleButton.swift
//
//  AlexFofonov in 2024
//

import SwiftUI

struct TitleButton: View {
    init(_ text: String, _ action: @escaping () -> Void) {
        self.text = text
        self.action = action
    }

    let text: String
    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}
