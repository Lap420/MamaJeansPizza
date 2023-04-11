import Foundation

struct ItemsModel {
    // MARK: - Public properties
    let items: [ItemData]
    let itemsImages: [String: Data]
    
    // MARK: - Init
    init(choosenGroupId: String) {
        var items = [ItemData]()
        var itemsImages = [String: Data]()
        
        MenuManager.shared.menu?.forEach { menuGroup in
            guard menuGroup.id == choosenGroupId else { return }
            menuGroup.items?.forEach { item in
                items.append(ItemData(id: item.itemId,
                                      name: item.name,
                                      description: item.description ?? "",
                                      price: item.itemSizes.first?.prices.first?.price ?? 0.00))
                itemsImages[item.itemId] = MenuManager.shared.menuImages[item.itemId]
            }
        }
        
        self.items = items
        self.itemsImages = itemsImages
    }
}
