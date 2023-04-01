import UIKit

class MenuView: UIView {
    // MARK: - Public methods
    func showHideBasketButton(isHidden: Bool) {
        basketButtonView.isHidden = isHidden
        if basketButtonView.isHidden {
            menuCollectionView.snp.remakeConstraints { make in
                make.top.equalTo(safeAreaLayoutGuide)
                make.leading.trailing.equalToSuperview()
                make.bottom.equalToSuperview()
            }
        } else {
            menuCollectionView.snp.remakeConstraints { make in
                make.top.equalTo(safeAreaLayoutGuide)
                make.leading.trailing.equalToSuperview()
                make.bottom.equalTo(basketButtonView.snp.top)
            }
        }
    }
    
    // MARK: - Public properties
    let menuCollectionView: UICollectionView = {
        let spacingTotal = (Constants.itemsPerRow + 1) * Constants.sectionInset
        let itemWidth = (Constants.availableWidth - spacingTotal) / Constants.itemsPerRow
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
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
    
    let basketButtonView = BasketButtonView()
    
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
        static let buttonHeight: CGFloat = 45
    }
}

// MARK: - Private methods
private extension MenuView {
    func setup() {
        backgroundColor = GlobalUIConstants.mamaGreenColor
        
        self.addSubview(menuCollectionView)
        menuCollectionView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        self.addSubview(basketButtonView)
        basketButtonView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.bottom).inset(Constants.buttonHeight)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(Constants.buttonHeight)
        }
    }
}
