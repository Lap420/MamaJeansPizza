import UIKit

class ItemDetailsView: UIView {
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
                width: GlobalUIConstants.screenWidth,
                height: Constants.imageHeight
            )
        )
        return view
    }()
    
    let headerImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .yellow
        return view
    }()
    
    let headerImageBottomRoundedView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowOpacity = Constants.shadowOpacity
        view.layer.cornerRadius = Constants.mainCornerRadius
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    let minusButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "minus.circle")?.resizableImage(
            withCapInsets: .zero,
            resizingMode: .stretch
        )
        button.setImage(image, for: .normal)
        button.contentMode = .scaleAspectFit
        button.tintColor = GlobalUIConstants.mamaGreenColor
        return button
    }()
    
    let itemQtyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.setContentHuggingPriority(.init(rawValue: 249), for: .horizontal)
        return label
    }()
    
    let plusButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "plus.circle")?.resizableImage(
            withCapInsets: .zero,
            resizingMode: .stretch
        )
        button.setImage(image, for: .normal)
        button.contentMode = .scaleAspectFit
        button.tintColor = GlobalUIConstants.mamaGreenColor
        return button
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setContentHuggingPriority(.init(rawValue: 248), for: .horizontal)
        var conf = UIButton.Configuration.filled()
        conf.title = "Add to cart"
        conf.titleAlignment = .center
        conf.baseBackgroundColor = GlobalUIConstants.mamaGreenColor
        conf.buttonSize = .medium
        button.configuration = conf
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
        static let shadowOpacity: Float = 0.42
        static let mainCornerRadius: CGFloat = 10
        static let itemsPerRow: CGFloat = 2
        static let sectionInset: CGFloat = GlobalUIConstants.screenWidth * 0.05
        static let availableWidth: CGFloat = GlobalUIConstants.screenWidth
        static let nameLabelFont: UIFont = .systemFont(ofSize: 23, weight: .bold)
        static let descriptionLabelFont: UIFont = .systemFont(ofSize: 17)
        static let addButtonFont: UIFont = .systemFont(ofSize: 15)
        static let mainContentColor: UIColor = .systemGray
        static let mainInset: CGFloat = 16
        static let backButtonWidth: CGFloat = 40
        static let imageHeight: CGFloat = GlobalUIConstants.screenWidth * 0.75
    }
    
    private let sliderView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 2
        return view
    }()
    
    private let bottomStack: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
}

// MARK: - Private methods
private extension ItemDetailsView {
    func setup() {
        backgroundColor = .white

        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(safeAreaLayoutGuide)
        }

        tableView.tableHeaderView = headerView
        headerView.addSubview(headerImageView)
        headerImageView.snp.makeConstraints { make in
            make.height.equalTo(Constants.imageHeight)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        headerImageView.addSubview(headerImageBottomRoundedView)
        headerImageBottomRoundedView.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(headerView.snp.bottom)
        }
        
        headerImageBottomRoundedView.addSubview(sliderView)
        sliderView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(4)
            make.width.equalTo(40)
            make.height.equalTo(4)
        }
        
        self.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.leading.equalTo(safeAreaLayoutGuide).inset(Constants.mainInset)
            make.height.width.equalTo(Constants.backButtonWidth)
        }
        
        bottomStack.addArrangedSubview(minusButton)
        bottomStack.addArrangedSubview(itemQtyLabel)
        bottomStack.addArrangedSubview(plusButton)
        bottomStack.setCustomSpacing(32, after: plusButton)
        bottomStack.addArrangedSubview(addButton)
        
        minusButton.snp.makeConstraints { make in
            make.width.equalTo(52)
        }
        
        itemQtyLabel.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(21)
        }
        
        plusButton.snp.makeConstraints { make in
            make.width.equalTo(52)
        }
        
        self.addSubview(bottomStack)
        bottomStack.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(Constants.mainInset)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(Constants.mainInset)
            make.height.equalTo(45)
        }
    }
}
