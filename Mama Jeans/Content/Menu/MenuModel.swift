import Foundation

struct MenuModel {
    // MARK: - Public properties
    let menu: [(id: String, name: String)]
    let menuImages: [String: Data]
    
    // MARK: - Init
    init() {
        var menu = [(id: String, name: String)]()
        var menuImages = [String: Data]()
        
        MenuManager.shared.menu?.forEach { menuGroup in
            menu.append((menuGroup.id, menuGroup.name))
            menuImages[menuGroup.id] = MenuManager.shared.menuImages[menuGroup.id]
        }
        
        self.menu = menu
        self.menuImages = menuImages
    }
}
