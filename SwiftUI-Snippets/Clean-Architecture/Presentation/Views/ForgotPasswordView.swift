//
//  ForgotPasswordView.swift
//  SwiftUI-Snippets
//
//  Created by Asim on 25/11/2025.
//

import SwiftUI

struct ForgotPasswordView: View {

    @Binding var navigationPath: NavigationPath
    @StateObject private var vm: ForgotPasswordViewModel

    init(
        navigationPath: Binding<NavigationPath>,
        repository: AuthRepository
    ) {
        self._navigationPath = navigationPath
        self._vm = StateObject(
            wrappedValue: ForgotPasswordViewModel(
                resetPasswordUseCase: ResetPasswordUseCase(
                    repository: repository
                )
            )
        )
    }

    var body: some View {
        ZStack {
            // Reuse same liquid gradient background
            AngularGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.2, green: 0.4, blue: 1.0),
                    Color(red: 0.3, green: 0.6, blue: 1.0),
                    Color(red: 0.4, green: 0.8, blue: 1.0),
                    Color(red: 0.6, green: 0.9, blue: 1.0),
                    Color(red: 0.8, green: 0.6, blue: 1.0),
                    Color(red: 0.9, green: 0.4, blue: 1.0),
                    Color(red: 0.2, green: 0.4, blue: 1.0)
                ]),
                center: .center
            )
            .ignoresSafeArea()

            ZStack {
                Color.black.opacity(0.3)
                LinearGradient(
                    colors: [
                        Color(red: 1.0, green: 0.2, blue: 0.8).opacity(0.1),
                        Color(red: 0.8, green: 0.2, blue: 1.0).opacity(0.05),
                        Color(red: 0.0, green: 0.8, blue: 0.4).opacity(0.08)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            }
            .ignoresSafeArea()

            VStack(spacing: 22) {

                // Header
                VStack(spacing: 6) {
                    HStack(spacing: 10) {
                        Image(systemName: "key.fill")
                            .font(.system(size: 26, weight: .semibold))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.cyan, .mint],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )

                        Text("Reset Password")
                            .font(.system(.title, design: .rounded, weight: .bold))
                            .foregroundColor(.white)
                    }

                    Text("Enter your username and a new password to reset your account.")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                }
                .padding(.bottom, 8)

                // Fields
                VStack(spacing: 16) {
                    AppTextFieldView(
                        title: "Username",
                        placeholder: "Enter your username",
                        systemImage: "person.fill",
                        isSecure: false,
                        text: $vm.username
                    )

                    AppTextFieldView(
                        title: "New Password",
                        placeholder: "Create a new password",
                        systemImage: "key.fill",
                        isSecure: true,
                        text: $vm.newPassword,
                        textContentType: .newPassword
                    )

                    AppTextFieldView(
                        title: "Confirm Password",
                        placeholder: "Re-enter new password",
                        systemImage: "key.fill",
                        isSecure: true,
                        text: $vm.confirmPassword,
                        textContentType: .newPassword
                    )
                }

                // Status
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
                } else if vm.isSuccess {
                    HStack(spacing: 8) {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundStyle(.green, .white)
                        Text("Password updated successfully. You can now sign in.")
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

                // Reset button
                AppButtonView(
                    title: vm.isLoading ? "Updating..." : "Update Password",
                    systemImage: "arrow.triangle.2.circlepath",
                    isLoading: vm.isLoading,
                    style: .primary
                ) {
                    Task { await vm.resetPassword() }
                }

                // Back to login
                Button {
                    // Pop back to login screen
                    navigationPath.removeLast(navigationPath.count)
                } label: {
                    Text("Remembered your password? ")
                        .foregroundColor(.white.opacity(0.8)) +
                    Text("Go back to Sign in")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }
                .font(.footnote)
                .padding(.top, 8)
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

