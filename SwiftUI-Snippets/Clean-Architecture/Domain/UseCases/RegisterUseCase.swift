//
//  RegisterUseCase.swift
//  SwiftUI-Snippets
//
//  Created by Asim on 25/11/2025.
//

import Foundation

final class RegisterUseCase {
    private let repository: AuthRepository

    init(repository: AuthRepository) {
        self.repository = repository
    }

    func execute(username: String, password: String, email: String) async throws -> User {
        try await repository.register(username: username, password: password, email: email)
    }
}