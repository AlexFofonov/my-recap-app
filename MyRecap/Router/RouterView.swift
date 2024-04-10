//
//  RouterView.swift
//
//  AlexFofonov in 2024
//

import SwiftUI

struct RouterView: View {
    @Environment(\.router) var router

    var body: some View {
        let path = Binding {
            router.path
        } set: { value, _ in
            router.path = value
        }
        
        NavigationStack(path: path) {
            router.viewForRoute(.main)
                .navigationDestination(for: Route.self) { route in
                    router.viewForRoute(route)
                }
        }
    }
}
