//
//  SwiftUiBaseProjectApp.swift
//  SwiftUiBaseProject
//
//  Created by Asim on 05/03/2025.
//

import SwiftUI

@main
struct SwiftUiBaseProjectApp: App {
    
    // MARK: PROPERTIES
    @StateObject private var authViewModel = AuthViewModel()
    @ObservedObject private var router = AppRouting()
    
    
    // MARK: body
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                
                if router.routeFlow == .authModule {
                    ContentView()
                        .navigationDestination(for: AppRouting.AuthFlow.self) { destination in
                            router.authDestination(for: destination) // Use the function to get the view

                        }
                } else {
                    Text("Dashboard")
                }
                
            }
            .environmentObject(authViewModel)
            .environmentObject(router)
        }
    }
}
