//
//  ResetPasswordUseCase.swift
//  SwiftUI-Snippets
//
//  Created by Asim on 25/11/2025.
//

import Foundation

final class ResetPasswordUseCase {
    private let repository: AuthRepository

    init(repository: AuthRepository) {
        self.repository = repository
    }

    func execute(username: String, newPassword: String) async throws {
        try await repository.resetPassword(username: username, newPassword: newPassword)
    }
}

