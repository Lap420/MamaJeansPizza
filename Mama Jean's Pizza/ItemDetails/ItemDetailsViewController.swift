//
//  ItemDetailsViewController.swift
//  Mama Jean's Pizza
//
//  Created by Lap on 16.02.2023.
//

import UIKit

class ItemDetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var itemQtyLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    var itemsPageDelegate: ItemsPageDelegate?
    var image: UIImage?
    var item = ItemData(id: "", name: "", description: "", price: 0)
    var itemQty = 1
    var textPrice = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addButton.layer.cornerRadius = 10
        
        imageView.image = image
        nameLabel.text = item.name
        descriptionLabel.text = item.description
        
        textPrice = String(format: "%.2f", item.price)
        addButton.setTitle("Add \(textPrice) AED", for: .normal)
    }
    
    @IBAction func minusButtonTapped(_ sender: UIButton) {
        guard itemQty > 1 else { return }
        itemQty -= 1
        itemQtyLabelAndAddButton()
        
    }
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        itemQty += 1
        itemQtyLabelAndAddButton()
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        Basket.shared.addItem(item: OrderItem(productId: item.id, amount: itemQty, price: item.price))
        itemsPageDelegate?.updateBasketButton()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        guard image != nil else { return }
        let shareController = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        shareController.completionWithItemsHandler = { _, bool, _, _ in
            if bool {
                print("Successful")
            }
        }
        
        present(shareController, animated: true, completion: nil)
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    private func itemQtyLabelAndAddButton() {
        itemQtyLabel.text = "\(itemQty)"
        textPrice = String(format: "%.2f", item.price * Double(itemQty))
        addButton.setTitle("Add \(textPrice) AED", for: .normal)
    }
}
