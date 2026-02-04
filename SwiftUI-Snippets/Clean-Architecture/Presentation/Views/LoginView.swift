//
//  LoginView.swift
//  SwiftUI-Snippets
//
//  Created by Asim on 25/11/2025.
//

import SwiftUI

struct LoginView: View {
    
    @Binding var navigationPath: NavigationPath
    @StateObject private var vm: LoginViewModel
    let onAuthSuccess: (() -> Void)?
    
    init(
        navigationPath: Binding<NavigationPath>,
        repository: AuthRepository,
        onAuthSuccess: (() -> Void)? = nil
    ) {
        self._navigationPath = navigationPath
        self._vm = StateObject(
            wrappedValue: LoginViewModel(
                loginUseCase: LoginUseCase(
                    repository: repository
                )
            )
        )
        self.onAuthSuccess = onAuthSuccess
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
            VStack(spacing: 24) {
                
                // Header
                VStack(spacing: 6) {
                    HStack(spacing: 10) {
                        Image(systemName: "lock.shield.fill")
                            .font(.system(size: 28, weight: .semibold))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.cyan, .mint],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                        
                        Text("Welcome Back")
                            .font(.system(.largeTitle, design: .rounded, weight: .bold))
                            .foregroundColor(.primary)
                    }

                    Text("Sign in to continue exploring SwiftUI Snippets.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
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
                        title: "Password",
                        placeholder: "••••••••",
                        systemImage: "key.fill",
                        isSecure: true,
                        text: $vm.password,
                        textContentType: .password
                    )
                }
                
                // Forgot password
                Button {
                    navigationPath.append(AuthRoute.forgotPassword)
                } label: {
                    Text("Forgot password?")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .underline()
                        .frame(maxWidth: .infinity, alignment: .trailing)
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
                } else if let user = vm.loggedInUser {
                    HStack(spacing: 8) {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundStyle(.green, .white)
                        Text("Welcome, \(user.name)")
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
                
                // Login button + loader
                AppButtonView(
                    title: vm.isLoading ? "Signing In..." : "Login",
                    systemImage: "arrow.right.circle.fill",
                    isLoading: vm.isLoading,
                    style: .primary
                ) {
                    Task { await vm.login() }
                }
                
                // Don't have account link
                Button {
                    navigationPath.append(AuthRoute.register)
                } label: {
                    Text("Don't have an account? ")
                        .foregroundColor(.secondary) +
                    Text("Sign up")
                    //                        .foregroundColor(.cyan)
                        .fontWeight(.semibold)
                }
                .font(.footnote)
                .padding(.top, 8)
            }
            .padding()
            .onReceive(vm.$loginSuccessful) { success in
                if success {
                    onAuthSuccess?()
                }
            }
        }
    }
}
