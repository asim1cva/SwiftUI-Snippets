//
//  DashboardView.swift
//  SwiftUI-Snippets
//
//  Main dashboard view with bottom tabs for different sections.
//

import SwiftUI

struct DashboardView: View {
    @StateObject private var vm = DashboardViewModel()
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            // Shared liquid gradient background for all tabs
            AngularGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.2, green: 0.4, blue: 1.0),     // Vibrant blue
                    Color(red: 0.3, green: 0.6, blue: 1.0),     // Bright cyan-blue
                    Color(red: 0.4, green: 0.8, blue: 1.0),     // Electric cyan
                    Color(red: 0.6, green: 0.9, blue: 1.0),     // Light cyan
                    Color(red: 0.8, green: 0.6, blue: 1.0),     // Purple-cyan mix
                    Color(red: 0.9, green: 0.4, blue: 1.0),     // Bright purple
                    Color(red: 0.2, green: 0.4, blue: 1.0)      // Back to blue
                ]),
                center: .center
            )
            .ignoresSafeArea()
            
            // Enhanced overlay for better contrast and depth - matching login theme
            ZStack {
                // Dark overlay for text readability
                Color.black.opacity(0.3)
                // Subtle color tint overlay
                LinearGradient(
                    colors: [
                        Color(red: 1.0, green: 0.2, blue: 0.8).opacity(0.1),  // Vibrant magenta
                        Color(red: 0.8, green: 0.2, blue: 1.0).opacity(0.05), // Electric purple
                        Color(red: 0.0, green: 0.8, blue: 0.4).opacity(0.08)  // Emerald green
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            }
            .ignoresSafeArea()
            
            TabView(selection: $selectedTab) {
                // Home Tab
                HomeTabContent()
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
                ProfileTabContent(viewModel: vm)
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
                SettingsTabContent(viewModel: vm)
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
                SnippetsTabContent()
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
                // Customize tab bar appearance
                let appearance = UITabBarAppearance()
                appearance.configureWithTransparentBackground()
                
                // Glass-like background
                appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
                
                // Custom colors
                appearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color(red: 0.3, green: 0.8, blue: 1.0))
                appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
                    .foregroundColor: UIColor(Color(red: 0.3, green: 0.8, blue: 1.0)),
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
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Welcome Header - redesigned with glass card
                VStack(spacing: 6) {
                    HStack(spacing: 10) {
                        Image(systemName: "house.fill")
                            .font(.system(size: 28, weight: .semibold))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.cyan, .mint],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                        
                        Text("Welcome Home")
                            .font(.system(.largeTitle, design: .rounded, weight: .bold))
                            .foregroundColor(.white)
                    }
                    
                    Text("Explore your SwiftUI journey")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
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
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                    
                    VStack(spacing: 12) {
                        ActivityRow(
                            icon: "person.badge.plus.fill",
                            title: "Account Created",
                            subtitle: "Welcome to SwiftUI Snippets!",
                            color: .green
                        )
                        
                        ActivityRow(
                            icon: "lock.shield.fill",
                            title: "Secure Login",
                            subtitle: "Successfully logged in",
                            color: .blue
                        )
                        
                        ActivityRow(
                            icon: "sparkles",
                            title: "New Features",
                            subtitle: "Liquid glassmorphism unlocked",
                            color: .purple
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
                        .foregroundColor(.white)
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
                            .foregroundColor(.white)
                        
                        if let duration = viewModel.sessionDurationString {
                            Text("Session: \(duration)")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.8))
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
                        color: .green
                    )
                    
                    ProfileInfoCard(
                        title: "Member Since",
                        value: "Today",
                        icon: "calendar",
                        color: .blue
                    )
                    
                    ProfileInfoCard(
                        title: "SwiftUI Level",
                        value: "Expert",
                        icon: "star.fill",
                        color: .yellow
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
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Settings Header - enhanced glass card
                VStack(spacing: 6) {
                    HStack(spacing: 10) {
                        Image(systemName: "gear")
                            .font(.system(size: 28, weight: .semibold))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.cyan, .purple],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                        
                        Text("Settings")
                            .font(.system(.largeTitle, design: .rounded, weight: .bold))
                            .foregroundColor(.white)
                    }
                    
                    Text("Customize your experience")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
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
                        color: .orange, isOn: $viewModel.notificationsEnabled
                    )
                    
                    SettingsToggleCard(
                        title: "Dark Mode",
                        subtitle: "Enable dark theme (coming soon)",
                        icon: "moon.fill",
                        color: .purple, isOn: $viewModel.darkModeEnabled
                    )
                    
                    SettingsActionCard(
                        title: "Change Password",
                        subtitle: "Update your login credentials",
                        icon: "key.fill",
                        color: .blue,
                        action: {
                            // Navigate to change password
                        }
                    )
                    
                    SettingsActionCard(
                        title: "Privacy Policy",
                        subtitle: "Learn about data usage",
                        icon: "hand.raised.fill",
                        color: .green,
                        action: {
                            // Show privacy policy
                        }
                    )
                    
                    SettingsActionCard(
                        title: "Help & Support",
                        subtitle: "Get help or contact support",
                        icon: "questionmark.circle.fill",
                        color: .cyan,
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
                                LinearGradient(
                                    colors: [.orange, .red],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                        
                        Text("SwiftUI Snippets")
                            .font(.system(.largeTitle, design: .rounded, weight: .bold))
                            .foregroundColor(.white)
                    }
                    
                    Text("Explore amazing SwiftUI techniques")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
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
                    .foregroundColor(.white)
                
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.7))
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.white.opacity(0.5))
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
                    .foregroundColor(.white.opacity(0.7))
                
                Text(value)
                    .font(.title3.bold())
                    .foregroundColor(.white)
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
                    .foregroundColor(.white)
                
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
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
                        .foregroundColor(.white)
                    
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.white.opacity(0.5))
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
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
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
                .foregroundColor(.white)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
    }
}
