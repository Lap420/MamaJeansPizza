import UIKit

class BasketButtonView: UIStackView {
    // MARK: - Public properties
    let basketButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        button.backgroundColor = GlobalUIConstants.mamaGreenColor
        return button
    }()
    
    let itemsAmountLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.contentColor
        return label
    }()
    
    let totalDueLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.contentColor
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
        static let contentColor: UIColor = .white
        static let borderInset: CGFloat = 16
        static let topInset: CGFloat = 14
        static let afterCartImageInset: CGFloat = 4
    }
    
    private let itemsAmountImage: UIImageView = {
        let view = UIImageView()
        view.image = .init(systemName: "cart")
        view.tintColor = Constants.contentColor
        return view
    }()
}

// MARK: - Private methods
private extension BasketButtonView {
    func setup() {
        backgroundColor = .white
        
        self.addSubview(basketButton)
        basketButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        basketButton.addSubview(itemsAmountImage)
        itemsAmountImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.topInset)
            make.leading.equalToSuperview().inset(Constants.borderInset)
        }
        
        basketButton.addSubview(itemsAmountLabel)
        itemsAmountLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.topInset)
            make.leading.equalTo(itemsAmountImage.snp.trailing).offset(Constants.afterCartImageInset)
        }
        
        basketButton.addSubview(totalDueLabel)
        totalDueLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.topInset)
            make.trailing.equalToSuperview().inset(Constants.borderInset)
        }
    }
}
