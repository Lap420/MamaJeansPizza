import UIKit

class BasketController: UIViewController {
    // MARK: Public properties
    let items: [BasketCellType] = [
        .customerData(BasketCustomerInfoCellInfo())
    ]
    
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            view.addGestureRecognizer(tap)
    }
    
    // MARK: - Private properties
    private var basketView = BasketView()
}

// MARK: Private methods
private extension BasketController {
    func initialize() {
        view = basketView
        let orderButtonTitle = "Order " + Basket.shared.getItemsAndTotalAmount().amount
        basketView.orderButton.setTitle(orderButtonTitle, for: .normal)
        
        basketView.tableView.register(BasketCustomerInfoCell.self, forCellReuseIdentifier: String(describing: BasketCustomerInfoCell.self))
        basketView.tableView.dataSource = self
        //basketView.tableView.delegate = self
        
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
//        performSegue(withIdentifier: "FromBaskerToOrderPlacedSegue", sender: nil)
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
            cell.configure(with: info, viewController: self)
            return cell
        }
    }
}

extension BasketController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
