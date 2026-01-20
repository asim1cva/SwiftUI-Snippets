//
//  ApiClient.swift
//  SwiftUI-Snippets
//
//  Created by Asim on 25/11/2025.
//

import Foundation

final class ApiClient {

    func makeRequest(
        url: URL,
        username: String,
        password: String
    ) async throws -> Data {

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let loginString = "\(username):\(password)"
        let base64Login = Data(loginString.utf8).base64EncodedString()

        request.setValue("Basic \(base64Login)", forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let http = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        guard (200...299).contains(http.statusCode) else {
            throw URLError(.userAuthenticationRequired)
        }

        return data
    }

    func makeRegisterRequest(
        url: URL,
        username: String,
        password: String,
        email: String
    ) async throws -> Data {

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = [
            "username": username,
            "password": password,
            "email": email
        ]

        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let http = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        guard (200...299).contains(http.statusCode) else {
            throw URLError(.userAuthenticationRequired)
        }

        return data
    }
}
