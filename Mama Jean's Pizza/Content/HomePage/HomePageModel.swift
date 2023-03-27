//
//  HomePageModel.swift
//  Mama Jean's Pizza
//
//  Created by Lap on 26.03.2023.
//

//Need to make it UI independent
import UIKit

struct HomePageModel {
    private var deals: [HomePageData] = [HomePageData(name: "1",
                                                      dealDescription: "2",
                                                      image: UIImage(named: "No_Image")!),
                                         HomePageData(name: "1",
                                                      dealDescription: "2",
                                                      image: UIImage(named: "No_Image")!)]
    private var rewards: [HomePageData] = [HomePageData(name: "1",
                                                        dealDescription: "2",
                                                        image: UIImage(named: "No_Image")!),
                                           HomePageData(name: "1",
                                                        dealDescription: "2",
                                                        image: UIImage(named: "No_Image")!),
                                           HomePageData(name: "1",
                                                        dealDescription: "2",
                                                        image: UIImage(named: "No_Image")!)]
    private var points: [HomePageData] = [HomePageData(name: "1",
                                                       dealDescription: "2",
                                                       image: UIImage(named: "No_Image")!),
                                          HomePageData(name: "1",
                                                       dealDescription: "2",
                                                       image: UIImage(named: "No_Image")!),
                                          HomePageData(name: "1",
                                                       dealDescription: "2",
                                                       image: UIImage(named: "No_Image")!),
                                          HomePageData(name: "1",
                                                       dealDescription: "2",
                                                       image: UIImage(named: "No_Image")!)]
}

struct HomePageData {
    let name: String
    let dealDescription: String
    let image: UIImage
}

enum HomepageCollectionType: String {
    case deals = "Deals"
    case rewards = "Rewards"
    case points = "Points"
}
