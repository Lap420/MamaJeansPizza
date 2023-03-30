import UIKit

class BasketView: UIView {
    // MARK: - Public properties
    let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .lightGray
        return view
    }()
    let orderButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return button
    }()
    
    // MARK: - View Lifecycle
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private properties
    private enum Constants {
//        static let itemsPerRow: CGFloat = 2
//        static let sectionInset: CGFloat = GlobalUIConstants.screenWidth * 0.05
//        static let availableWidth: CGFloat = GlobalUIConstants.screenWidth
    }
}

// MARK: - Private methods
private extension BasketView {
    func setup() {
        backgroundColor = GlobalUIConstants.mamaGreenColor
        
        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        self.addSubview(orderButton)
        orderButton.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.top.equalTo(tableView.snp.top)
            make.height.equalTo(40)
        }
    }
}
