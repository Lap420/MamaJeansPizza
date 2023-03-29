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
        return button
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .systemGray
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        label.textColor = .systemGray
        return label
    }()
    
    let bottomStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        //stack.spacing = Constants.stackSpacing
        return stack
    }()
    
    let minusButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(systemName: "minus.circle"), for: .normal)
        return button
    }()
    
    let itemQtyLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let plusButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(systemName: "plus.circle"), for: .normal)
        return button
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = GlobalUIConstants.mamaGreenColor
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
    }
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
            make.top.leading.equalToSuperview().inset(24)
        }
        
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).inset(-16)
            make.leading.trailing.equalToSuperview()
        }
        
        self.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).inset(-32)
            make.leading.trailing.equalToSuperview()
        }
        
        bottomStack.addArrangedSubview(minusButton)
        bottomStack.addArrangedSubview(itemQtyLabel)
        bottomStack.addArrangedSubview(plusButton)
        bottomStack.addArrangedSubview(addButton)
        
        self.addSubview(bottomStack)
        bottomStack.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
}
