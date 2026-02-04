//
//  RootView.swift
//  SwiftUI-Snippets
//
//  Root view that determines whether to show auth flow or dashboard.
//

import SwiftUI
import SwiftData
import UIKit

struct RootView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var isLoggedIn = false

    private let sessionManager = UserSessionManager()

    var body: some View {
        Group {
            if isLoggedIn {
                DashboardView()
            } else {
                AuthRootView()
                    .modelContainer(for: [LocalUserEntity.self])
            }
        }
        .onAppear {
            checkLoginStatus()
            // Apply saved theme preference on app launch
            applySavedTheme()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            checkLoginStatus()
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("UserDidLogout"))) { _ in
            isLoggedIn = false
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("UserDidLogin"))) { _ in
            isLoggedIn = true
        }
    }

    private func checkLoginStatus() {
        isLoggedIn = sessionManager.isLoggedIn
    }

    private func applySavedTheme() {
        let darkModeEnabled = UserDefaults.standard.bool(forKey: "darkModeEnabled")
        DispatchQueue.main.async {
            if darkModeEnabled {
                // Force dark mode
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
}