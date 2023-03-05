//
//  BasketViewController.swift
//  Mama Jean's Pizza
//
//  Created by Lap on 01.03.2023.
//

import UIKit

class BasketViewController: UIViewController {
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var orderButton: UIButton!
    
    var tableView = UITableView()
    
    let items: [BasketCellType] = [
        .customerData(BasketCustomerInfoCellInfo())
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            view.addGestureRecognizer(tap)
    }
    
    private func initialize() {
        let orderButtonTitle = "Order " + Basket.shared.getTotal()
        orderButton.setTitle(orderButtonTitle, for: .normal)
        
        tableView.dataSource = self
        tableView.register(BasketCustomerInfoCell.self, forCellReuseIdentifier: String(describing: BasketCustomerInfoCell.self))
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top)
        }
        tableView.backgroundColor = .lightGray
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func paymentTypeButtonTapped() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PaymentTypesViewController") as! PaymentTypesViewController
        vc.configure(viewController: self)
        present(vc, animated: true)
    }
    
    @objc func paymentTypeDidChoose(sender: UIButton) {
        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? BasketCustomerInfoCell {
            cell.updatePaymentType(newPaymentType: sender.title(for: .normal) ?? "Click here")
        }
        dismiss(animated: true)
    }
    
    @IBAction func orderButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "FromBaskerToOrderPlacedSegue", sender: nil)
    }
}

extension BasketViewController: UITableViewDataSource {
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

extension BasketViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
