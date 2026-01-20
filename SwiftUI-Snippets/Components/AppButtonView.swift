//
//  AppButtonView.swift
//  SwiftUI-Snippets
//
//  A reusable, glassmorphism-friendly button for the app.
//

import SwiftUI

struct AppButtonView: View {
    enum Style {
        case primary
        case secondary
    }

    let title: String
    let systemImage: String?
    let isLoading: Bool
    let style: Style
    let action: () -> Void

    init(
        title: String,
        systemImage: String? = nil,
        isLoading: Bool = false,
        style: Style = .primary,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.systemImage = systemImage
        self.isLoading = isLoading
        self.style = style
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                if isLoading {
                    ProgressView()
                        .tint(.white)
                } else if let systemImage {
                    Image(systemName: systemImage)
                        .font(.system(size: 18, weight: .semibold))
                }

                Text(isLoading ? "Please wait..." : title)
                    .font(.headline)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .foregroundColor(.white)
            .background(backgroundView)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.8),
                                Color.cyan.opacity(0.5),
                                Color.white.opacity(0.3)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            )
            .shadow(color: Color.black.opacity(0.5), radius: 25, x: 0, y: 18)
            .shadow(color: Color(red: 0.0, green: 0.8, blue: 0.4).opacity(0.2), radius: 15, x: 0, y: 8)
        }
        .buttonStyle(.plain)
        .disabled(isLoading)
        .opacity(isLoading ? 0.85 : 1)
    }

    @ViewBuilder
    private var backgroundView: some View {
        switch style {
        case .primary:
            LinearGradient(
                colors: [
                    Color(red: 0.3, green: 0.8, blue: 1.0),     // Bright cyan
                    Color(red: 0.2, green: 0.6, blue: 1.0),     // Vibrant blue
                    Color(red: 0.4, green: 0.7, blue: 1.0)      // Medium cyan-blue
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .secondary:
            LinearGradient(
                colors: [
                    Color.white.opacity(0.25),
                    Color.white.opacity(0.08),
                    Color.white.opacity(0.15)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
                .background(.ultraThinMaterial)
        }
    }
}

// MARK: - Preview

struct AppButtonView_Previews: PreviewProvider {
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
                AppButtonView(
                    title: "Primary Button",
                    systemImage: "arrow.right.circle.fill",
                    isLoading: false,
                    style: .primary,
                    action: {}
                )

                AppButtonView(
                    title: "Loading",
                    systemImage: "arrow.right.circle.fill",
                    isLoading: true,
                    style: .primary,
                    action: {}
                )

                AppButtonView(
                    title: "Secondary Button",
                    systemImage: "slider.horizontal.3",
                    isLoading: false,
                    style: .secondary,
                    action: {}
                )
            }
            .padding(24)
        }
        .previewLayout(.sizeThatFits)
    }
}

