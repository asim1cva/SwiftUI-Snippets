//
//  SignUpView.swift
//  SwiftUiBaseProject
//
//  Created by Asim on 05/03/2025.
//

import SwiftUI

struct SignUpView: View {
    
    // MARK: PROPERTIES
    
    var name: String = ""
    // MARK: BODY
    
    var body: some View {
        Text("\(name) is here")
    }
}

#Preview {
    SignUpView()
}
