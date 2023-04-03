import Foundation

class BalanceObserver {
    static let shared = BalanceObserver()

    private init() { }
    
    func updateBalance(_ newBalance: Int) {
        UserDefaultsManager.saveBalance(newBalance)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "BalanceUpdated"),
                                        object: nil)
    }
}
