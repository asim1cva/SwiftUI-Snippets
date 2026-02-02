//
//  LocalUserStore.swift
//  SwiftUI-Snippets
//
//  Local persistence for registered users using SwiftData.
//

import Foundation
import SwiftData

@Model
final class LocalUserEntity {
    @Attribute(.unique) var username: String
    var password: String
    var email: String

    init(username: String, password: String, email: String) {
        self.username = username
        self.password = password
        self.email = email
    }
}

final class LocalUserStore {

    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func saveUser(username: String, password: String, email: String) {
        // Try to find an existing user by username
        if let existing = try? context.fetch(
            FetchDescriptor<LocalUserEntity>(
                predicate: #Predicate { $0.username == username }
            )
        ).first {
            existing.password = password
            existing.email = email
        } else {
            let user = LocalUserEntity(username: username, password: password, email: email)
            context.insert(user)
        }

        do {
            try context.save()
        } catch {
            // In a real app, you might log this
        }
    }

    func findUser(username: String, password: String) -> LocalUserEntity? {
        do {
            let descriptor = FetchDescriptor<LocalUserEntity>(
                predicate: #Predicate { $0.username == username && $0.password == password }
            )
            return try context.fetch(descriptor).first
        } catch {
            return nil
        }
    }

    func findUser(byUsername username: String) -> LocalUserEntity? {
        do {
            let descriptor = FetchDescriptor<LocalUserEntity>(
                predicate: #Predicate { $0.username == username }
            )
            return try context.fetch(descriptor).first
        } catch {
            return nil
        }
    }

    func saveExistingUser(_ user: LocalUserEntity) {
        // Entity is already tracked by the context; just save.
        do {
            try context.save()
        } catch {
            // In a real app, you might log this
        }
    }
}

