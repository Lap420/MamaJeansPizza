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
    
    static func itemDeletionAlert(message: String, deletionHandler: @escaping (UIAlertAction) -> Void) -> UIAlertController {
        let alert = UIAlertController(title: "Oops!",
                                      message: message,
                                      preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel",
                                     style: .cancel)
        let deleteAction = UIAlertAction(title: "Delete",
                                         style: .destructive,
                                         handler: deletionHandler)
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        return alert
    }
    
    static func emptyBasketAlert(handler: @escaping (UIAlertAction) -> Void) -> UIAlertController {
        let alert = UIAlertController(title: "Oops!",
                                      message: "The basket is empty. You will be redirected back to the menu",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay",
                                     style: .default,
                                     handler: handler)
        alert.addAction(okAction)
        return alert
    }
}
