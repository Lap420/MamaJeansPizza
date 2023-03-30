import Foundation

//struct ChooseAStoreModel {
//    let stores: [String: [Store2]] = [
//        "Dubai": [
//            Store2(name: "Dubai Marina", openTime: .time, closingTime: "10:00 pm"),
//            Store2(name: "Dubai Internet City", openTime: "10:00 am", closingTime: "10:00 pm"),
//            Store2(name: "Dubai Investments park", openTime: "10:00 am", closingTime: "10:00 pm"),
//            Store2(name: "Jumairah Lake Towers", openTime: "10:00 am", closingTime: "10:00 pm")
//        ],
//        "Abu-Dhabi": [
//            Store2(name: "Abu-Dhabi Airport", openTime: "10:00 am", closingTime: "10:00 pm"),
//            Store2(name: "Abu-Dhabi F1 Circuit", openTime: "10:00 am", closingTime: "10:00 pm")
//        ]
//    ]
//}
// Прикинуть, в каких состояниях может находиться юзер: стор откроется через эн часов, открыт, открыт но закроется через эн часов и эн минут
struct Store {
    // MARK: - Public properties
    let name: String
    let openTime: String
    let closingTime: String
}

struct Store2 {
    // MARK: - Public properties
    let name: String
    let openTime: Date
    let closingTime: Date
}
