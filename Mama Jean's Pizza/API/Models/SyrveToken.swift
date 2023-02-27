//
//  SyrveToken.swift
//  Mama Jean's Pizza
//
//  Created by Lap on 26.02.2023.
//

import Foundation

// MARK: - TokenRequestBody
struct TokenRequestBody: Codable {
    let apiLogin: String
}

// MARK: - TokenResponse
struct TokenResponse: Codable {
    let token: String?
    let errorDescription: String?
}
