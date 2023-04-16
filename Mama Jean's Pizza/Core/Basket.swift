struct Basket {
    static var shared = Basket()
    private init() {}
    
    private(set) var items: [BasketItem]?
    
    mutating func addItem(item: BasketItem) {
        if let items = items {
            if let index = items.firstIndex(of: item) {
                self.items![index] = BasketItem(productId: item.productId, name: item.name, amount: item.amount + items[index].amount, price: item.price)
            } else {
                self.items!.append(item)
            }
        } else {
            self.items = [item]
        }
    }
    
    mutating func clear() {
        items = nil
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
}

struct BasketItem: Equatable {
    let productId: String
    let name: String
    let amount: Int
    let price: Double
    
    static func == (lhs: BasketItem, rhs: BasketItem) -> Bool {
        return lhs.productId == rhs.productId
    }
}
