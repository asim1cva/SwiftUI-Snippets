//
//  LoginViewModel.swift
//  SwiftUI-Snippets
//
//  Created by Asim on 25/11/2025.
//

import SwiftUI

@MainActor
final class LoginViewModel: ObservableObject {

    @Published var username = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var loggedInUser: User?
    @Published var loginSuccessful = false

    private let loginUseCase: LoginUseCase

    init(loginUseCase: LoginUseCase) {
        self.loginUseCase = loginUseCase
    }

    func login() async {
        isLoading = true
        errorMessage = nil
        loginSuccessful = false

        do {
            let user = try await loginUseCase.execute(
                username: username,
                password: password
            )
            loggedInUser = user

            // Save session to UserDefaults
            let sessionManager = UserSessionManager()
            sessionManager.saveLoginSession(username: user.name, userId: user.id)

            loginSuccessful = true
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
