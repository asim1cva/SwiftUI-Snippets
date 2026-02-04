//
//  DashboardViewModel.swift
//  SwiftUI-Snippets
//
//  ViewModel for the dashboard view.
//

import SwiftUI
import UIKit

@MainActor
final class DashboardViewModel: ObservableObject {
    @Published var isLoggingOut = false
    @Published var notificationsEnabled: Bool = UserDefaults.standard.bool(forKey: "notificationsEnabled") {
        didSet {
            UserDefaults.standard.set(notificationsEnabled, forKey: "notificationsEnabled")
        }
    }
    @Published var darkModeEnabled: Bool = UserDefaults.standard.bool(forKey: "darkModeEnabled") {
        didSet {
            UserDefaults.standard.set(darkModeEnabled, forKey: "darkModeEnabled")
            updateAppearance()
        }
    }

    private let sessionManager = UserSessionManager()

    init() {
        // Load saved preferences
        notificationsEnabled = UserDefaults.standard.bool(forKey: "notificationsEnabled")
        darkModeEnabled = UserDefaults.standard.bool(forKey: "darkModeEnabled")

        // Apply initial appearance
        updateAppearance()
    }

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

    func updateAppearance() {
        DispatchQueue.main.async {
            if self.darkModeEnabled {
                // Force dark mode across all windows
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    windowScene.windows.forEach { window in
                        window.overrideUserInterfaceStyle = .dark
                    }
                }
            } else {
                // Use system preference
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    windowScene.windows.forEach { window in
                        window.overrideUserInterfaceStyle = .unspecified
                    }
                }
            }
        }
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