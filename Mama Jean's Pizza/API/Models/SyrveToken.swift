// MARK: - TokenRequestBody
struct TokenRequestBody: Codable {
    let apiLogin: String
}

// MARK: - TokenResponse
struct TokenResponse: Codable {
    let token: String?
    let errorDescription: String?
}
