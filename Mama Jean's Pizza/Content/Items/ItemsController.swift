import UIKit

class ItemsController: UIViewController {
    // MARK: Public properties
    var choosenMenuGroup = (id: "", name: "")
    
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        itemsModel = .init(choosenGroupId: choosenMenuGroup.id)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        updateBasketButtonIfNeeded()
        updateBalanceLabel()
    }
    
    // MARK: - Private properties
    private let itemsView = ItemsView()
    private let balanceView = BalanceView()
    private var itemsModel: ItemsModel?
}

// MARK: - Private methods
private extension ItemsController {
    func initialize() {
        view = itemsView
        self.title = choosenMenuGroup.name
        configureNavigationBar()
        initCollectionsDelegateAndSource()
        initButtonTargets()
    }
    
    func configureNavigationBar() {
        // MARK: Right navbar
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: balanceView)
    }
    
    func initCollectionsDelegateAndSource() {
        itemsView.itemsCollectionView.register(ItemCell.self, forCellWithReuseIdentifier: "cell")
        itemsView.itemsCollectionView.delegate = self
        itemsView.itemsCollectionView.dataSource = self
    }
    
    func initButtonTargets() {
        itemsView.basketButtonView.basketButton.addTarget(
            self,
            action: #selector(basketButtonTapped),
            for: .touchUpInside
        )
    }
    
    func updateBalanceLabel() {
        let balance = UserDefaultsManager.loadBalance()
        balanceView.bonusBalanceLabel.text = "\(balance)"
    }
    
    @objc
    func basketButtonTapped() {
        let nextVC = BasketController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension ItemsController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return itemsModel?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "cell",
            for: indexPath) as! ItemCell
        let name = itemsModel!.items[indexPath.item].name
        let price = String(format: "%.2f", itemsModel!.items[indexPath.item].price) + " AED"
        var image: UIImage? = nil
        let itemId = itemsModel!.items[indexPath.item].id
        if let imageData = itemsModel!.itemsImages[itemId] {
            image = UIImage(data: imageData)
        }
        cell.configure(name: name, price: price, image: image)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ItemsController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let nextVC = ItemDetailsController()
        nextVC.itemControllerDelegate = self
        nextVC.item = itemsModel!.items[indexPath.item]
        var image: UIImage? = nil
        let itemId = itemsModel!.items[indexPath.item].id
        if let imageData = itemsModel!.itemsImages[itemId] {
            image = UIImage(data: imageData)
        }
        nextVC.image = image
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true)
    }
}

// MARK: - BasketButtonUpdateDelegate protocol
extension ItemsController: BasketButtonUpdateDelegate {
    func updateBasketButtonIfNeeded() {
        let expectedIsHidden = Basket.shared.items?.count ?? 0 <= 0
        if !expectedIsHidden {
            let basketTotal = Basket.shared.getItemsAndTotalAmount()
            itemsView.basketButtonView.itemsAmountLabel.text = basketTotal.items
            itemsView.basketButtonView.totalDueLabel.text = basketTotal.amount
        }
        itemsView.showHideBasketButton(isHidden: expectedIsHidden)
    }
}
