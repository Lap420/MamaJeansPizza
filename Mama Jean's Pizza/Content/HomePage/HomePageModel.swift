//
//  HomePageModel.swift
//  Mama Jean's Pizza
//
//  Created by Lap on 26.03.2023.
//

//Need to make it UI independent
import UIKit

struct HomePageModel {
    // MARK: - Private properties
    var deals: [HomePageData] = .init(repeating: commonData, count: 2)
    var rewards: [HomePageData] = .init(repeating: commonData, count: 3)
    var points: [HomePageData] = .init(repeating: commonData, count: 4)
    
    // MARK: - Private properties
    private static let commonData = HomePageData(name: "name",
                                          description: "description",
                                          imageData: UIImage(named: "No_Image")!)
}

struct HomePageData {
    // MARK: - Private properties
    let name: String
    let description: String
    let imageData: UIImage
}

enum HomepageCollectionType: String {
    case deals = "Deals"
    case rewards = "Rewards"
    case points = "Points"
}
