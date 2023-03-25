//
//  PaymentTypesViewController.swift
//  Mama Jean's Pizza
//
//  Created by Lap on 03.03.2023.
//

import UIKit

class PaymentTypesViewController: UIViewController {
    // MARK: - Public
    func configure(viewController: UIViewController) {
        guard let viewController = viewController as? BasketViewController else { return }
        cashOnDeliveryButton.addTarget(viewController, action: #selector(viewController.paymentTypeDidChoose), for: .touchUpInside)
        cardOnDeliveryButton.addTarget(viewController, action: #selector(viewController.paymentTypeDidChoose), for: .touchUpInside)
        cardOnlineButton.addTarget(viewController, action: #selector(viewController.paymentTypeDidChoose), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
    }

    // MARK: - Private properties
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose a payment type"
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let cashOnDeliveryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cash on Delivery", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(hue: 159/359, saturation: 0.88, brightness: 0.47, alpha: 1)
        return button
    }()
    
    private let cardOnDeliveryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Card on Delivery", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(hue: 159/359, saturation: 0.88, brightness: 0.47, alpha: 1)
        return button
    }()
    
    private let cardOnlineButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Card online", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(hue: 159/359, saturation: 0.88, brightness: 0.47, alpha: 1)
        return button
    }()
    
    // MARK: - Private methods
    private func initialize() {
        stack.addArrangedSubview(headerLabel)
        stack.addArrangedSubview(cashOnDeliveryButton)
        stack.addArrangedSubview(cardOnDeliveryButton)
        stack.addArrangedSubview(cardOnlineButton)
        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
    }
}
