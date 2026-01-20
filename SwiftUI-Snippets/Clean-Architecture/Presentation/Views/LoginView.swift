//
//  LoginView.swift
//  SwiftUI-Snippets
//
//  Created by Asim on 25/11/2025.
//

import SwiftUI

struct LoginView: View {

    @StateObject private var vm = LoginViewModel(
        loginUseCase: LoginUseCase(
            repository: AuthRepositoryImpl()
        )
    )

    var body: some View {
        VStack(spacing: 20) {

            Text("Basic Authentication")
                .font(.title.bold())

            TextField("Username", text: $vm.username)
                .textFieldStyle(.roundedBorder)

            SecureField("Password", text: $vm.password)
                .textFieldStyle(.roundedBorder)

            if vm.isLoading {
                ProgressView()
            }

            Button("Login") {
                Task { await vm.login() }
            }
            .buttonStyle(.borderedProminent)

            if let error = vm.errorMessage {
                Text(error)
                    .foregroundColor(.red)
            }

            if let user = vm.loggedInUser {
                Text("Welcome, \(user.name)")
                    .foregroundColor(.green)
            }
        }
        .padding()
    }
}
