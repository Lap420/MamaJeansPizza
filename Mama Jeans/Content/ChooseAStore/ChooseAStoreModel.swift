import Foundation

struct ChooseAStoreModel {
    // MARK: - Public properties
    let cities = ["Dubai", "Abu-Dhabi"]
    let stores = [
        "Dubai": [
            Store(name: "Dubai Marina", openTime: "12:00 am", closeTime: "6:00 am"),
            Store(name: "Dubai Internet City", openTime: "6:00 am", closeTime: "12:00 pm"),
            Store(name: "Dubai Investments park", openTime: "12:00 pm", closeTime: "6:00 pm"),
            Store(name: "Jumairah Lake Towers", openTime: "6:00 pm", closeTime: "11:59 pm")
        ],
        "Abu-Dhabi": [
            Store(name: "Abu-Dhabi Airport", openTime: "10:00 am", closeTime: "10:00 pm"),
            Store(name: "Abu-Dhabi F1 Circuit", openTime: "10:00 am", closeTime: "10:00 pm")
        ]
    ]
}
struct Store {
    // MARK: - Public properties
    let name: String
    let openTime: String
    let closeTime: String
}
