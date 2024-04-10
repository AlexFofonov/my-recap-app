//
//  Router.swift
//
//  AlexFofonov in 2024
//

import SwiftUI

@Observable final class Router {
    init(assembly: Assembly) {
        self.assembly = assembly
        path = NavigationPath()
    }

    let assembly: Assembly
    var path: NavigationPath

    @ViewBuilder
    func viewForRoute(_ route: Route) -> some View {
        switch route {
        case .main:
            assembly.mainView()
        case .resumeEditor:
            assembly.resumeEditor()
        }
    }
}
