import UIKit

// MARK: - Private constants
enum GlobalUIConstants {
    static let screenWidth: CGFloat = UIScreen.main.bounds.width
    static let screenHeight: CGFloat = UIScreen.main.bounds.height

    static let userDefaults = UserDefaults.standard
    
    static let mamaGreenColor: UIColor = .init(named: "AccentColor")!
    
    static let fontSizeHeader: CGFloat = 20
    static let fontBold: UIFont = .systemFont(ofSize: GlobalUIConstants.fontSizeHeader, weight: .bold)
    
    static let basketButtonHeight: CGFloat = 45
}
