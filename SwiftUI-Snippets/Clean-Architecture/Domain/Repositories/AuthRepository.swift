//
//  AuthRepository.swift
//  SwiftUI-Snippets
//
//  Created by Asim on 25/11/2025.
//

import Foundation

protocol AuthRepository {
    func login(username: String, password: String) async throws -> User
}
