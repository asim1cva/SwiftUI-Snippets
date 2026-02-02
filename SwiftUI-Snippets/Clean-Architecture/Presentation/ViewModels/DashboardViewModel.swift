//
//  DashboardViewModel.swift
//  SwiftUI-Snippets
//
//  ViewModel for the dashboard view.
//

import SwiftUI

@MainActor
final class DashboardViewModel: ObservableObject {
    @Published var isLoggingOut = false
    @Published var notificationsEnabled = true
    @Published var darkModeEnabled = false

    private let sessionManager = UserSessionManager()

    var username: String? {
        sessionManager.currentUsername
    }

    var userId: Int? {
        sessionManager.currentUserId
    }

    var sessionDurationString: String? {
        sessionManager.getSessionDurationString()
    }

    var loginTimestamp: Date? {
        sessionManager.loginTimestamp
    }

    func logout() async {
        isLoggingOut = true

        // Simulate logout process
        try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds

        // Clear session
        sessionManager.clearSession()

        isLoggingOut = false

        // Post notification to trigger navigation back to login
        NotificationCenter.default.post(name: Notification.Name("UserDidLogout"), object: nil)
    }
}