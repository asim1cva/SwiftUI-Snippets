//
//  DashboardView.swift
//  SwiftUI-Snippets
//
//  Main dashboard view with bottom tabs for different sections.
//

import SwiftUI
import UIKit

struct DashboardView: View {
    @StateObject private var vm = DashboardViewModel()
    @State private var selectedTab = 0
    @State private var gradientRotation: Angle = .zero

    // Adaptive text color based on theme
    private var textColor: Color {
        vm.darkModeEnabled ? .white : .black
    }

    private var secondaryTextColor: Color {
        vm.darkModeEnabled ? .white.opacity(0.8) : .black.opacity(0.7)
    }

    private var tertiaryTextColor: Color {
        vm.darkModeEnabled ? .white.opacity(0.5) : .black.opacity(0.5)
    }
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
            // Adaptive background based on theme
            Group {
                if vm.darkModeEnabled {
                    // Dark mode background
                    AngularGradient(
                        gradient: Gradient(colors: [
                            Color(red: 0.1, green: 0.1, blue: 0.2),     // Deep navy
                            Color(red: 0.2, green: 0.1, blue: 0.3),     // Dark purple
                            Color(red: 0.1, green: 0.2, blue: 0.4),     // Dark blue
                            Color(red: 0.3, green: 0.1, blue: 0.4),     // Purple accent
                            Color(red: 0.2, green: 0.2, blue: 0.3),     // Muted indigo
                            Color(red: 0.1, green: 0.1, blue: 0.2)      // Back to deep navy
                        ]),
                        center: .center
                    )
                } else {
                    // Light mode background - enhanced with warmer, brighter colors
                    AngularGradient(
                        gradient: Gradient(colors: [
                            Color(red: 0.95, green: 0.85, blue: 0.4),    // Warm gold
                            Color(red: 1.0, green: 0.7, blue: 0.5),      // Coral pink
                            Color(red: 0.8, green: 0.9, blue: 0.6),      // Mint green
                            Color(red: 0.6, green: 0.8, blue: 1.0),      // Sky blue
                            Color(red: 0.9, green: 0.6, blue: 1.0),      // Lavender
                            Color(red: 1.0, green: 0.8, blue: 0.6),      // Peach
                            Color(red: 0.95, green: 0.85, blue: 0.4)     // Back to gold
                        ]),
                        center: .center
                    )
                }
            }
            .ignoresSafeArea()

            // Adaptive overlay for better contrast and depth
            Group {
                if vm.darkModeEnabled {
                    // Dark mode overlay
                    ZStack {
                        Color.black.opacity(0.4)
                        LinearGradient(
                            colors: [
                                Color(red: 0.2, green: 0.2, blue: 0.4).opacity(0.2),
                                Color(red: 0.3, green: 0.1, blue: 0.5).opacity(0.1),
                                Color.clear
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    }
                } else {
                    // Light mode overlay - subtle for bright backgrounds
                    ZStack {
                        Color.black.opacity(0.25)
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.2),      // Bright highlight
                                Color.white.opacity(0.1),      // Soft glow
                                Color.white.opacity(0.05),     // Gentle fade
                                Color.white.opacity(0.15)      // Subtle contrast
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    }
                }
            }
            .ignoresSafeArea()
            .id(vm.darkModeEnabled) // Force view update when theme changes
            .hueRotation(gradientRotation)
            .brightness(vm.darkModeEnabled ? 0 : 0.05) // Slight brightness boost for light theme
            .saturation(vm.darkModeEnabled ? 0.8 : 1.2) // Enhanced saturation for light theme
            .onAppear {
                // Subtle gradient animation for light theme
                if !vm.darkModeEnabled {
                    withAnimation(.linear(duration: 20).repeatForever(autoreverses: true)) {
                        gradientRotation = .degrees(10)
                    }
                }
            }
            .onChange(of: vm.darkModeEnabled) { newValue in
                // Animate gradient rotation based on theme
                withAnimation(.easeInOut(duration: 1.0)) {
                    gradientRotation = newValue ? .zero : .degrees(10)
                }
            }

            TabView(selection: $selectedTab) {
                // Home Tab
                HomeTabContent(isDarkMode: vm.darkModeEnabled, textColor: textColor, secondaryTextColor: secondaryTextColor)
                    .tabItem {
                        VStack(spacing: 4) {
                            Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                                .font(.system(size: 18))
                            Text("Home")
                                .font(.caption2)
                        }
                    }
                    .tag(0)
                
                // Profile Tab
                ProfileTabContent(viewModel: vm, isDarkMode: vm.darkModeEnabled, textColor: textColor, secondaryTextColor: secondaryTextColor)
                    .tabItem {
                        VStack(spacing: 4) {
                            Image(systemName: selectedTab == 1 ? "person.fill" : "person")
                                .font(.system(size: 18))
                            Text("Profile")
                                .font(.caption2)
                        }
                    }
                    .tag(1)
                
                // Settings Tab
                SettingsTabContent(viewModel: vm, isDarkMode: vm.darkModeEnabled, textColor: textColor, secondaryTextColor: secondaryTextColor)
                    .tabItem {
                        VStack(spacing: 4) {
                            Image(systemName: selectedTab == 2 ? "gear" : "gear")
                                .font(.system(size: 18))
                            Text("Settings")
                                .font(.caption2)
                        }
                    }
                    .tag(2)
                
                // Snippets Tab
                SnippetsTabContent(isDarkMode: vm.darkModeEnabled, textColor: textColor, secondaryTextColor: secondaryTextColor)
                    .tabItem {
                        VStack(spacing: 4) {
                            Image(systemName: selectedTab == 3 ? "swift" : "swift")
                                .font(.system(size: 18))
                            Text("Snippets")
                                .font(.caption2)
                        }
                    }
                    .tag(3)
            }
            .accentColor(Color(red: 0.3, green: 0.8, blue: 1.0)) // Cyan accent for tabs
            .tabViewStyle(.automatic)
            .onAppear {
                // Ensure theme is applied when dashboard appears
                vm.updateAppearance()

                // Customize tab bar appearance with adaptive colors
                let appearance = UITabBarAppearance()
                appearance.configureWithTransparentBackground()

                // Adaptive glass-like background
                appearance.backgroundEffect = vm.darkModeEnabled ?
                    UIBlurEffect(style: .systemThinMaterialDark) :
                    UIBlurEffect(style: .systemThinMaterialLight)

                // Custom colors that work in both themes
                let accentColor = UIColor(Color(red: 0.3, green: 0.8, blue: 1.0))
                appearance.stackedLayoutAppearance.selected.iconColor = accentColor
                appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
                    .foregroundColor: accentColor,
                    .font: UIFont.systemFont(ofSize: 10, weight: .semibold)
                ]
                appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
                    .foregroundColor: UIColor.white.withAlphaComponent(0.7),
                    .font: UIFont.systemFont(ofSize: 10, weight: .regular)
                ]

                UITabBar.appearance().standardAppearance = appearance
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
        }
    }
}

// MARK: - Home Tab Content

struct HomeTabContent: View {
    let isDarkMode: Bool
    let textColor: Color
    let secondaryTextColor: Color

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Welcome Header - redesigned with glass card
                VStack(spacing: 6) {
                    HStack(spacing: 10) {
                        Image(systemName: "house.fill")
                            .font(.system(size: 28, weight: .semibold))
                            .foregroundStyle(
                                isDarkMode ?
                                LinearGradient(
                                    colors: [.purple, .blue],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ) :
                                LinearGradient(
                                    colors: [.orange, .pink],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                        
                        Text("Welcome Home")
                            .font(.system(.largeTitle, design: .rounded, weight: .bold))
                            .foregroundColor(textColor)
                    }

                    Text("Explore your SwiftUI journey")
                        .font(.subheadline)
                        .foregroundColor(secondaryTextColor)
                }
                .padding(.bottom, 8)
                .padding(.top, 20)
                
                // Quick Stats - enhanced glass cards
                HStack(spacing: 16) {
                    StatCardView(
                        title: "SwiftUI",
                        value: "Master",
                        icon: "swift",
                        color: .cyan
                    )
                    
                    StatCardView(
                        title: "Projects",
                        value: "5",
                        icon: "folder.fill",
                        color: .purple
                    )
                }
                .padding(.horizontal, 20)
                
                // Recent Activity - glass container
                VStack(alignment: .leading, spacing: 16) {
                    Text("Recent Activity")
                        .font(.title2.bold())
                        .foregroundColor(textColor)
                        .padding(.horizontal, 20)
                    
                    VStack(spacing: 12) {
                        ActivityRow(
                            icon: "person.badge.plus.fill",
                            title: "Account Created",
                            subtitle: "Welcome to SwiftUI Snippets!",
                            color: .green,
                            textColor: textColor,
                            secondaryTextColor: secondaryTextColor
                        )

                        ActivityRow(
                            icon: "lock.shield.fill",
                            title: "Secure Login",
                            subtitle: "Successfully logged in",
                            color: .blue,
                            textColor: textColor,
                            secondaryTextColor: secondaryTextColor
                        )

                        ActivityRow(
                            icon: "sparkles",
                            title: "New Features",
                            subtitle: "Liquid glassmorphism unlocked",
                            color: .purple,
                            textColor: textColor,
                            secondaryTextColor: secondaryTextColor
                        )
                    }
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(Color.white.opacity(0.08))
                            .background(.ultraThinMaterial)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .stroke(Color.white.opacity(0.1), lineWidth: 0.5)
                            )
                    )
                    .padding(.horizontal, 20)
                }
                
                // Featured Content - enhanced design
                VStack(alignment: .leading, spacing: 16) {
                    Text("Featured Snippets")
                        .font(.title2.bold())
                        .foregroundColor(textColor)
                        .padding(.horizontal, 20)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            SnippetCard(
                                title: "Glassmorphism",
                                subtitle: "Modern UI design",
                                icon: "sparkles",
                                color: .cyan
                            )
                            
                            SnippetCard(
                                title: "SwiftData",
                                subtitle: "Local persistence",
                                icon: "externaldrive.fill",
                                color: .purple
                            )
                            
                            SnippetCard(
                                title: "Clean Arch",
                                subtitle: "Best practices",
                                icon: "building.2.fill",
                                color: .green
                            )
                        }
                        .padding(.horizontal, 20)
                    }
                }
                
                Spacer(minLength: 100)
            }
        }
    }
}


// MARK: - Profile Tab Content

struct ProfileTabContent: View {
    @ObservedObject var viewModel: DashboardViewModel
    let isDarkMode: Bool
    let textColor: Color
    let secondaryTextColor: Color

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Profile Header - enhanced glass card
                VStack(spacing: 16) {
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [.cyan, .blue],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 120, height: 120)
                            .overlay(
                                Circle()
                                    .stroke(
                                        LinearGradient(
                                            colors: [.white.opacity(0.9), .cyan.opacity(0.5)],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ),
                                        lineWidth: 4
                                    )
                            )
                            .shadow(color: .black.opacity(0.4), radius: 20, x: 0, y: 15)
                        
                        Image(systemName: "person.fill")
                            .font(.system(size: 50, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    
                    VStack(spacing: 8) {
                        Text(viewModel.username ?? "User")
                            .font(.system(.title, design: .rounded, weight: .bold))
                            .foregroundColor(textColor)

                        if let duration = viewModel.sessionDurationString {
                            Text("Session: \(duration)")
                                .font(.subheadline)
                                .foregroundColor(secondaryTextColor)
                        }
                    }
                }
                .padding(.bottom, 8)
                .padding(.top, 20)
                
                // Profile Info Cards - enhanced glass container
                VStack(spacing: 16) {
                    ProfileInfoCard(
                        title: "Account Status",
                        value: "Active",
                        icon: "checkmark.seal.fill",
                        color: .green,
                        textColor: textColor,
                        secondaryTextColor: secondaryTextColor
                    )

                    ProfileInfoCard(
                        title: "Member Since",
                        value: "Today",
                        icon: "calendar",
                        color: .blue,
                        textColor: textColor,
                        secondaryTextColor: secondaryTextColor
                    )

                    ProfileInfoCard(
                        title: "SwiftUI Level",
                        value: "Expert",
                        icon: "star.fill",
                        color: .yellow,
                        textColor: textColor,
                        secondaryTextColor: secondaryTextColor
                    )
                }
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .fill(Color.white.opacity(0.08))
                        .background(.ultraThinMaterial)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24, style: .continuous)
                                .stroke(Color.white.opacity(0.1), lineWidth: 0.5)
                        )
                )
                .padding(.horizontal, 20)
                
                // Logout Button - enhanced styling
                AppButtonView(
                    title: "Logout",
                    systemImage: "arrow.right.square",
                    isLoading: viewModel.isLoggingOut,
                    style: .secondary
                ) {
                    Task { await viewModel.logout() }
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                
                Spacer(minLength: 100)
            }
        }
    }
}


// MARK: - Settings Tab Content

struct SettingsTabContent: View {
    @ObservedObject var viewModel: DashboardViewModel
    let isDarkMode: Bool
    let textColor: Color
    let secondaryTextColor: Color

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Settings Header - enhanced glass card
                VStack(spacing: 6) {
                    HStack(spacing: 10) {
                        Image(systemName: "gear")
                            .font(.system(size: 28, weight: .semibold))
                            .foregroundStyle(
                                isDarkMode ?
                                LinearGradient(
                                    colors: [.orange, .red],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ) :
                                LinearGradient(
                                    colors: [.cyan, .purple],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                        
                        Text("Settings")
                            .font(.system(.largeTitle, design: .rounded, weight: .bold))
                            .foregroundColor(textColor)
                    }

                    Text("Customize your experience")
                        .font(.subheadline)
                        .foregroundColor(secondaryTextColor)
                }
                .padding(24)
                .background(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.18),
                                    Color.white.opacity(0.05)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .background(.ultraThinMaterial)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24, style: .continuous)
                                .stroke(
                                    LinearGradient(
                                        colors: [
                                            Color.white.opacity(0.85),
                                            Color.purple.opacity(0.6),
                                            Color.white.opacity(0.15)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 1
                                )
                        )
                        .shadow(color: .black.opacity(0.4), radius: 30, x: 0, y: 20)
                )
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                // Settings Options - enhanced glass container
                VStack(spacing: 16) {
                    SettingsToggleCard(
                        title: "Push Notifications",
                        subtitle: "Receive updates and reminders",
                        icon: "bell.fill",
                        color: .orange,
                        textColor: textColor,
                        secondaryTextColor: secondaryTextColor,
                        isOn: $viewModel.notificationsEnabled
                    )

                        SettingsToggleCard(
                            title: "Dark Mode",
                            subtitle: "Toggle between light and dark themes",
                            icon: "moon.fill",
                            color: .purple,
                            textColor: textColor,
                            secondaryTextColor: secondaryTextColor,
                            isOn: $viewModel.darkModeEnabled
                        )
                    
                    SettingsActionCard(
                        title: "Change Password",
                        subtitle: "Update your login credentials",
                        icon: "key.fill",
                        color: .blue,
                        textColor: textColor,
                        secondaryTextColor: secondaryTextColor,
                        action: {
                            // Navigate to change password
                        }
                    )

                    SettingsActionCard(
                        title: "Privacy Policy",
                        subtitle: "Learn about data usage",
                        icon: "hand.raised.fill",
                        color: .green,
                        textColor: textColor,
                        secondaryTextColor: secondaryTextColor,
                        action: {
                            // Show privacy policy
                        }
                    )

                    SettingsActionCard(
                        title: "Help & Support",
                        subtitle: "Get help or contact support",
                        icon: "questionmark.circle.fill",
                        color: .cyan,
                        textColor: textColor,
                        secondaryTextColor: secondaryTextColor,
                        action: {
                            // Show help
                        }
                    )
                }
                .padding(.horizontal, 20)
                
                Spacer(minLength: 100)
            }
        }
    }
}


// MARK: - Snippets Tab Content

struct SnippetsTabContent: View {
    let isDarkMode: Bool
    let textColor: Color
    let secondaryTextColor: Color
    let snippets = [
        ("Glassmorphism", "Modern frosted glass UI effects", "sparkles"),
        ("SwiftData", "Apple's new ORM solution", "externaldrive.fill"),
        ("Clean Architecture", "Separation of concerns", "building.2.fill"),
        ("NavigationStack", "Modern SwiftUI navigation", "arrow.triangle.branch"),
        ("Animations", "Smooth transitions and effects", "waveform"),
        ("Reusable Components", "DRY principle in UI", "square.grid.3x3.fill")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Snippets Header - enhanced glass card
                VStack(spacing: 6) {
                    HStack(spacing: 10) {
                        Image(systemName: "swift")
                            .font(.system(size: 28, weight: .semibold))
                            .foregroundStyle(
                                isDarkMode ?
                                LinearGradient(
                                    colors: [.yellow, .orange],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ) :
                                LinearGradient(
                                    colors: [.orange, .red],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                        
                        Text("SwiftUI Snippets")
                            .font(.system(.largeTitle, design: .rounded, weight: .bold))
                            .foregroundColor(textColor)
                    }

                    Text("Explore amazing SwiftUI techniques")
                        .font(.subheadline)
                        .foregroundColor(secondaryTextColor)
                }
                .padding(.bottom, 8)
                .padding(.top, 20)
                
                // Snippets Grid - enhanced glass container
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(snippets, id: \.0) { snippet in
                        SnippetGridCard(
                            title: snippet.0,
                            subtitle: snippet.1,
                            icon: snippet.2
                        )
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer(minLength: 100)
            }
        }
    }
}


// MARK: - Supporting Views

struct ActivityRow: View {
    let icon: String
    let title: String
    let subtitle: String
    let color: Color
    let textColor: Color
    let secondaryTextColor: Color

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.2))
                    .frame(width: 40, height: 40)
                
                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.system(size: 16, weight: .semibold))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(textColor)

                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(secondaryTextColor)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(secondaryTextColor)
                .font(.system(size: 14))
        }
        .padding(.vertical, 12)
    }
}

struct SnippetCard: View {
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.2))
                    .frame(width: 50, height: 50)
                
                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.system(size: 20, weight: .semibold))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
                    .lineLimit(2)
            }
        }
        .frame(width: 140, height: 120)
        .padding(12)
    }
}

struct ProfileInfoCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    let textColor: Color
    let secondaryTextColor: Color

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.2))
                    .frame(width: 50, height: 50)
                
                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.system(size: 20, weight: .semibold))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(secondaryTextColor)

                Text(value)
                    .font(.title3.bold())
                    .foregroundColor(textColor)
            }
            
            Spacer()
        }
        .padding(.vertical, 12)
    }
}

struct SettingsToggleCard: View {
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
    let textColor: Color
    let secondaryTextColor: Color
    @Binding var isOn: Bool

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.2))
                    .frame(width: 50, height: 50)
                
                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.system(size: 20, weight: .semibold))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(textColor)

                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(secondaryTextColor)
            }

            Spacer()

            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(color)
        }
        .padding(.vertical, 12)
    }
}

struct SettingsActionCard: View {
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
    let textColor: Color
    let secondaryTextColor: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(color.opacity(0.2))
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: icon)
                        .foregroundColor(color)
                        .font(.system(size: 20, weight: .semibold))
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(textColor)

                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(secondaryTextColor)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(secondaryTextColor)
                    .font(.system(size: 14))
            }
            .padding(.vertical, 12)
        }
        .buttonStyle(.plain)
    }
}

struct SnippetGridCard: View {
    let title: String
    let subtitle: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [.cyan.opacity(0.3), .purple.opacity(0.3)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 60, height: 60)
                
                Image(systemName: icon)
                    .foregroundColor(.cyan)
                    .font(.system(size: 24, weight: .semibold))
            }
            
            VStack(spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)

                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
        }
        .frame(height: 140)
        .padding(12)
    }
}

struct StatCardView: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.2))
                    .frame(width: 50, height: 50)
                
                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.system(size: 20, weight: .semibold))
            }
            
            Text(value)
                .font(.title2.bold())
                .foregroundColor(.primary)

            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
    }
}
