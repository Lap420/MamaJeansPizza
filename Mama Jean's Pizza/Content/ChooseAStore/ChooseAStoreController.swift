// TODO: If a store is closed, make a store name red color
// TODO: Add favourite stores
// TODO: Add map

// TODO: Change open-close time to dateTime
// TODO: Move model to model file

import UIKit

class ChooseAStoreTableViewController: UIViewController {
    
    let cities = ["Dubai", "Abu-Dhabi"]
    let storesDubai = ["Dubai Marina", "Dubai Internet City", "Dubai Investments park", "Jumairah Lake Towers"]
    let storesAbuDhabi = ["Abu-Dhabi Airport", "Abu-Dhabi F1 Circuit"]
    let stores = [
        "Dubai": [
            Store(name: "Dubai Marina", openTime: "10:00 am", closingTime: "10:00 pm"),
            Store(name: "Dubai Internet City", openTime: "10:00 am", closingTime: "10:00 pm"),
            Store(name: "Dubai Investments park", openTime: "10:00 am", closingTime: "10:00 pm"),
            Store(name: "Jumairah Lake Towers", openTime: "10:00 am", closingTime: "10:00 pm")
        ],
        "Abu-Dhabi": [
            Store(name: "Abu-Dhabi Airport", openTime: "10:00 am", closingTime: "10:00 pm"),
            Store(name: "Abu-Dhabi F1 Circuit", openTime: "10:00 am", closingTime: "10:00 pm")
        ]
    ]
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // MARK: - Private properties
    private var chooseAStoreView = ChooseAStoreView()
}

// MARK: Private methods
private extension ChooseAStoreTableViewController {
    func initialize() {
        view = chooseAStoreView
        self.title = "Choose a store"
        chooseAStoreView.storesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Store")
        chooseAStoreView.storesTableView.delegate = self
        chooseAStoreView.storesTableView.dataSource = self
    }
}

// MARK: - Table view data source
extension ChooseAStoreTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return cities.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return storesDubai.count
        case 1:
            return storesAbuDhabi.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return cities[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Store", for: indexPath)
        var content = cell.defaultContentConfiguration()
        switch indexPath.section {
        case 0:
            content.text = storesDubai[indexPath.row]
        case 1:
            content.text = storesAbuDhabi[indexPath.row]
        default:
            break
        }
        content.secondaryText = "10:00 am - 10:00 pm"
        cell.contentConfiguration = content
        return cell
    }
}

// MARK: - Table view delegate
extension ChooseAStoreTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let nextVC = MenuController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
