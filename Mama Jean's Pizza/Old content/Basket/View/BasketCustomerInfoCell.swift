//
//  BasketCustomerInfoSetCell.swift
//  Mama Jean's Pizza
//
//  Created by Lap on 02.03.2023.
//

import SnapKit
import UIKit

class BasketCustomerInfoCell: UITableViewCell {
    // MARK: - Public
    func configure(with info: BasketCustomerInfoCellInfo, viewController: UIViewController) {
        nameTextField.text = info.name
        nameTextField.delegate = viewController as? UITextFieldDelegate
        
        phoneTextField.text = "+971123456789"
        phoneTextField.delegate = viewController as? UITextFieldDelegate
        
        addressTextField.text = "JLT, Claster X3, flat 228"
        addressTextField.delegate = viewController as? UITextFieldDelegate
        
        guard let viewController = viewController as? BasketViewController else { return }
        paymentTypeButton.addTarget(viewController, action: #selector(viewController.paymentTypeButtonTapped), for: .touchUpInside)
    }
    
    func updatePaymentType(newPaymentType: String) {
        paymentTypeButton.setTitle(newPaymentType, for: .normal)
    }
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private constants
    private enum UIConstants {
        static let contentInset: CGFloat = 16
        static let beforeTextFieldInset: CGFloat = 8
    }
    
    // MARK: - Private properties
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your name"
        textField.borderStyle = .roundedRect
        textField.textContentType = .name
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        return textField
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Phone"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    private let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your phone"
        textField.borderStyle = .roundedRect
        textField.text = "+971"
        textField.textContentType = .telephoneNumber
        textField.keyboardType = .phonePad
        return textField
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Address"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    private let addressTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your address"
        textField.borderStyle = .roundedRect
        textField.textContentType = .fullStreetAddress
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        return textField
    }()
    
    private let paymentTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Payment type"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    private let paymentTypeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cash on Delivery", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    // MARK: - Private methods
    private func initialize() {
        selectionStyle = .none
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIConstants.contentInset)
            make.leading.equalToSuperview().inset(UIConstants.contentInset)
            make.height.greaterThanOrEqualTo(10)
        }
        contentView.addSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).inset(-UIConstants.beforeTextFieldInset)
            make.leading.equalToSuperview().inset(UIConstants.contentInset)
            make.trailing.equalToSuperview().inset(UIConstants.contentInset)
        }
        contentView.addSubview(phoneLabel)
        phoneLabel.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).inset(-UIConstants.contentInset)
            make.leading.equalToSuperview().inset(UIConstants.contentInset)
        }
        contentView.addSubview(phoneTextField)
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneLabel.snp.bottom).inset(-UIConstants.beforeTextFieldInset)
            make.leading.equalToSuperview().inset(UIConstants.contentInset)
            make.trailing.equalToSuperview().inset(UIConstants.contentInset)
        }
        contentView.addSubview(addressLabel)
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).inset(-UIConstants.contentInset)
            make.leading.equalToSuperview().inset(UIConstants.contentInset)
        }
        contentView.addSubview(addressTextField)
        addressTextField.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).inset(-UIConstants.beforeTextFieldInset)
            make.leading.equalToSuperview().inset(UIConstants.contentInset)
            make.trailing.equalToSuperview().inset(UIConstants.contentInset)
        }
        contentView.addSubview(paymentTypeLabel)
        paymentTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(addressTextField.snp.bottom).inset(-UIConstants.contentInset)
            make.leading.equalToSuperview().inset(UIConstants.contentInset)
        }
        contentView.addSubview(paymentTypeButton)
        paymentTypeButton.snp.makeConstraints { make in
            make.top.equalTo(paymentTypeLabel.snp.bottom).inset(-UIConstants.beforeTextFieldInset)
            make.leading.equalToSuperview().inset(UIConstants.contentInset)
            make.trailing.equalToSuperview().inset(UIConstants.contentInset)
            make.bottom.equalToSuperview().inset(UIConstants.contentInset)
        }
    }
}
