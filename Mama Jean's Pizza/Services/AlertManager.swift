import UIKit

struct AlertManager {
    static func featureIsNotImplementedAlert(feature: String) -> UIAlertController {
        let alert = UIAlertController(title: "Oops!",
                                      message: "The feature \"\(feature)\" is not implemented yet",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay",
                                     style: .default)
        alert.addAction(okAction)
        return alert
    }
}
