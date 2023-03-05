//
//  SyrveCreateOrder.swift
//  Mama Jean's Pizza
//
//  Created by Lap on 28.02.2023.
//

import Foundation

// MARK: - CreateOrder Request
struct CreateOrder: Codable {
    var organizationId: String = SyrveAPIConstants.organizationId
    let order: Order
}

struct Order: Codable {
    let externalNumber: String
    let phone: String
    var orderTypeId: String = SyrveAPIConstants.orderTypeId
    let deliveryPoint: DeliveryPoint
    let comment: String
    let items: [OrderItem]
    let payments: [Payment]
    let sourceKey: String
}

struct DeliveryPoint: Codable {
    let address: Address
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
    var comment: String = ""
}

struct Payment: Codable {
    var paymentTypeKind: String = SyrveAPIConstants.paymentTypeKind
    let sum: Int
    var paymentTypeId: String = SyrveAPIConstants.paymentTypeId
    var isProcessedExternally: Bool = false
}
