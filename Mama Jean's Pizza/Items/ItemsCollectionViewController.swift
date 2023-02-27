//
//  ItemsCollectionViewController.swift
//  Mama Jean's Pizza
//
//  Created by Lap on 16.02.2023.
//

import UIKit

private let reuseIdentifier = "Item"

class ItemsCollectionViewController: UICollectionViewController {

    var items = [(id: String, name: String)]()
    var menuGroup = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareItems()
        
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
    }

    func prepareItems() {
        MenuManager.shared.menu?.forEach { menuGroup in
            if menuGroup.id == self.menuGroup {
                let currentMenuGroup = menuGroup
                currentMenuGroup.items?.forEach({ item in
                    items.append((item.itemId, item.name))
                })
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? ItemDetailsViewController else { return }
        guard let item = sender as? ItemCell else { return }
        destinationVC.image = item.imageView.image
        destinationVC.name = item.nameLabel.text ?? "Unknown"
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int { return 1 }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ItemCell
    
        cell.imageView.contentMode = .scaleAspectFit
        cell.imageView.clipsToBounds = true
        cell.imageView.image = UIImage(named: "No_Image")
        cell.nameLabel.text = items[indexPath.item].name
        cell.priceLabel.text = "228 AED"
    
        return cell
    }
}
