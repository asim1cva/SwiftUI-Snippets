//
//  LoginView.swift
//  SwiftUiBaseProject
//
//  Created by Asim on 05/03/2025.
//

import SwiftUI

struct LoginView: View {
    
    // MARK: PROPERTIES
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var appRouting: AppRouting
    
    
    // MARK: BODY
    var body: some View {
        Text("LoginView")
        
        Button {
            
            appRouting.navigate(to: .signUp(name: "Asim"))
        } label: {
            Text("SignUp")
        }

        
    }
}

#Preview {
    LoginView()
}
