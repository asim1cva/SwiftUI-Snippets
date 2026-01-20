//
//  RegisterView.swift
//  SwiftUI-Snippets
//
//  Created by Asim on 25/11/2025.
//

import SwiftUI

struct RegisterView: View {

    @Binding var navigationPath: NavigationPath

    @StateObject private var vm = RegisterViewModel(
        registerUseCase: RegisterUseCase(
            repository: AuthRepositoryImpl()
        )
    )

    init(navigationPath: Binding<NavigationPath>) {
        self._navigationPath = navigationPath
    }

    var body: some View {
        ZStack {
            // Liquid gradient background - iOS 26 style
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

            // Enhanced overlay for better contrast and depth
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

            // Glass card
            VStack(spacing: 20) {

                // Header
                VStack(spacing: 6) {
                    HStack(spacing: 10) {
                        Image(systemName: "person.badge.plus.fill")
                            .font(.system(size: 28, weight: .semibold))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.cyan, .mint],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )

                        Text("Create Account")
                            .font(.system(.largeTitle, design: .rounded, weight: .bold))
                            .foregroundColor(.white)
                    }

                    Text("Sign up to start exploring SwiftUI Snippets.")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding(.bottom, 8)

                // Fields
                VStack(spacing: 16) {
                    AppTextFieldView(
                        title: "Username",
                        placeholder: "Choose a username",
                        systemImage: "person.fill",
                        isSecure: false,
                        text: $vm.username
                    )

                    AppTextFieldView(
                        title: "Email",
                        placeholder: "Enter your email",
                        systemImage: "envelope.fill",
                        isSecure: false,
                        text: $vm.email,
                        keyboardType: .emailAddress,
                        textContentType: .emailAddress
                    )

                    AppTextFieldView(
                        title: "Password",
                        placeholder: "Create a password",
                        systemImage: "key.fill",
                        isSecure: true,
                        text: $vm.password,
                        textContentType: .newPassword
                    )

                    AppTextFieldView(
                        title: "Confirm Password",
                        placeholder: "Confirm your password",
                        systemImage: "key.fill",
                        isSecure: true,
                        text: $vm.confirmPassword,
                        textContentType: .newPassword
                    )
                }

                // Status (error / success)
                if let error = vm.errorMessage {
                    HStack(spacing: 8) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.red.opacity(0.9))
                        Text(error)
                            .font(.footnote)
                            .foregroundColor(.red.opacity(0.95))
                            .multilineTextAlignment(.leading)
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .fill(Color.red.opacity(0.08))
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    )
                    .transition(.opacity.combined(with: .move(edge: .top)))
                } else if let user = vm.registeredUser {
                    HStack(spacing: 8) {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundStyle(.green, .white)
                        Text("Welcome, \(user.name)! Account created successfully.")
                            .font(.footnote.weight(.medium))
                            .foregroundColor(.green.opacity(0.95))
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .fill(Color.green.opacity(0.08))
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    )
                    .transition(.opacity.combined(with: .move(edge: .top)))
                }

                // Register button + loader
                AppButtonView(
                    title: vm.isLoading ? "Creating Account..." : "Create Account",
                    systemImage: "person.badge.plus.fill",
                    isLoading: vm.isLoading,
                    style: .primary
                ) {
                    Task { await vm.register() }
                }

                // Already have account link
                Button {
                    navigationPath.append(AuthRoute.login)
                } label: {
                    Text("Already have an account? ")
                        .foregroundColor(.white.opacity(0.8)) +
                    Text("Sign in")
//                        .foregroundColor(.cyan)
                        .fontWeight(.semibold)
                }
                .font(.footnote)
                .padding(.top, 8)

                // Helper text
                Text("By creating an account, you agree to our terms and conditions.")
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.65))
                    .multilineTextAlignment(.center)
                    .padding(.top, 4)
            }
            .padding(24)
            .background(
                RoundedRectangle(cornerRadius: 32, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.25),
                                Color.white.opacity(0.08),
                                Color.white.opacity(0.15)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 32, style: .continuous)
                            .stroke(
                                LinearGradient(
                                    colors: [
                                        Color.white.opacity(0.9),
                                        Color.cyan.opacity(0.6),
                                        Color.white.opacity(0.2)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1.5
                            )
                    )
                    .shadow(color: Color.black.opacity(0.6), radius: 50, x: 0, y: 30)
                    .shadow(color: Color(red: 1.0, green: 0.5, blue: 0.2).opacity(0.25), radius: 20, x: 0, y: 10)
            )
            .padding(.horizontal, 24)
            .padding(.vertical, 40)
        }
    }
}
