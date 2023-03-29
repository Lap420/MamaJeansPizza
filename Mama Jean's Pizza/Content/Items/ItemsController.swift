import UIKit

// TODO: Move model to model file
// TODO: Add a header for the collection
// TODO: Add push to the next page
// TODO: Remove UIKit from MenuUploader

class ItemsController: UIViewController {
    // MARK: Public properties
    var items = [ItemData]()
    var choosenMenuGroupId = String()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    // MARK: - Private properties
    private var itemsView = ItemsView()
}

// MARK: Private methods
private extension ItemsController {
    func initialize() {
        view = itemsView
        prepareItems()
        initCollectionsDelegateAndSource()
    }
    
    func prepareItems() {
        MenuManager.shared.menu?.forEach { menuGroup in
            if menuGroup.id == self.choosenMenuGroupId {
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
    
    func initCollectionsDelegateAndSource() {
        itemsView.itemsCollectionView.register(ItemCell.self, forCellWithReuseIdentifier: "cell")
        itemsView.itemsCollectionView.delegate = self
        itemsView.itemsCollectionView.dataSource = self
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let destinationVC = segue.destination as? ItemDetailsViewController else { return }
//        guard let item = sender as? ItemCell else { return }
//        destinationVC.image = item.imageView.image
//        
//        guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
//        destinationVC.item = items[indexPath.row]
//        
//        destinationVC.itemsPageDelegate = self
//    }
}

// MARK: - UICollectionViewDataSource
extension ItemsController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                      for: indexPath) as! ItemCell
        cell.configure(name: items[indexPath.item].name,
                       price: String(format: "%.2f", items[indexPath.row].price) + " AED",
                       image: MenuManager.shared.menuImages[items[indexPath.item].id])
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ItemsController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = ItemDetailsController()
        //nextVC.choosenMenuGroupId = menu[indexPath.row].id
//        guard let item = sender as? ItemCell2 else { return }
//        destinationVC.image = item.imageView.image
        
        nextVC.item = items[indexPath.row]
        present(nextVC, animated: true)
        //self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
