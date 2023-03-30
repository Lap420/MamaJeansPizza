import UIKit

class ItemsView: UIView {
    // MARK: - Public properties
    let itemsCollectionView: UICollectionView = {
        let spacingTotal = (Constants.itemsPerRow + 1) * Constants.sectionInset
        let itemWidth = (Constants.availableWidth - spacingTotal) / Constants.itemsPerRow
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 0.75 + 56)
        layout.sectionInset = UIEdgeInsets(
            top: Constants.sectionInset,
            left: Constants.sectionInset,
            bottom: Constants.sectionInset,
            right: Constants.sectionInset)
        layout.minimumLineSpacing = Constants.sectionInset
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsVerticalScrollIndicator = false
        collection.alwaysBounceVertical = true
        return collection
    }()
    
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
private extension ItemsView {
    func setup() {
        backgroundColor = GlobalUIConstants.mamaGreenColor

        self.addSubview(itemsCollectionView)
        itemsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        self.addSubview(basketButton)
        basketButton.snp.makeConstraints { make in
            make.top.equalTo(itemsCollectionView.snp.bottom)
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
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
