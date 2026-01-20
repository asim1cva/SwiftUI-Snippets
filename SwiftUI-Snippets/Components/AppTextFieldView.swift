//
//  AppTextFieldView.swift
//  SwiftUI-Snippets
//
//  A reusable glassmorphism text field component for the app.
//

import SwiftUI

struct AppTextFieldView: View {
    let title: String
    let placeholder: String
    let systemImage: String
    let isSecure: Bool
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    var textContentType: UITextContentType?

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.caption)
                .foregroundColor(.white.opacity(0.75))

            HStack {
                Image(systemName: systemImage)
                    .foregroundColor(.white.opacity(0.7))

                if isSecure {
                    SecureField(placeholder, text: $text)
                        .foregroundColor(.white)
                } else {
                    TextField(placeholder, text: $text)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .foregroundColor(.white)
                        .keyboardType(keyboardType)
                        .textContentType(textContentType)
                }
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(Color.white.opacity(0.12))
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .stroke(
                                LinearGradient(
                                    colors: [
                                        Color.white.opacity(0.55),
                                        Color.white.opacity(0.1)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 0.8
                            )
                    )
                    .shadow(color: .black.opacity(0.35), radius: 20, x: 0, y: 18)
            )
        }
    }
}

// MARK: - Preview

struct AppTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
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

            Color.black.opacity(0.3)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                AppTextFieldView(
                    title: "Username",
                    placeholder: "Enter your username",
                    systemImage: "person.fill",
                    isSecure: false,
                    text: .constant("testuser")
                )

                AppTextFieldView(
                    title: "Password",
                    placeholder: "••••••••",
                    systemImage: "key.fill",
                    isSecure: true,
                    text: .constant("")
                )

                AppTextFieldView(
                    title: "Email",
                    placeholder: "Enter your email",
                    systemImage: "envelope.fill",
                    isSecure: false,
                    text: .constant("user@example.com"),
                    keyboardType: .emailAddress,
                    textContentType: .emailAddress
                )
            }
            .padding(24)
        }
        .previewLayout(.sizeThatFits)
    }
}