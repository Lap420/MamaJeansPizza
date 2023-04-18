import Foundation

struct UserDefaultsManager {
    // MARK: - Private properties
    private static let userDefaults = UserDefaults.standard
    private enum UserDefaultKeys: String {
        case isFirstLaunch
        case introSkipped
        case balance
        case introFinished
    }
    
    // MARK: - Static methods
    static func loadIsFirstLaunch() -> Bool {
        return !userDefaults.bool(forKey: UserDefaultKeys.isFirstLaunch.rawValue)
    }
    
    static func saveIsFirstLaunch() {
        userDefaults.set(true, forKey: UserDefaultKeys.isFirstLaunch.rawValue)
    }
    
    static func saveIntroSkipped() {
        userDefaults.set(true, forKey: UserDefaultKeys.introSkipped.rawValue)
    }
    
    static func loadIntroFinished() -> Bool {
        return userDefaults.bool(forKey: UserDefaultKeys.introFinished.rawValue)
    }
    
    static func saveIntroFinished() {
        userDefaults.set(true, forKey: UserDefaultKeys.introFinished.rawValue)
    }
    
    static func loadBalance() -> Int {
        return userDefaults.integer(forKey: UserDefaultKeys.balance.rawValue)
    }
    
    static func saveBalance(_ newBalance: Int) {
        userDefaults.set(newBalance, forKey: UserDefaultKeys.balance.rawValue)
    }
}
