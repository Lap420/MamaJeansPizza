import UIKit

class ChooseAStoreController: UIViewController {
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - Private properties
    private lazy var chooseAStoreView = ChooseAStoreView()
    private lazy var chooseAStoreModel = ChooseAStoreModel()
}

// MARK: Private methods
private extension ChooseAStoreController {
    func initialize() {
        view = chooseAStoreView
        self.title = "Choose a store"
        chooseAStoreView.storesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        chooseAStoreView.storesTableView.delegate = self
        chooseAStoreView.storesTableView.dataSource = self
    }
    
    func CheckStoreIsOpen(_ store: Store) -> (isOpen: Bool, storeTimeComment: String) {
        var isOpen = false
        var storeTimeComment = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        guard let openTime = dateFormatter.date(from: store.openTime) else { return (false, "") }
        guard let closeTime = dateFormatter.date(from: store.closeTime) else { return (false, "") }
        var dateComponents = Calendar.current.dateComponents([.hour, .minute], from: Date())
        dateComponents.year = 2000
        dateComponents.month = 1
        dateComponents.day = 1
        guard let currentTime = Calendar.current.date(from: dateComponents) else { return (false, "") }
        if currentTime >= openTime && currentTime <= closeTime {
            let timeDifference = closeTime.timeIntervalSince(currentTime)
            let hours = timeDifference / 60 / 60
            if hours < 1 {
                storeTimeComment = " (closes soon)"
            }
            isOpen = true
        } else {
            var timeDifference: TimeInterval = 0
            if currentTime < openTime {
                timeDifference = openTime.timeIntervalSince(currentTime)
                print(timeDifference)
            } else {
                guard let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: openTime) else { return (false, "") }
                timeDifference = tomorrow.timeIntervalSince(currentTime)
            }
            let hours = Int(timeDifference / 60 / 60)
            if hours < 1 {
                let minutes = Int(timeDifference / 60)
                storeTimeComment = " (opens in \(minutes) minutes)"
            } else {
                storeTimeComment = " (opens in \(hours) hours)"
            }
        }
        
        return (isOpen, storeTimeComment)
    }
}

// MARK: - Table view data source
extension ChooseAStoreController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return chooseAStoreModel.cities.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let city = chooseAStoreModel.cities[section]
        return chooseAStoreModel.stores[city]?.count ?? 0
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return chooseAStoreModel.cities[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let city = chooseAStoreModel.cities[indexPath.section]
        guard let store = chooseAStoreModel.stores[city]?[indexPath.row] else { return cell }
        var content = cell.defaultContentConfiguration()
        content.text = store.name
        let checkStoreIsOpen = CheckStoreIsOpen(store)
        content.secondaryText = store.openTime + " - " + store.closeTime + checkStoreIsOpen.storeTimeComment
        if !checkStoreIsOpen.isOpen {
            content.secondaryTextProperties.color = .red
            cell.isUserInteractionEnabled = false
        }
        cell.contentConfiguration = content
        return cell
    }
}

// MARK: - Table view delegate
extension ChooseAStoreController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let nextVC = MenuController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
