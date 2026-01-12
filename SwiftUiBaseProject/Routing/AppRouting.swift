//
//  AppRouting.swift
//  SwiftUiBaseProject
//
//  Created by Asim on 05/03/2025.
//

import SwiftUI

final class AppRouting: ObservableObject {
    
    // MARK: PROPERTIES
    @Published var navPath = NavigationPath()
    @Published var routeFlow: RouteFlow = .authModule
    private var stack: [AuthFlow] = []  // Maintain a manual stack of destinations
    
    // MARK: AuthFlow Enum
    enum AuthFlow: Hashable {
        case login
        case signUp(name: String)
        case profile
        case forgotPassword
        case emailSent
    }
    
    enum RouteFlow {
        
        case authModule
        case dashboard
    }
    
    // MARK: Navigation Methods
    
    // MARK: navigate
    func navigate(to destination: AuthFlow) {
        stack.append(destination)
        navPath.append(destination)
    }
    
    
    // MARK: navigateBack
    func navigateBack() {
        guard !stack.isEmpty else { return }
        stack.removeLast()
        navPath.removeLast()
    }
    
    // MARK: navigateToRoot
    func navigateToRoot() {
        stack.removeAll()
        navPath.removeLast(navPath.count)
    }
    
    
    // MARK: navigateBack
    // Navigate back D to B e-g --> navigateBack(to: .B)
    func navigateBack(to destination: AuthFlow) {
        while !stack.isEmpty {
            if let last = stack.last, last == destination {
                break
            }
            stack.removeLast()
            navPath.removeLast()
        }
    }
    
    // MARK: setRoute
    func setRoute(_ route: RouteFlow) {
        
        self.routeFlow = route
        navigateToRoot()
    }
}


