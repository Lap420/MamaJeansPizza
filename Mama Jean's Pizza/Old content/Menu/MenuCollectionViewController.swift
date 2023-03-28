//
//  MenuCollectionViewController.swift
//  Mama Jean's Pizza
//
//  Created by Lap on 15.02.2023.
//

import UIKit

private let reuseIdentifier = "Menu"

class MenuCollectionViewController: UICollectionViewController {

    var menu = [(id: String, name: String)]()
    var menuImages = [String: UIImage]()
    
    // TODO: Сделать общий фон зеленым, а фон collection белый
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareMenu()
        
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

    func prepareMenu() {
        MenuManager.shared.menu?.forEach { menuGroup in
            menu.append((menuGroup.id, menuGroup.name))
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? ItemsViewController else { return }
        guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
        destinationVC.choosenMenuGroup = menu[indexPath.row].id
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int { return 1 }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menu.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MenuCell
    
//        cell.imageView.contentMode = .scaleAspectFit
//        cell.imageView.clipsToBounds = true
//        cell.imageView.image = MenuManager.shared.menuImages[menu[indexPath.item].id]
//        cell.nameLabel.text = menu[indexPath.item].name
        
        return cell
    }
}
