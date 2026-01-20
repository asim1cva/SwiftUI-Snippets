//
//  LoginUseCase.swift
//  SwiftUI-Snippets
//
//  Created by Asim on 25/11/2025.
//

import Foundation
final class LoginUseCase {
    private let repository: AuthRepository

    init(repository: AuthRepository) {
        self.repository = repository
    }

    func execute(username: String, password: String) async throws -> User {
        try await repository.login(username: username, password: password)
    }
}
