//
//  Models.swift
//  Movie
//
//  Created by Олеся Лыжина on 07.11.2025.
//

import Foundation

struct RegisterRequest: Encodable {
    let login: String
    let email: String
    let name: String
    let password: String
    let confirmPassword: String
    let birthDate: String
    let gender: String
}

struct LoginRequest: Encodable {
    let login: String
    let password: String
}

struct AuthResponse: Decodable {
    let token: String
}

struct LoginResponse: Decodable {
    let token: String
}

struct RegistrationResponse: Decodable {
    let token: String
}
