//
//  AuthRootView.swift
//  SwiftUI-Snippets
//
//  Created by Asim on 25/11/2025.
//

import SwiftUI
import SwiftData

enum AuthRoute: Hashable {
    case login
    case register
    case forgotPassword
}

struct AuthRootView: View {
    @State private var navigationPath = NavigationPath()
    @Environment(\.modelContext) private var modelContext

    private var authRepository: AuthRepositoryImpl {
        AuthRepositoryImpl(
            localUserStore: LocalUserStore(context: modelContext)
        )
    }

    private func onAuthSuccess() {
        // Post notification to trigger navigation to dashboard
        NotificationCenter.default.post(name: Notification.Name("UserDidLogin"), object: nil)
    }

    var body: some View {
        NavigationStack(path: $navigationPath) {
            LoginView(navigationPath: $navigationPath, repository: authRepository, onAuthSuccess: onAuthSuccess)
                .navigationDestination(for: AuthRoute.self) { route in
                    switch route {
                    case .login:
                        LoginView(navigationPath: $navigationPath, repository: authRepository, onAuthSuccess: onAuthSuccess)
                    case .register:
                        RegisterView(navigationPath: $navigationPath, repository: authRepository, onAuthSuccess: onAuthSuccess)
                    case .forgotPassword:
                        ForgotPasswordView(navigationPath: $navigationPath, repository: authRepository)
                    }
                }
        }
    }
}