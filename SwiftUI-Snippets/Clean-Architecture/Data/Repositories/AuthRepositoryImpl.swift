//
//  AuthRepositoryImpl.swift
//  SwiftUI-Snippets
//
//  Created by Asim on 25/11/2025.
//

import Foundation

final class AuthRepositoryImpl: AuthRepository {

    private let apiClient: ApiClient
    private let loginURL = "https://your-api.com/login"
    private let registerURL = "https://your-api.com/register"

    init(apiClient: ApiClient = ApiClient()) {
        self.apiClient = apiClient
    }

    func login(username: String, password: String) async throws -> User {
        guard let url = URL(string: loginURL) else {
            throw URLError(.badURL)
        }

        let data = try await apiClient.makeRequest(
            url: url,
            username: username,
            password: password
        )

        return try JSONDecoder().decode(User.self, from: data)
    }

    func register(username: String, password: String, email: String) async throws -> User {
        guard let url = URL(string: registerURL) else {
            throw URLError(.badURL)
        }

        let data = try await apiClient.makeRegisterRequest(
            url: url,
            username: username,
            password: password,
            email: email
        )

        return try JSONDecoder().decode(User.self, from: data)
    }
}
