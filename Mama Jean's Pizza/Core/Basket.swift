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
    
    private(set) var items: [OrderItem]?
    
    mutating func addItem(item: OrderItem) {
        if let items = items {
            if let index = items.firstIndex(of: item) {
                self.items![index] = OrderItem(productId: item.productId, amount: item.amount + items[index].amount, price: item.price)
            } else {
                self.items!.append(item)
            }
        } else {
            self.items = [item]
        }
    }
}
