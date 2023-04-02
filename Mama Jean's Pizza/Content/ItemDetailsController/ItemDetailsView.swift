import UIKit

class ItemDetailsView: UIView {
    // MARK: - Public properties
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.setImage(.init(systemName: "chevron.backward"), for: .normal)
        button.tintColor = GlobalUIConstants.mamaGreenColor
        return button
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.nameLabelFont
        label.textColor = Constants.mainContentColor
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Constants.descriptionLabelFont
        label.textColor = Constants.mainContentColor
        return label
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
        button.layer.cornerRadius = 10
        button.backgroundColor = GlobalUIConstants.mamaGreenColor
        button.setContentHuggingPriority(.init(rawValue: 248), for: .horizontal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.font = Constants.addButtonFont
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
        static let itemsPerRow: CGFloat = 2
        static let sectionInset: CGFloat = GlobalUIConstants.screenWidth * 0.05
        static let availableWidth: CGFloat = GlobalUIConstants.screenWidth
        static let nameLabelFont: UIFont = .systemFont(ofSize: 23, weight: .bold)
        static let descriptionLabelFont: UIFont = .systemFont(ofSize: 17)
        static let addButtonFont: UIFont = .systemFont(ofSize: 15)
        static let mainContentColor: UIColor = .systemGray
        static let mainInset: CGFloat = 16
    }
    
    private let bottomStack: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
}

// MARK: - Private methods
private extension ItemDetailsView {
    func setup() {
        backgroundColor = .white

        self.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(imageView.snp.width)
        }
        
        self.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().inset(8)
            make.width.equalTo(40)
            make.height.equalTo(backButton.snp.width)
        }
        
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(Constants.mainInset)
            make.leading.trailing.equalToSuperview().inset(Constants.mainInset)
        }
        
        self.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(Constants.mainInset)
            make.leading.trailing.equalToSuperview().inset(Constants.mainInset)
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
            make.leading.trailing.equalToSuperview().inset(Constants.mainInset)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(Constants.mainInset)
            make.height.equalTo(45)
        }
    }
}
