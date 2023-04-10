import UIKit

class MainMenuView: UIView {
    // MARK: - Public properties
    let mainMenuButtons = ["ABOUT US", "ORDER HISTORY", "SETTINGS"]
    
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
//        static let stackSpacing: CGFloat = GlobalUIConstants.screenWidth * 0.05
//        static let cornerRadius: CGFloat = 10
        static let bottomFont: UIFont = .systemFont(ofSize: 12, weight: .medium)
        static let bottomColor: UIColor = .systemGray3
//        static let sectionInset: CGFloat = GlobalUIConstants.screenWidth * 0.05
//        static let minimumInteritemSpacing: CGFloat = GlobalUIConstants.screenWidth * 0.025
//        static let afterLabelCollectionInset: CGFloat = 8
//        static let rateButtonCornerRadius: CGFloat = 20
//        static let bottomButtonsFont: UIFont = .systemFont(ofSize: 15, weight: .regular)
//        static let topScrollInset: CGFloat = 32
        static let mainInset: CGFloat = 16
        static let bottomViewInset: CGFloat = 44
        static let bottomViewHeight: CGFloat = 1
//        static let widthMultiplier: CGFloat = 0.9
//        static let topButtonsRatio: CGFloat = 9.0 / 21.0
//        static let rateButtonsRatio: CGFloat = 9.0 / 49.0
//        static let bottomStackRatio: CGFloat = 1.0 / 7.0
//        static let bigScreenBottomInset: CGFloat = 69
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
