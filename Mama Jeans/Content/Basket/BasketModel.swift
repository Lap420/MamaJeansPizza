import Foundation

enum BasketCellType {
    case customerData
    case basketItem
}

enum PaymentType: String {
    case cash = "Cash on Delivery"
    case card = "Card on Delivery"
    case online = "Pay online"
}

struct BasketModel {
    var name = ""
    var phone = ""
    var address = ""
    var comment = ""
    var orderNumber = Int.random(in: 1...10000)
}

struct CreatedOrder {
    let id: String
    let orderDate: Date
    let basket: Basket
}
