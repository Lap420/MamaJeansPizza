//
//  GlobalData.swift
//  Mama Jean's Pizza
//
//  Created by Lap on 13.02.2023.
//

import Foundation
import UIKit

// TODO: UIColor(hue: 159/359, saturation: 0.88, brightness: 0.47, alpha: 1)
// TODO: UserDefaults

struct MenuManager {
    static let shared = MenuManager()
    private(set) var menu: Menu = []
    private(set) var menuImages = [String: UIImage]()
    
    private init() {
        let menu = downloadMenu()
        self.menu = menu
        self.menuImages = downloadImages(menu: menu)
    }
    
    private func downloadMenu() -> Menu {
        var wholeMenu: Menu = nil
        let group = DispatchGroup()
        group.enter()
        SyrveApiManager.shared.getMenu { menu, error in
            wholeMenu = menu
            group.leave()
        }
        group.wait()
        return wholeMenu
    }
    
    private func downloadImages(menu: Menu) -> [String: UIImage] {
        var images = [String: UIImage]()
        
        let group = DispatchGroup()
        menu?.forEach { menuGroup in
            if let imageUrl = menuGroup.buttonImageUrl {
                group.enter()
                SyrveApiManager.shared.getImage(url: imageUrl) { image in
                    if let image = image {
                        images[menuGroup.id] = image
                    } else {
                        images[menuGroup.id] = UIImage(named: "No_Image")!
                    }
                    group.leave()
                }
            } else {
                images[menuGroup.id] = UIImage(named: "No_Image")!
            }
            
            menuGroup.items?.forEach({ item in
                if let imageUrl = item.itemSizes.first?.buttonImageUrl {
                    group.enter()
                    SyrveApiManager.shared.getImage(url: imageUrl) { image in
                        if let image = image {
                            images[item.itemId] = image
                        } else {
                            images[item.itemId] = UIImage(named: "No_Image")!
                        }
                        group.leave()
                    }
                } else {
                    images[item.itemId] = UIImage(named: "No_Image")!
                }
            })
        }
        
        group.wait()
        return images
    }
}
