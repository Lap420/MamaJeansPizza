import UIKit
import SnapKit

class DealDescriptionView: UIView {
    // MARK: - Public properties
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(systemName: "chevron.backward"), for: .normal)
        button.tintColor = GlobalUIConstants.mamaGreenColor
        button.backgroundColor = .white
        button.layer.cornerRadius = Constants.backButtonWidth / 2
        return button
    }()
    
    let tableView: ParalaxTableView = {
        let view = ParalaxTableView()
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    let headerView: UIView = {
        let view = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 0,
                height: Constants.imageHeight
            )
        )
        return view
    }()
    
    let headerImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .yellow
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.black.withAlphaComponent(0.4).cgColor,
            UIColor.black.withAlphaComponent(0).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0.3)
        gradientLayer.frame = CGRect(
            x: 0,
            y: 0,
            width: GlobalUIConstants.screenWidth,
            height: Constants.imageHeight
        )
        view.layer.addSublayer(gradientLayer)
        return view
    }()
    
    // MARK: - View lifecycle
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private properties
    private enum Constants {
        static let imageHeight: CGFloat = GlobalUIConstants.screenWidth
        static let imageBottomInset: CGFloat = 20
        static let mainInset: CGFloat = 16
        static let buttonHeight: CGFloat = 45
        static let bottomViewHeight: CGFloat = buttonHeight + mainInset
        static let cornerRadius: CGFloat = 10
        static let backButtonWidth: CGFloat = 40
    }
    
    let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let orderButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = GlobalUIConstants.mamaGreenColor
        button.layer.cornerRadius = Constants.cornerRadius
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Order now", for: .normal)
        return button
    }()
}

// MARK: - Private methods
private extension DealDescriptionView {
    func setup() {
        backgroundColor = GlobalUIConstants.mamaGreenColor

        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(safeAreaLayoutGuide)
        }

        tableView.tableHeaderView = headerView
        headerView.addSubview(headerImageView)
        headerImageView.snp.makeConstraints { make in
            make.height.equalTo(Constants.imageHeight)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(Constants.imageBottomInset)
        }
        
        self.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.leading.equalTo(safeAreaLayoutGuide).inset(Constants.mainInset)
            make.height.width.equalTo(Constants.backButtonWidth)
        }
        
        self.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom)
            make.bottom.leading.trailing.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(Constants.bottomViewHeight)
        }
        
        bottomView.addSubview(orderButton)
        orderButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.leading.trailing.equalToSuperview().inset(Constants.mainInset)
        }
    }
}
