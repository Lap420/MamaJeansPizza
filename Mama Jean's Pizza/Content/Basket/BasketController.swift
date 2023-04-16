import UIKit

class BasketController: UIViewController {
    // MARK: Public methods
    @objc
    func returnForPhoneKeyboard() {
        guard let phoneTextField = basketCustomerInfoCell?.phoneTextField else { return }
        _ = textFieldShouldReturn(phoneTextField)
    }
    
    // MARK: Public properties
    let items: [BasketCellType] = [
        .customerData(BasketCustomerInfoCellInfo())
    ]
    
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // MARK: - Private properties
    private let basketView = BasketView()
    private var basketCustomerInfoCell: BasketCustomerInfoCell?
    private var isValidPhoneNumber = true {
        didSet {
            basketCustomerInfoCell?.invalidPhoneLabel.isHidden = isValidPhoneNumber
        }
    }
}

// MARK: Private methods
private extension BasketController {
    func initialize() {
        view = basketView
        self.title = "Basket"
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        setBasketTitleName()
        initTableView()
        initButtonTargets()
    }
    
    func setBasketTitleName() {
        let orderButtonTitle = "Order " + Basket.shared.getItemsAndTotalAmount().amount
        basketView.orderButton.setTitle(orderButtonTitle, for: .normal)
    }
    
    func initTableView() {
        basketView.tableView.register(BasketCustomerInfoCell.self, forCellReuseIdentifier: String(describing: BasketCustomerInfoCell.self))
        basketView.tableView.dataSource = self
    }
    
    func initButtonTargets() {
        basketView.orderButton.addTarget(
            self,
            action: #selector(orderButtonTapped),
            for: .touchUpInside
        )
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc
    func paymentTypeButtonTapped() {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "PaymentTypesViewController") as! PaymentTypesViewController
//        vc.configure(viewController: self)
//        present(vc, animated: true)
    }
    
    @objc
    func paymentTypeDidChoose(sender: UIButton) {
        if let cell = basketView.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? BasketCustomerInfoCell {
            cell.updatePaymentType(newPaymentType: sender.title(for: .normal) ?? "Click here")
        }
        dismiss(animated: true)
    }
    
    @objc
    func orderButtonTapped() {
        if let textField = basketCustomerInfoCell?.findEmptyTextField(UITextField()) {
            let message: String
            switch textField.tag {
            case 1:
                message = "Required field \"Name\" is empty"
            case 2:
                message = "Required field \"Phone\" is empty"
            case 3:
                message = "Required field \"Address\" is empty"
            default:
                message = "Some required field is empty"
            }
            let alert = AlertManager.textFieldAlert(textField, message: message)
            present(alert, animated: true)
            return
        }
        if !isValidPhoneNumber {
            let message = "The entered phone number is invalid"
            guard let textField = basketCustomerInfoCell?.phoneTextField else { return }
            let alert = AlertManager.textFieldAlert(textField, message: message)
            present(alert, animated: true)
            return
        }
    }
}

extension BasketController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        switch item {
        case .customerData(let info):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BasketCustomerInfoCell.self), for: indexPath) as! BasketCustomerInfoCell
            basketCustomerInfoCell = cell
            cell.configure(with: info, viewController: self)
            return cell
        }
    }
}

extension BasketController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 2 {
            basketCustomerInfoCell?.addNextButtonOnKeyboard(viewController: self)
        }
        let nextEmptyTextField = basketCustomerInfoCell?.findEmptyTextField(textField)
        if nextEmptyTextField != nil {
            textField.returnKeyType = .next
        } else {
            textField.returnKeyType = .done
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard textField.tag == 2 else { return true }
        let currentText = textField.text ?? ""
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        let regex = #"^\+?\d{10,13}$"#
        let isValidPhoneNumber = updatedText.range(of: regex, options: .regularExpression) != nil
        self.isValidPhoneNumber = isValidPhoneNumber
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextEmptyTextField = basketCustomerInfoCell?.findEmptyTextField(textField)
        if let nextEmptyTextField = nextEmptyTextField {
            nextEmptyTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    
}
