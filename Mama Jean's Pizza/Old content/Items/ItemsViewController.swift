//
//  ItemsViewController.swift
//  Mama Jean's Pizza
//
//  Created by Lap on 28.02.2023.
//

import UIKit

class ItemsViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var basketButton: UIButton!
    @IBOutlet weak var itemsAmountLabel: UILabel!
    @IBOutlet weak var totalDueLabel: UILabel!
    
    var items = [ItemData]()
    var choosenMenuGroup = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareItems()
        updateBasketButton()
        
        basketButton.layer.cornerRadius = 10
        basketButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }

        let itemsPerRow: CGFloat = 2
        let availableWidth = collectionView.frame.width * 0.9
        let itemWidth = availableWidth / itemsPerRow
        let spacingTotal: CGFloat = collectionView.frame.width - availableWidth
        let spacing = spacingTotal / (itemsPerRow + 1)

        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = .zero
        
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func prepareItems() {
        MenuManager.shared.menu?.forEach { menuGroup in
            if menuGroup.id == self.choosenMenuGroup {
                let currentMenuGroup = menuGroup
                currentMenuGroup.items?.forEach { item in
                    items.append(ItemData(id: item.itemId,
                                          name: item.name,
                                          description: item.description ?? "",
                                          price: item.itemSizes.first?.prices.first?.price ?? 0.00))
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? ItemDetailsViewController else { return }
        guard let item = sender as? ItemCell2 else { return }
        destinationVC.image = item.imageView.image
        
        guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
        destinationVC.item = items[indexPath.row]
        
        destinationVC.itemsPageDelegate = self
    }
}

extension ItemsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int { return 1 }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Item", for: indexPath) as! ItemCell2
    
        cell.imageView.contentMode = .scaleAspectFit
        cell.imageView.clipsToBounds = true
        cell.imageView.image = MenuManager.shared.menuImages[items[indexPath.item].id]
        cell.nameLabel.text = items[indexPath.item].name
        cell.priceLabel.text = String(format: "%.2f", items[indexPath.row].price) + " AED"
    
        return cell
    }
}

extension ItemsViewController: ItemsPageDelegate {
    func updateBasketButton() {
        var itemsAmount = 0
        var totalDue = 0.0
        Basket.shared.items?.forEach({ item in
            itemsAmount += item.amount
            totalDue += Double(item.amount) * item.price
        })
        self.itemsAmountLabel.text = "\(itemsAmount)"
        self.totalDueLabel.text = "\(String(format: "%.2f", totalDue)) AED"
    }
}

protocol ItemsPageDelegate {
    func updateBasketButton()
}
