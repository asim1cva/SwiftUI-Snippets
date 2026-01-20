//
//  AuthRootView.swift
//  SwiftUI-Snippets
//
//  Created by Asim on 25/11/2025.
//

import SwiftUI

enum AuthRoute: Hashable {
    case login
    case register
}

struct AuthRootView: View {
    @State private var navigationPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $navigationPath) {
            LoginView(navigationPath: $navigationPath)
                .navigationDestination(for: AuthRoute.self) { route in
                    switch route {
                    case .login:
                        LoginView(navigationPath: $navigationPath)
                    case .register:
                        RegisterView(navigationPath: $navigationPath)
                    }
                }
        }
    }
}