import UIKit

class MenuController: UIViewController {
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        updateBasketButtonIfNeeded()
        updateBalanceLabel()
    }
    
    // MARK: - Private properties
    private let menuView = MenuView()
    private let balanceView = BalanceView()
    private var menuModel = MenuModel()
}

// MARK: - Private methods
private extension MenuController {
    func initialize() {
        view = menuView
        self.title = "Menu"
        configureNavigationBar()
        initCollectionsDelegateAndSource()
        initButtonTargets()
    }
    
    func configureNavigationBar() {
        // MARK: Right navbar
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: balanceView)
    }
    
    func initCollectionsDelegateAndSource() {
        menuView.menuCollectionView.register(
            MenuCell.self,
            forCellWithReuseIdentifier: MenuCell.idetifier
        )
        menuView.menuCollectionView.delegate = self
        menuView.menuCollectionView.dataSource = self
    }
    
    func initButtonTargets() {
        menuView.basketButtonView.basketButton.addTarget(
            self,
            action: #selector(basketButtonTapped),
            for: .touchUpInside
        )
    }
    
    func updateBalanceLabel() {
        balanceView.bonusBalanceLabel.text = "\(BalanceObserver.shared.balance)"
    }
    
    @objc
    func basketButtonTapped() {
        let nextVC = BasketController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension MenuController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return menuModel.menu.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MenuCell.idetifier,
            for: indexPath) as! MenuCell
        var image: UIImage? = nil
        let menuGroupId = menuModel.menu[indexPath.item].id
        if let imageData = menuModel.menuImages[menuGroupId] {
            image = UIImage(data: imageData)
        }
        cell.configure(
            name: menuModel.menu[indexPath.item].name,
            image: image
        )
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MenuController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let nextVC = ItemsController()
        nextVC.choosenMenuGroup = menuModel.menu[indexPath.item]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

// MARK: - BasketButtonUpdateDelegate protocol
extension MenuController: BasketButtonUpdateDelegate {
    func updateBasketButtonIfNeeded() {
        let expectedIsHidden = Basket.shared.items?.count ?? 0 <= 0
        if !expectedIsHidden {
            let basketTotal = Basket.shared.getItemsAndTotalAmount()
            menuView.basketButtonView.itemsAmountLabel.text = basketTotal.items
            menuView.basketButtonView.totalDueLabel.text = basketTotal.amount
        }
        menuView.showHideBasketButton(isHidden: expectedIsHidden)
    }
}

protocol BasketButtonUpdateDelegate {
    func updateBasketButtonIfNeeded()
}
