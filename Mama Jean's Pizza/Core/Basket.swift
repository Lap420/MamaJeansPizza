//
//  Basket.swift
//  Mama Jean's Pizza
//
//  Created by Lap on 28.02.2023.
//

import Foundation

struct Basket {
    static var shared = Basket()
    private init() {}
    
    private(set) var items: [BasketItem]?
    
    mutating func addItem(item: BasketItem) {
        if let items = items {
            if let index = items.firstIndex(of: item) {
                self.items![index] = BasketItem(productId: item.productId, amount: item.amount + items[index].amount, price: item.price)
            } else {
                self.items!.append(item)
            }
        } else {
            self.items = [item]
        }
    }
    
    func getTotal() -> String {
        guard let items = items else { return "" }

        var total = 0.0
        items.forEach { item in
            total += item.price * Double(item.amount)
        }
        return String(format: "%.2f", total) + " AED"
    }
    
    mutating func clear() {
        items = nil
    }
}

struct BasketItem: Equatable {
    let productId: String
    let amount: Int
    let price: Double
    
    static func == (lhs: BasketItem, rhs: BasketItem) -> Bool {
        return lhs.productId == rhs.productId
    }
}
