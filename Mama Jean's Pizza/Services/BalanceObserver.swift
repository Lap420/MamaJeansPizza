import Foundation

class BalanceObserver {
    static let shared = BalanceObserver()
    var balance: Int = 0 {
        didSet {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "BalanceUpdated"),
                                            object: nil)
        }
    }
    
    private init() {
        balance = UserDefaults.standard.integer(forKey: "Balance")
    }
    
    func updateBalance(_ balance: Int) {
        self.balance = balance
        UserDefaults.standard.set(balance, forKey: "Balance")
    }
}
