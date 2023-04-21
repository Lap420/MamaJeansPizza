import Foundation

fileprivate enum SyrveApiType {
    case getToken
    case getMenu
    case createOrder
    
    var baseURLPath: String {
        return "https://api-ru.iiko.services/api/"
    }
    
    var path: String {
        switch self {
        case .getToken:
            return "1/access_token"
        case .getMenu:
            return "2/menu/by_id"
        case .createOrder:
            return "1/deliveries/create1"
        }
    }
    
    var httpMethod: String {
        switch self {
        case .getToken,
                .getMenu,
                .createOrder:
            return "POST"
        }
    }
    
    var header: [String: String] {
        switch self {
        case .getToken:
            return ["Content-Type": "application/json"]
        case .getMenu:
            return ["Content-Type": "application/json"]
        case .createOrder:
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
        case .createOrder:
            return nil
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

class SyrveApiManager {
    static let shared = SyrveApiManager()
    
    private init() {}
    
    func getToken(completion: @escaping (String) -> Void) {
        let request = SyrveApiType.getToken.request
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
    
    func getMenu(completion: @escaping ([ItemCategory]?, String) -> Void) {
        var token = ""
        let group = DispatchGroup()
        group.enter()
        getToken {
            token = $0
            group.leave()
        }
        group.wait()
        var request = SyrveApiType.getMenu.request
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
    
    func getImage(
        url: String,
        completion: @escaping (Data?) -> Void
    ) {
        let task = URLSession.shared.dataTask(
            with: URLRequest(url: URL(string: url)!)) { data, response, error in
            completion(data)
        }
        task.resume()
    }
    
    func prepareOrder(_ basketModel: BasketModel) -> CreateOrderRequestBody {
        let basketItems = Basket.shared.items!
        var total = 0.0
        var items: [OrderItem] = []
        basketItems.forEach { basketItem in
            total += Double(basketItem.amount) + basketItem.price
            items.append(OrderItem(
                productId: basketItem.productId,
                amount: basketItem.amount,
                price: basketItem.price)
            )
        }
        return CreateOrderRequestBody(
            order: Order(
                externalNumber: String(basketModel.orderNumber),
                phone: basketModel.phone,
                deliveryPoint: DeliveryPoint(
                    address: Address(
                        street: Street(),
                        house: basketModel.address,
                        flat: ""
                    )
                ),
                comment: basketModel.comment,
                customer: Customer(
                    name: basketModel.name
                ),
                items: items,
                payments: [Payment(sum: total)]
            )
        )
    }
    
    func createOrder(order: CreateOrderRequestBody, completion: @escaping (String?, String) -> Void) {
        var token = ""
        let group = DispatchGroup()
        group.enter()
        getToken {
            token = $0
            group.leave()
        }
        group.wait()
        var request = SyrveApiType.createOrder.request
        request.allHTTPHeaderFields!["Authorization"] = "bearer \(token)"
        request.httpBody = try? JSONEncoder().encode(order)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else { completion(nil, "Order creation request returned some error!"); return }
            guard let httpResponse = response as? HTTPURLResponse else { completion(nil, "Cannot convert Menu response to HTTPURLResponse!"); return }
            guard httpResponse.statusCode == 200 else { completion(nil, "Order creation request returned code \(httpResponse.statusCode)"); return }
            if let data = data, let createdOrderData = try? JSONDecoder().decode(CreateOrderResponse.self, from: data) {
                let orderId = createdOrderData.orderInfo.id
                completion(orderId, "Order created successfully")
            } else {
                completion(nil, "Order creation response cannot be parsed")
            }
        }
        task.resume()
    }
}
