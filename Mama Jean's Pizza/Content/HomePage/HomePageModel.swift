//
//  HomePageModel.swift
//  Mama Jean's Pizza
//
//  Created by Lap on 26.03.2023.
//

//Need to make it UI independent
import UIKit

struct HomepageData {
    let name: String
    let dealDescription: String
    let image: UIImage
}

enum HomepageCollectionType: String {
    case deals = "Deals"
    case rewards = "Rewards"
    case points = "Points"
}
