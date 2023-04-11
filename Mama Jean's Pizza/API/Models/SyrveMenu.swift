// MARK: - MenuRequestBody
struct MenuRequestBody: Codable {
    let externalMenuId: String
    let organizationIds: [String]
}

// MARK: - MenuResponse
struct MenuResponse: Codable {
    let id: Int
    let name: String?
    let itemCategories: [ItemCategory]?
}

struct ItemCategory: Codable {
    let id: String
    let name: String
    let buttonImageUrl: String?
    let items: [Item]?
}

struct Item: Codable {
    let sku: String
    let name: String
    let description: String?
    let itemSizes: [ItemSize]
    let itemId: String
}

struct ItemSize: Codable {
    let sizeCode: String?
    let sizeName: String?
    let sizeId: String?
    let prices: [Price]
    let buttonImageUrl: String
}

struct Price: Codable {
    let organizationId: String
    let price: Double
}
