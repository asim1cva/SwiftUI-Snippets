//
//  ForgotPasswordViewModel.swift
//  SwiftUI-Snippets
//
//  Created by Asim on 25/11/2025.
//

import SwiftUI

@MainActor
final class ForgotPasswordViewModel: ObservableObject {

    @Published var username = ""
    @Published var newPassword = ""
    @Published var confirmPassword = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isSuccess = false

    private let resetPasswordUseCase: ResetPasswordUseCase

    init(resetPasswordUseCase: ResetPasswordUseCase) {
        self.resetPasswordUseCase = resetPasswordUseCase
    }

    func resetPassword() async {
        // Basic validation
        guard !username.isEmpty, !newPassword.isEmpty, !confirmPassword.isEmpty else {
            errorMessage = "Please fill in all fields"
            return
        }

        guard newPassword == confirmPassword else {
            errorMessage = "Passwords don't match"
            return
        }

        guard newPassword.count >= 6 else {
            errorMessage = "Password must be at least 6 characters"
            return
        }

        isLoading = true
        errorMessage = nil
        isSuccess = false

        do {
            try await resetPasswordUseCase.execute(
                username: username,
                newPassword: newPassword
            )
            isSuccess = true
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}

