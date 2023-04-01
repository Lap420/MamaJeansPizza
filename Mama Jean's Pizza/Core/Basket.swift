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
    
    func getTotalItemsString() -> String {
        guard let items = items else { return "0 items" }
        let totalString = items.count == 1 ? "1 item" : "\(items.count) items"
        return totalString
    }
    
    func getTotalAmountString() -> String {
        guard let items = items else { return "0.00 AED" }
        var total = 0.0
        items.forEach { item in
            total += item.price * Double(item.amount)
        }
        return String(format: "%.2f", total) + " AED"
    }
    
    func getItemsAndTotalAmount() -> (items: String, amount: String) {
        guard let items = items else { return ("0 items" ,"0.00 AED") }
        var totalItems = 0
        var totalAmount = 0.0
        items.forEach { item in
            totalItems += item.amount
            totalAmount += item.price * Double(item.amount)
        }
        let totalItemsString = totalItems == 1 ? "1 item" : "\(totalItems) items"
        let totalAmountString = String(format: "%.2f", totalAmount) + " AED"
        return (totalItemsString, totalAmountString)
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
