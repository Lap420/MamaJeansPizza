//
//  UserDefaultsManager.swift
//  Mama Jean's Pizza
//
//  Created by Lap on 27.03.2023.
//

import Foundation

struct UserDefaultsManager {
    private static let userDefaults = UserDefaults.standard
    
    static func loadIsFirstLaunch() -> Bool {
        return !userDefaults.bool(forKey: UserDefaultKeys.isFirstLaunch.rawValue)
    }
    
    static func saveIsFirstLaunch() {
        userDefaults.set(true, forKey: UserDefaultKeys.isFirstLaunch.rawValue)
    }
    
    static func saveIntroductionWasSkipped() {
        userDefaults.set(true, forKey: UserDefaultKeys.introductionWasSkipped.rawValue)
    }
}

enum UserDefaultKeys: String {
    case isFirstLaunch
    case introductionWasSkipped
}
