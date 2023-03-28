import UIKit

struct HomePageModel {
    // MARK: - Public properties
    var deals: [HomePageData] = .init(repeating: commonData, count: 2)
    var rewards: [HomePageData] = .init(repeating: commonData, count: 3)
    var points: [HomePageData] = .init(repeating: commonData, count: 4)
    
    // MARK: - Private properties
    private static let commonData = HomePageData(name: "name",
                                          description: "description",
                                                 imageData: nil)
}

struct HomePageData {
    // MARK: - Private properties
    let name: String
    let description: String
    let imageData: Data?
}

enum HomepageCollectionType: String {
    case deals = "Deals"
    case rewards = "Rewards"
    case points = "Points"
}
