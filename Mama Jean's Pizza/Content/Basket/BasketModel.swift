enum BasketCellType {
    case customerData(BasketCustomerInfoCellInfo)
//    case basketItem
}

struct BasketCustomerInfoCellInfo {
    let name = "Sergei"
    let phone = "+971123456789"
}

enum PaymentType: String {
    case cash = "Cash on Delivery"
    case card = "Card on Delivery"
    case online = "Pay online"
}
