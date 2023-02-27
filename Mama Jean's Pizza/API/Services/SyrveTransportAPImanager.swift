//
//  SyrveAPI.swift
//  Mama Jean's Pizza
//
//  Created by Lap on 26.02.2023.
//

import Foundation

fileprivate enum ApiType {
    case getToken
    case getMenu
    
    var baseURLPath: String {
        return "https://api-ru.iiko.services/api/"
    }
    
    var path: String {
        switch self {
        case .getToken:
            return "1/access_token"
        case .getMenu:
            return "2/menu/by_id"
        }
    }
    
    var httpMethod: String {
        switch self {
        case .getToken:
            return "POST"
        case .getMenu:
            return "POST"
        }
    }
    
    var header: [String: String] {
        switch self {
        case .getToken:
            return ["Content-Type": "application/json"]
        case .getMenu:
            return ["Content-Type": "application/json"]
        }
        
    }
    
    var body: Data? {
        switch self {
        case .getToken:
            let body = TokenRequestBody(apiLogin: SyrveAPIConstants.apiLogin)
            return try? JSONEncoder().encode(body)
        case .getMenu:
            let body = MenuRequestBody(externalMenuId: SyrveAPIConstants.externalMenuId, organizationIds: SyrveAPIConstants.organizationIds)
            return try? JSONEncoder().encode(body)
        }
    }
    
    var request: URLRequest {
        let url = URL(string: path, relativeTo: URL(string: baseURLPath))!
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.allHTTPHeaderFields = header
        request.httpBody = body
        return request
    }
}

class ApiManager {
    static let shared = ApiManager()
    
    private init() {}
    
    func getToken(completion: @escaping (String) -> Void) {
        let request = ApiType.getToken.request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else { completion("Token request returned some error!"); return }
            guard let httpResponse = response as? HTTPURLResponse else { completion("Cannot convert Token response to HTTPURLResponse!"); return }
            if let data = data, let tokenData = try? JSONDecoder().decode(TokenResponse.self, from: data) {
                if let token = tokenData.token {
                    completion(token)
                } else {
                    completion("Response returned with code \(httpResponse.statusCode)\nError: \(tokenData.errorDescription ?? "")")
                }
            } else {
                completion("Response returned with code \(httpResponse.statusCode)")
            }
        }
        task.resume()
    }
    
    func getMenu(completion: @escaping (Menu, String) -> Void) {
        var token = ""
        let group = DispatchGroup()
        group.enter()
        getToken {
            token = $0
            group.leave()
        }
        group.wait()
        var request = ApiType.getMenu.request
        request.allHTTPHeaderFields!["Authorization"] = "bearer \(token)"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else { completion(nil, "Menu request returned some error!"); return }
            guard let httpResponse = response as? HTTPURLResponse else { completion(nil, "Cannot convert Menu response to HTTPURLResponse!"); return }
            guard httpResponse.statusCode == 200 else { completion(nil, "Menu request returned code \(httpResponse.statusCode)"); return }
            if let data = data, let menuData = try? JSONDecoder().decode(MenuResponse.self, from: data) {
                if let menuFolders = menuData.itemCategories {
                    completion(menuFolders, "")
                } else {
                    completion(nil, "Menu is empty")
                }
            } else {
                completion(nil, "Menu response cannot be parsed")
            }
        }
        task.resume()
    }
}
