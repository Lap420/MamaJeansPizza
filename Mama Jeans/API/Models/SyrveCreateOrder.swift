// MARK: - CreateOrder Request
struct CreateOrderRequestBody: Codable {
    var organizationId: String = SyrveAPIConstants.organizationId
    let order: Order
}

struct Order: Codable {
    let externalNumber: String
    let phone: String
    var orderTypeId: String = SyrveAPIConstants.orderTypeId
    let deliveryPoint: DeliveryPoint
    let comment: String
    let customer: Customer
    let items: [OrderItem]
    let payments: [Payment]
    var sourceKey: String = SyrveAPIConstants.sourceKey
}

struct DeliveryPoint: Codable {
    let address: Address
}

struct Customer: Codable {
    let name: String
    var type: String = SyrveAPIConstants.customerType
}

struct Address: Codable {
    let street: Street
    let house: String
    let flat: String
}

struct Street: Codable {
    var name: String = SyrveAPIConstants.street
    var city: String = SyrveAPIConstants.city
}

struct OrderItem: Codable {
    var type: String = SyrveAPIConstants.orderItemType
    let productId: String
    let amount: Int
    let price: Double
}

struct Payment: Codable {
    var paymentTypeKind: String = SyrveAPIConstants.paymentTypeKind
    let sum: Double
    var paymentTypeId: String = SyrveAPIConstants.paymentTypeId
    var isProcessedExternally: Bool = false
}

// MARK: - CreateOrder Response
struct CreateOrderResponse: Codable {
    let correlationId: String
    let orderInfo: OrderInfo
}

struct OrderInfo: Codable {
    let id: String
}
