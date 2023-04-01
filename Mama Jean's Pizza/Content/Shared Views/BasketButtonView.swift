import UIKit

class BasketButtonView: UIStackView {
    // MARK: - Public properties
    let basketButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return button
    }()
    
    let itemsAmountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    let totalDueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    // MARK: - View Lifecycle
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private properties
    private enum Constants {
        static let itemsPerRow: CGFloat = 2
        static let sectionInset: CGFloat = GlobalUIConstants.screenWidth * 0.05
        static let availableWidth: CGFloat = GlobalUIConstants.screenWidth
    }
}

// MARK: - Private methods
private extension BasketButtonView {
    func setup() {
        self.addSubview(basketButton)
        basketButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        basketButton.addSubview(itemsAmountLabel)
        itemsAmountLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
        
        basketButton.addSubview(totalDueLabel)
        totalDueLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
        }
    }
}
