import Foundation

struct MenuModel {
    let menu: [(id: String, name: String)]
    let menuImages: [String: Data]
    
    init() {
        var menu = [(id: String, name: String)]()
        var menuImages = [String: Data]()
        
        MenuManager.shared.menu?.forEach { menuGroup in
            menu.append((menuGroup.id, menuGroup.name))
        }
        
        menu.forEach { (id: String, name: String) in
            menuImages[id] = MenuManager.shared.menuImages[id]
        }
        
        self.menu = menu
        self.menuImages = menuImages
    }
}
