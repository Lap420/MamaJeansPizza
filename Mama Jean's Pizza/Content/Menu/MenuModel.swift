import Foundation

struct MenuModel {
    var menu = [(id: String, name: String)]()
    var menuImages = [String: Data]()
    
    init() {
        MenuManager.shared.menu?.forEach { menuGroup in
            menu.append((menuGroup.id, menuGroup.name))
        }
        
        menu.forEach { (id: String, name: String) in
            menuImages[id] = MenuManager.shared.menuImages[id]
        }
    }
}
