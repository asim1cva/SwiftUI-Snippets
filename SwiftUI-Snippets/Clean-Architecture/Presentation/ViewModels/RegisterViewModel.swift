//
//  RegisterViewModel.swift
//  SwiftUI-Snippets
//
//  Created by Asim on 25/11/2025.
//

import SwiftUI

@MainActor
final class RegisterViewModel: ObservableObject {

    @Published var username = ""
    @Published var password = ""
    @Published var email = ""
    @Published var confirmPassword = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var registeredUser: User?

    private let registerUseCase: RegisterUseCase

    init(registerUseCase: RegisterUseCase) {
        self.registerUseCase = registerUseCase
    }

    func register() async {
        // Basic validation
        guard !username.isEmpty, !password.isEmpty, !email.isEmpty else {
            errorMessage = "Please fill in all fields"
            return
        }

        guard password == confirmPassword else {
            errorMessage = "Passwords don't match"
            return
        }

        guard password.count >= 6 else {
            errorMessage = "Password must be at least 6 characters"
            return
        }

        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter a valid email"
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            let user = try await registerUseCase.execute(
                username: username,
                password: password,
                email: email
            )
            registeredUser = user
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}