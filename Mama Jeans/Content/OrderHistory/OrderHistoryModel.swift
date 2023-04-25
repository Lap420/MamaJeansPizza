import CoreData

struct OrderHistoryModel {
    // MARK: - Public properties
    var orders: [PreviousOrder] = []
    
    // MARK: - Public methods
    mutating func loadOrders() {
        let fetchRequest: NSFetchRequest<PreviousOrder> = PreviousOrder.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            orders = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func getOrderDate(index: Int) -> String {
        var dateText = ""
        guard let date = orders[index].date else { return dateText }
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            return formatter
        }()
        dateText = dateFormatter.string(from: date)
        return dateText
    }
    
    func getOrderItemsString(index: Int) -> String {
        var itemList = ""
        guard let orderData = orders[index].items else { return itemList }
        guard let orderItems = try? JSONDecoder().decode(Basket.self, from: orderData) else { return itemList }
        guard let items = orderItems.items else { return itemList }
        items.forEach { item in
            itemList += "\n\(item.name) x\(item.amount)"
        }
        return itemList
    }
    
    func addItemsToBasket(index: Int) {
        Basket.shared.clear()
        guard let orderData = orders[index].items else { return }
        guard let orderItems = try? JSONDecoder().decode(Basket.self, from: orderData) else { return }
        orderItems.items?.forEach({ item in
            Basket.shared.addItem(item)
        })
    }
    
    // MARK: - Init
    init(_ context: NSManagedObjectContext) {
        self.context = context
    }
    
    // MARK: - Private properties
    private let context: NSManagedObjectContext
}
