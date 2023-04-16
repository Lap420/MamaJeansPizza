import UIKit

class BasketController: UIViewController {
    // MARK: Public methods
    @objc
    func returnForPhoneKeyboard() {
        guard let phoneTextField = basketCustomerInfoCell?.phoneTextField else { return }
        _ = textFieldShouldReturn(phoneTextField)
    }
    
    // MARK: Public properties
    private var items: [BasketCellType] = [
//        .customerData(BasketCustomerInfoCellInfo())
        .customerData
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
    private var choosenPaymentType = PaymentType.cash
    private let phoneRegex = #"^\+?\d{10,13}$"#
}

// MARK: Private methods
private extension BasketController {
    func initialize() {
        view = basketView
        self.title = "Basket"
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        setBasketSubtitle()
        initTableView()
        initButtonTargets()
        addBasketItemsToDataSource()
    }
    
    func setBasketSubtitle() {
        let orderButtonSubtitle = Basket.shared.getItemsAndTotalAmount().amount
        guard var conf = basketView.orderButton.configuration else { return }
        conf.subtitle = orderButtonSubtitle
        basketView.orderButton.configuration = conf
    }
    
    func initTableView() {
        basketView.tableView.register(BasketCustomerInfoCell.self, forCellReuseIdentifier: String(describing: BasketCustomerInfoCell.self))
        basketView.tableView.register(BasketItemCell.self, forCellReuseIdentifier: String(describing: BasketItemCell.self))
        basketView.tableView.dataSource = self
    }
    
    func initButtonTargets() {
        basketView.orderButton.addTarget(
            self,
            action: #selector(orderButtonTapped),
            for: .touchUpInside
        )
    }
    
    func addBasketItemsToDataSource() {
        Basket.shared.items?.forEach({ item in
            items.append(.basketItem)
        })
    }
    
    func checkPhoneIsValid(_ textField: UITextField) {
        let isValidPhoneNumber = textField.text?.range(of: phoneRegex, options: .regularExpression) != nil
        self.isValidPhoneNumber = isValidPhoneNumber
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
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
//        case .customerData(let info):
        case .customerData:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BasketCustomerInfoCell.self), for: indexPath) as! BasketCustomerInfoCell
            basketCustomerInfoCell = cell
//            cell.configure(with: info, viewController: self, defaultPaymentType: choosenPaymentType) { [weak self] action in
            cell.configure(viewController: self, defaultPaymentType: choosenPaymentType) { [weak self] action in
                let choosenPaymentType: PaymentType
                switch action.title {
                case PaymentType.cash.rawValue:
                    choosenPaymentType = PaymentType.cash
                case PaymentType.card.rawValue:
                    choosenPaymentType = PaymentType.card
                case PaymentType.online.rawValue:
                    choosenPaymentType = PaymentType.online
                default:
                    choosenPaymentType = PaymentType.cash
                }
                self?.choosenPaymentType = choosenPaymentType
            }
            checkPhoneIsValid(cell.phoneTextField)
            return cell
        case .basketItem:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BasketItemCell.self), for: indexPath) as! BasketItemCell
            guard let item = Basket.shared.items?[indexPath.row - 1] else { return cell }
            var image: UIImage?
            if let imadeData = MenuManager.shared.menuImages[item.productId] {
                image = UIImage(data: imadeData)
            }
            cell.configure(viewController: self, item: item, image: image)
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
        let isValidPhoneNumber = updatedText.range(of: phoneRegex, options: .regularExpression) != nil
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
