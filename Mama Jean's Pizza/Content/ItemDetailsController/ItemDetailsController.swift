import UIKit

class ItemDetailsController: UIViewController {
    // MARK: - Public properties
    var itemControllerDelegate: BasketButtonUpdateDelegate?
    var image: UIImage?
    var item = ItemData(id: "", name: "", description: "", price: 0)
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        itemControllerDelegate?.updateBasketButtonIfNeeded()
    }
    
    // MARK: - Private properties
    private let itemDetailsView = ItemDetailsView()
    private var itemQty = 1
    private var textPrice = ""
}

// MARK: Private methods
private extension ItemDetailsController {
    func initialize() {
        view = itemDetailsView
        initButtonTargets()
        itemQtyChanged()
        itemDetailsView.imageView.image = image
        itemDetailsView.nameLabel.text = item.name
        itemDetailsView.descriptionLabel.text = item.description
    }
    
    func initButtonTargets() {
        itemDetailsView.minusButton.addTarget(
            self,
            action: #selector(minusButtonTapped),
            for: .touchUpInside)
        itemDetailsView.plusButton.addTarget(
            self,
            action: #selector(plusButtonTapped),
            for: .touchUpInside)
        itemDetailsView.addButton.addTarget(
            self,
            action: #selector(addButtonTapped),
            for: .touchUpInside)
        itemDetailsView.backButton.addTarget(
            self,
            action: #selector(backButtonTapped),
            for: .touchUpInside)
    }
    
    @objc
    func minusButtonTapped() {
        guard itemQty > 1 else { return }
        itemQty -= 1
        itemQtyChanged()
    }
    
    @objc
    func plusButtonTapped() {
        itemQty += 1
        itemQtyChanged()
    }
    
    @objc
    func addButtonTapped() {
        let item = BasketItem(productId: item.id, amount: itemQty, price: item.price)
        Basket.shared.addItem(item: item)
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    func itemQtyChanged() {
        itemDetailsView.minusButton.tintColor = itemQty == 1 ? .systemGray : GlobalUIConstants.mamaGreenColor
        itemDetailsView.itemQtyLabel.text = "\(itemQty)"
        textPrice = String(format: "%.2f", item.price * Double(itemQty))
        itemDetailsView.addButton.setTitle("Add \(textPrice) AED", for: .normal)
    }
}
