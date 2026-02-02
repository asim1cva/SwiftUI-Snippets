//
//  UserSessionManager.swift
//  SwiftUI-Snippets
//
//  Manages user session state using UserDefaults.
//

import Foundation

final class UserSessionManager {
    private let userDefaults = UserDefaults.standard

    private enum Keys {
        static let isLoggedIn = "isLoggedIn"
        static let username = "username"
        static let userId = "userId"
        static let loginTimestamp = "loginTimestamp"
    }

    // MARK: - Session State

    var isLoggedIn: Bool {
        userDefaults.bool(forKey: Keys.isLoggedIn)
    }

    var currentUsername: String? {
        userDefaults.string(forKey: Keys.username)
    }

    var currentUserId: Int? {
        let id = userDefaults.integer(forKey: Keys.userId)
        return id == 0 ? nil : id
    }

    var loginTimestamp: Date? {
        guard let timestamp = userDefaults.object(forKey: Keys.loginTimestamp) as? TimeInterval else {
            return nil
        }
        return Date(timeIntervalSince1970: timestamp)
    }

    // MARK: - Session Management

    func saveLoginSession(username: String, userId: Int) {
        userDefaults.set(true, forKey: Keys.isLoggedIn)
        userDefaults.set(username, forKey: Keys.username)
        userDefaults.set(userId, forKey: Keys.userId)
        userDefaults.set(Date().timeIntervalSince1970, forKey: Keys.loginTimestamp)
        userDefaults.synchronize()
    }

    func clearSession() {
        userDefaults.removeObject(forKey: Keys.isLoggedIn)
        userDefaults.removeObject(forKey: Keys.username)
        userDefaults.removeObject(forKey: Keys.userId)
        userDefaults.removeObject(forKey: Keys.loginTimestamp)
        userDefaults.synchronize()
    }

    // MARK: - Utilities

    func getSessionDuration() -> TimeInterval? {
        guard let loginTimestamp else { return nil }
        return Date().timeIntervalSince(loginTimestamp)
    }

    func getSessionDurationString() -> String? {
        guard let duration = getSessionDuration() else { return nil }

        let hours = Int(duration) / 3600
        let minutes = (Int(duration) % 3600) / 60

        if hours > 0 {
            return "\(hours)h \(minutes)m"
        } else {
            return "\(minutes)m"
        }
    }
}