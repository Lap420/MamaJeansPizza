import UIKit

class BasketController: UIViewController {
    // MARK: Public methods
    @objc
    func returnForPhoneKeyboard() {
        guard let phoneTextField = basketCustomerInfoCell?.phoneTextField else { return }
        _ = textFieldShouldReturn(phoneTextField)
    }
    
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
    private lazy var basketModel = BasketModel()
    private lazy var basketView = BasketView()
    private var basketCustomerInfoCell: BasketCustomerInfoCell?
    private var items: [BasketCellType] = [
        .customerData
    ]
    private var isValidPhoneNumber = true {
        didSet {
            basketCustomerInfoCell?.invalidPhoneLabel.isHidden = isValidPhoneNumber
        }
    }
    private var choosenPaymentType = PaymentType.cash
    private let phoneRegex = #"^\+?\d{11,13}$"#
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
        guard Basket.shared.items?.count != 0 else {
            let alert = AlertManager.emptyBasketAlert() {_ in
                self.navigationController?.popViewController(animated: true)
            }
            present(alert, animated: true)
            return
        }
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
    
    func saveOrderToHistory() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let order = PreviousOrder(context: context)
        order.date = Date()
        order.items = try? JSONEncoder().encode(Basket.shared)
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
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
        
        saveOrderToHistory()
        
        var conf = basketView.orderButton.configuration
        conf?.title = "Checking out..."
        conf?.showsActivityIndicator = true
        basketView.orderButton.configuration = conf
        basketView.orderButton.isEnabled = false
        let order = SyrveApiManager.shared.prepareOrder(basketModel)
        SyrveApiManager.shared.createOrder(order: order) { [weak self] orderId, errorMessage in
            DispatchQueue.main.async {
                var conf = self?.basketView.orderButton.configuration
                conf?.showsActivityIndicator = false
                self?.basketView.orderButton.configuration = conf
                let nextVC = OrderPlacedController()
                nextVC.isSuccess = orderId != nil
                nextVC.navController = self?.navigationController
                nextVC.modalPresentationStyle = .overCurrentContext
                nextVC.modalTransitionStyle = .crossDissolve
                self?.present(nextVC, animated: true)
            }
            Basket.shared.clear()
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
        case .customerData:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BasketCustomerInfoCell.self), for: indexPath) as! BasketCustomerInfoCell
            basketCustomerInfoCell = cell
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
            cell.delegate = self
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
        let currentText = textField.text ?? ""
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        switch textField.tag {
        case 1:
            basketModel.name = updatedText
        case 2:
            basketModel.phone = updatedText
        case 3:
            basketModel.address = updatedText
        case 4:
            basketModel.comment = updatedText
        default:
            break
        }
        guard textField.tag == 2 else { return true }
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

extension BasketController: BasketItemCellDelegate {
    func basketItemCellDidDecreaseQuantity(_ cell: BasketItemCell) {
        guard let item = cell.item else { return }
        guard let index = Basket.shared.getItemIndex(item) else { return }
        guard Basket.shared.items![index].amount > 1 else { return }
        Basket.shared.updateItemAmount(item)
        setBasketSubtitle()
        cell.itemQtyChanged()
    }
    
    func basketItemCellDidIncreaseQuantity(_ cell: BasketItemCell) {
        guard let item = cell.item else { return }
        Basket.shared.updateItemAmount(item)
        setBasketSubtitle()
        cell.itemQtyChanged()
    }
    
    func basketItemCellDidDelete(_ cell: BasketItemCell) {
        guard let item = cell.item else { return }
        let message = "Are you sure you want to delete \"\(item.name)\" from the order?"
        let alert = AlertManager.itemDeletionAlert(message: message) { [self] _ in
            Basket.shared.deleteItem(item)
            items.removeLast()
            guard let indexPath = basketView.tableView.indexPath(for: cell) else { return }
            basketView.tableView.beginUpdates()
            basketView.tableView.deleteRows(at: [indexPath], with: .automatic)
            basketView.tableView.endUpdates()
            setBasketSubtitle()
        }
        present(alert, animated: true)
    }
}
