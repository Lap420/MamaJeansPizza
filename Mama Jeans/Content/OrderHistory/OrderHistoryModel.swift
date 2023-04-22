import CoreData

struct OrderHistoryModel {
    // MARK: - Public properties
    var orders: [PreviousOrder] = []
    
    // MARK: - Public methods
    mutating func loadOrders() {
        let fetchRequest: NSFetchRequest<PreviousOrder> = PreviousOrder.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            orders = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Init
    init(_ context: NSManagedObjectContext) {
        self.context = context
    }
    
    // MARK: - Private properties
    private let context: NSManagedObjectContext
}
