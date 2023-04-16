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
    
    static func textFieldAlert(_ textField: UITextField, message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Oops!",
                                      message: message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay",
                                     style: .default) { _ in
            textField.becomeFirstResponder()
        }
        alert.addAction(okAction)
        return alert
    }
}
