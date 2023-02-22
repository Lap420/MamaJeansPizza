//
//  ItemsCollectionViewController.swift
//  Mama Jean's Pizza
//
//  Created by Lap on 16.02.2023.
//

import UIKit

private let reuseIdentifier = "Item"

class ItemsCollectionViewController: UICollectionViewController {

    let items = ["All the meats"]
    var menuFolder = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        cell.imageView.image = UIImage(named: menuFolder)
        cell.nameLabel.text = menuFolder
        cell.priceLabel.text = "228 AED"
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
