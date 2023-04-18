import UIKit

class BalanceView: UIStackView {
    // MARK: - Public properties
    let bonusBalanceLabel: UILabel = {
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
    private let bonusBalanceImage: UIImageView = {
        let view = UIImageView()
        view.image = .init(named: "pizza_icon")
        return view
    }()
}

// MARK: - Private methods
private extension BalanceView {
    func setup() {
        self.addArrangedSubview(bonusBalanceLabel)
        self.addArrangedSubview(bonusBalanceImage)
        bonusBalanceImage.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
    }
}
