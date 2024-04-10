//
//  MyRecapApp.swift
//
//  AlexFofonov in 2024
//

import SwiftData
import SwiftUI

@main
struct MyRecapApp: App {
    var body: some Scene {
        WindowGroup {
            RouterView()
                .tint(.orange)
        }
        .modelContainer(for: ResumeModel.self)
    }
}
