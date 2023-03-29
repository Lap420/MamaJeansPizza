import UIKit

class ItemDetailsController: UIViewController {
    var image: UIImage?
    var item = ItemData(id: "", name: "", description: "", price: 0)
    var itemQty = 1
    var textPrice = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    // MARK: - Private properties
    private var itemDetailsView = ItemDetailsView()
}

// MARK: Private methods
private extension ItemDetailsController {
    func initialize() {
        view = itemDetailsView
        initButtonTargets()
        
        itemDetailsView.imageView.image = image
        itemDetailsView.nameLabel.text = item.name
        itemDetailsView.descriptionLabel.text = item.description
        textPrice = String(format: "%.2f", item.price)
        itemDetailsView.addButton.setTitle("Add \(textPrice) AED", for: .normal)
        
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
        itemQtyLabelAndAddButton()
    }
    
    @objc
    func plusButtonTapped() {
        itemQty += 1
        itemQtyLabelAndAddButton()
    }
    
    @objc
    func addButtonTapped() {
        let item = BasketItem(productId: item.id, amount: itemQty, price: item.price)
        Basket.shared.addItem(item: item)
      //  itemsPageDelegate?.updateBasketButton()
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    func itemQtyLabelAndAddButton() {
        itemDetailsView.itemQtyLabel.text = "\(itemQty)"
        textPrice = String(format: "%.2f", item.price * Double(itemQty))
        itemDetailsView.addButton.setTitle("Add \(textPrice) AED", for: .normal)
    }
}
