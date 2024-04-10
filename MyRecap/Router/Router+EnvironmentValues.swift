//
//  Router+EnvironmentValues.swift
//
//  AlexFofonov in 2024
//

import SwiftUI

private struct RouterKey: EnvironmentKey {
    static var defaultValue: Router = .init(assembly: Assembly())
}

extension EnvironmentValues {
    var router: Router {
        get { self[RouterKey.self] }
        set { self[RouterKey.self] = newValue }
    }
}
