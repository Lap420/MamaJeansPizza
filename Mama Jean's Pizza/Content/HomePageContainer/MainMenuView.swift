import UIKit

class MainMenuView: UIView {
    // MARK: - Public properties
    let mainMenuButtons = ["ABOUT US", "ORDER HISTORY", "RATE OUR APP"]
    
    let tableView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.bounces = false
        return view
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
        static let bottomFont: UIFont = .systemFont(ofSize: 12, weight: .medium)
        static let bottomColor: UIColor = .systemGray3
        static let mainInset: CGFloat = 16
        static let bottomViewInset: CGFloat = 44
        static let bottomViewHeight: CGFloat = 1
    }
    
    private let bottomLineView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.bottomColor
        return view
    }()
    
    private let poweredLabel: UILabel = {
        let label = UILabel()
        label.text = "POWERED BY LAP42"
        label.font = Constants.bottomFont
        label.textColor = Constants.bottomColor
        return label
    }()
}

// MARK: - Private methods
private extension MainMenuView {
    func setup() {
        backgroundColor = .white
        
        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(140)
        }
        
        self.addSubview(bottomLineView)
        bottomLineView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.mainInset)
            make.height.equalTo(Constants.bottomViewHeight)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(Constants.bottomViewInset)
        }
        
        self.addSubview(poweredLabel)
        poweredLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide).inset(Constants.mainInset)
        }
    }
}
