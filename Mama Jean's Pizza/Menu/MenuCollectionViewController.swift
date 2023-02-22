//
//  MenuCollectionViewController.swift
//  Mama Jean's Pizza
//
//  Created by Lap on 15.02.2023.
//

import UIKit

private let reuseIdentifier = "Menu"

class MenuCollectionViewController: UICollectionViewController {

    let menu = ["Pizza", "Starters", "Beverages", "Salads", "Pasta", "Desserts"]
    
    // TODO: Сделать spacing пропорциональным ширине экрана
    // TODO: Изменить цвет кнопки Back
    // TODO: Сделать общий фон зеленым, а фон collection белый
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.estimatedItemSize = .zero
        
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
        
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? ItemsCollectionViewController else { return }
        guard let menu = sender as? MenuCell else { return }
        destinationVC.menuFolder = menu.nameLabel.text ?? "Unknown"
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int { return 1 }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menu.count
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MenuCell
    
        //cell.contentMode = .scaleAspectFill
        cell.imageView.contentMode = .scaleAspectFit
        cell.imageView.clipsToBounds = true
        cell.imageView.image = UIImage(named: menu[indexPath.item])
        cell.nameLabel.text = menu[indexPath.item]
        
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

//extension MenuCollectionViewController: UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//
//        let paddingWidth = cellSpacing.left * 2 + cellSpacing.right * (itemsPerRow - 1)
//        let availableWidth = collectionView.frame.width - paddingWidth
//        let itemWidth = availableWidth / itemsPerRow
//
//        return CGSize(width: itemWidth, height: itemWidth)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//
//        return cellSpacing
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//
//        return cellSpacing.right
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//
//        return cellSpacing.bottom
//    }
//
//}
