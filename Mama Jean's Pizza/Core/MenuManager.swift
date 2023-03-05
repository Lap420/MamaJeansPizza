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
    private(set) var menuImages: [String: UIImage] = [:]
    
    private init() {
        let menu = downloadMenu()
        self.menu = menu
        self.menuImages = downloadImages(menu: menu)
    }
    
    private func downloadMenu() -> Menu {
        var wholeMenu: Menu = []
        let group = DispatchGroup()
        group.enter()
        SyrveApiManager.shared.getMenu { menu, error in
            wholeMenu = convertSyrveMenuToAppMenu(apiMenu: menu)
            group.leave()
        }
        group.wait()
        return wholeMenu
    }
    
    private func convertSyrveMenuToAppMenu(apiMenu: [ItemCategory]?) -> Menu {
        guard let apiMenu = apiMenu else { return nil }
        
        var resultMenu = [MenuItemCategory]()
        apiMenu.forEach { group in
            var items = [MenuItem]()
            group.items?.forEach { item in
                var sizes = [MenuItemSize]()
                item.itemSizes.forEach { size in
                    var prices = [MenuPrice]()
                    size.prices.forEach { price in
                        prices.append(MenuPrice(organizationId: price.organizationId,
                                                price: price.price))
                    }
                    sizes.append(MenuItemSize(sizeCode: size.sizeCode,
                                              sizeName: size.sizeName,
                                              sizeId: size.sizeId,
                                              prices: prices,
                                              buttonImageUrl: size.buttonImageUrl))
                }
                items.append(MenuItem(sku: item.sku,
                                      name: item.name,
                                      description:item.description,
                                      itemSizes: sizes,
                                      itemId: item.itemId))
            }
            resultMenu.append(MenuItemCategory(id: group.id,
                                               name: group.name,
                                               buttonImageUrl: group.buttonImageUrl,
                                               items: items))
        }
        
        return resultMenu
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

struct MenuItemCategory {
    let id: String
    let name: String
    let buttonImageUrl: String?
    let items: [MenuItem]?
}

struct MenuItem {
    let sku: String
    let name: String
    let description: String?
    let itemSizes: [MenuItemSize]
    let itemId: String
}

struct MenuItemSize {
    let sizeCode: String?
    let sizeName: String?
    let sizeId: String?
    let prices: [MenuPrice]
    let buttonImageUrl: String
}

struct MenuPrice{
    let organizationId: String
    let price: Double
}

typealias Menu = [MenuItemCategory]?
