//
//  ContentView.swift
//  SwiftUiBaseProject
//
//  Created by Asim on 05/03/2025.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: PROPERTIES
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    
    // MARK: BODY
    var body: some View {
        Group {
            
            LoginView()
//            if authViewModel.userSession == nil {
//                LoginView()
//            } else {
//                ProfileView()
//            }
        }
        .environmentObject(authViewModel)
    }
}

#Preview {
    ContentView()
}
