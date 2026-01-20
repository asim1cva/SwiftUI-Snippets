//
//  AuthRepositoryImpl.swift
//  SwiftUI-Snippets
//
//  Created by Asim on 25/11/2025.
//

import Foundation

final class AuthRepositoryImpl: AuthRepository {

    private let apiClient: ApiClient
    private let baseURL = "https://your-api.com/login"

    init(apiClient: ApiClient = ApiClient()) {
        self.apiClient = apiClient
    }

    func login(username: String, password: String) async throws -> User {
        guard let url = URL(string: baseURL) else {
            throw URLError(.badURL)
        }

        let data = try await apiClient.makeRequest(
            url: url,
            username: username,
            password: password
        )

        return try JSONDecoder().decode(User.self, from: data)
    }
}
