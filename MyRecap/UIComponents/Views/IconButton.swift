//
//  IconButton.swift
//
//  AlexFofonov in 2024
//

import SwiftUI

struct IconButton: View {
    init(_ icon: Icon, _ action: @escaping () -> Void) {
        self.icon = icon
        self.action = action
    }

    let icon: Icon
    let action: () -> Void

    var body: some View {
        Button(action: {}) {
            Image(systemName: icon.rawValue)
        }
        .onTapGesture {
            action()
        }
    }
}
