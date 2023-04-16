import SnapKit
import UIKit

class BasketCustomerInfoCell: UITableViewCell {
    // MARK: - Public methods
    func configure(with info: BasketCustomerInfoCellInfo, viewController: UIViewController, defaultPaymentType: PaymentType, handler: @escaping (UIAction) -> Void) {
        nameTextField.delegate = viewController as? UITextFieldDelegate
        phoneTextField.delegate = viewController as? UITextFieldDelegate
        addressTextField.delegate = viewController as? UITextFieldDelegate
        paymentTypeButton.menu = UIMenu(children: [
            UIAction(title: PaymentType.online.rawValue, handler: handler),
            UIAction(title: PaymentType.card.rawValue, handler: handler),
            UIAction(title: PaymentType.cash.rawValue, state: .on, handler: handler)
        ])
        _ = paymentTypeButton.menu?.children.map { menuElement in
            guard let action = menuElement as? UIAction else { return }
            guard action.title == defaultPaymentType.rawValue else { return }
            action.state = .on
        }
    }
    
    func findEmptyTextField(_ textField: UITextField) -> UITextField? {
        if nameTextField.text == "" && nameTextField != textField {
            return nameTextField
        } else if phoneTextField.text == "" && phoneTextField != textField{
            return phoneTextField
        } else if addressTextField.text == "" && addressTextField != textField{
            return addressTextField
        }
        return nil
    }
    
    func addNextButtonOnKeyboard(viewController: UIViewController) {
        let doneToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.width, height: 50))
        doneToolbar.barStyle = .default
        
        var title: String
        if findEmptyTextField(phoneTextField) != nil {
            title = "Next"
        } else {
            title = "Done"
        }
        
        guard let viewController = viewController as? BasketController else { return }
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let nextButton = UIBarButtonItem(title: title, style: .done, target: viewController, action: #selector(viewController.returnForPhoneKeyboard))
        
        let items = [flexSpace, nextButton]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        phoneTextField.inputAccessoryView = doneToolbar
    }
    
    // MARK: - Public properties
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.tag = 1
        textField.placeholder = "Enter your name"
        textField.borderStyle = .roundedRect
        textField.textContentType = .name
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    let invalidPhoneLabel: UILabel = {
        let label = UILabel()
        label.text = "The entered phone number is invalid"
        label.textColor = .red
        label.font = .systemFont(ofSize: 12)
        label.isHidden = true
        return label
    }()
    
    let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.tag = 2
        textField.placeholder = "Enter your phone"
        textField.borderStyle = .roundedRect
        textField.text = "+971"
        textField.textContentType = .telephoneNumber
        textField.keyboardType = .phonePad
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    let addressTextField: UITextField = {
        let textField = UITextField()
        textField.tag = 3
        textField.placeholder = "Enter your address"
        textField.borderStyle = .roundedRect
        textField.textContentType = .fullStreetAddress
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
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
        label.text = "Name *"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Phone *"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Address *"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "Delivery comment"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    private let commentTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Your comment (optional)"
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.clearButtonMode = .whileEditing
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
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.contentHorizontalAlignment = .left
        button.showsMenuAsPrimaryAction = true
        button.changesSelectionAsPrimaryAction = true
        return button
    }()
    
    // MARK: - Private methods
    private func initialize() {
        selectionStyle = .none
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(UIConstants.contentInset)
        }
        contentView.addSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(UIConstants.beforeTextFieldInset)
            make.leading.trailing.equalToSuperview().inset(UIConstants.contentInset)
        }
        contentView.addSubview(phoneLabel)
        phoneLabel.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(UIConstants.contentInset)
            make.leading.equalToSuperview().inset(UIConstants.contentInset)
        }
        contentView.addSubview(phoneTextField)
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneLabel.snp.bottom).offset(UIConstants.beforeTextFieldInset)
            make.leading.trailing.equalToSuperview().inset(UIConstants.contentInset)
        }
        contentView.addSubview(invalidPhoneLabel)
        invalidPhoneLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom)
            make.leading.equalToSuperview().inset(UIConstants.contentInset)
        }
        contentView.addSubview(addressLabel)
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(UIConstants.contentInset)
            make.leading.equalToSuperview().inset(UIConstants.contentInset)
        }
        contentView.addSubview(addressTextField)
        addressTextField.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(UIConstants.beforeTextFieldInset)
            make.leading.trailing.equalToSuperview().inset(UIConstants.contentInset)
        }
        contentView.addSubview(commentLabel)
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo((addressTextField).snp.bottom).offset(UIConstants.contentInset)
            make.leading.equalToSuperview().inset(UIConstants.contentInset)
        }
        contentView.addSubview(commentTextField)
        commentTextField.snp.makeConstraints { make in
            make.top.equalTo(commentLabel.snp.bottom).offset(UIConstants.beforeTextFieldInset)
            make.leading.trailing.equalToSuperview().inset(UIConstants.contentInset)
        }
        contentView.addSubview(paymentTypeLabel)
        paymentTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(commentTextField.snp.bottom).offset(UIConstants.contentInset)
            make.leading.equalToSuperview().inset(UIConstants.contentInset)
        }
        contentView.addSubview(paymentTypeButton)
        paymentTypeButton.snp.makeConstraints { make in
            make.top.equalTo(paymentTypeLabel.snp.bottom).offset(UIConstants.beforeTextFieldInset)
            make.leading.trailing.bottom.equalToSuperview().inset(UIConstants.contentInset)
        }
    }
}
