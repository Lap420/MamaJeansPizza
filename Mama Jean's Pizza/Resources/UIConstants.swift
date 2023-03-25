//
//  UIConstants.swift
//  Mama Jean's Pizza
//
//  Created by Lap on 23.03.2023.
//

import UIKit

// MARK: - Private constants
enum UIConstants {
    static var statusBarHeigh: CGFloat = 0
    
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    static let mamaGreenColor = UIColor(red: 14/255, green: 120/255, blue: 83/255, alpha: 1)
    static let mamaRedColor = UIColor(red: 253/255, green: 42/255, blue: 41/255, alpha: 1)
    
    static let fontSizeHeader: CGFloat = 20
    static let fontBold = UIFont.systemFont(ofSize: UIConstants.fontSizeHeader, weight: .bold)
}
