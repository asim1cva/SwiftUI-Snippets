//
//  AuthRepositoryImpl.swift
//  SwiftUI-Snippets
//
//  Created by Asim on 25/11/2025.
//

import Foundation

enum AuthError: LocalizedError {
    case invalidCredentials
    case userAlreadyExists
    case userNotFound

    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Invalid username or password."
        case .userAlreadyExists:
            return "This username is already registered."
        case .userNotFound:
            return "We couldn't find an account with that username."
        }
    }
}

final class AuthRepositoryImpl: AuthRepository {

    private let localUserStore: LocalUserStore

    init(localUserStore: LocalUserStore) {
        self.localUserStore = localUserStore
    }

    func login(username: String, password: String) async throws -> User {
        // Look up user in SwiftData
        guard let local = localUserStore.findUser(username: username, password: password) else {
            throw AuthError.invalidCredentials
        }

        // Map LocalUserEntity to domain User
        return User(
            id: Int.random(in: 1...1_000_000),
            name: local.username,
            email: local.email
        )
    }

    func register(username: String, password: String, email: String) async throws -> User {
        // Ensure username is not already taken
        if localUserStore.findUser(byUsername: username) != nil {
            throw AuthError.userAlreadyExists
        }

        // Persist to SwiftData
        localUserStore.saveUser(username: username, password: password, email: email)

        // Return a synthetic User domain object
        return User(
            id: Int.random(in: 1...1_000_000),
            name: username,
            email: email
        )
    }

    func resetPassword(username: String, newPassword: String) async throws {
        guard let existing = localUserStore.findUser(byUsername: username) else {
            throw AuthError.userNotFound
        }

        // Update password and persist via SwiftData
        existing.password = newPassword
        localUserStore.saveExistingUser(existing)
    }
}
