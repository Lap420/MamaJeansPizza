import UIKit

class MainMenuController: UIViewController {
    // MARK: - Public properties
    var orderHistoryButtonTapped: (() -> ())?
    
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    // MARK: - Private properties
    private lazy var mainMenuView = MainMenuView()
}

// MARK: - Private methods
private extension MainMenuController {
    func initialize() {
        view = mainMenuView
        initTableView()
    }
    
    func initTableView() {
        mainMenuView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        mainMenuView.tableView.dataSource = self
        mainMenuView.tableView.delegate = self
    }
}

// MARK: - Table view data source
extension MainMenuController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainMenuView.mainMenuButtons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = mainMenuView.mainMenuButtons[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
}

// MARK: - Table view delegate
extension MainMenuController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 1 {
            orderHistoryButtonTapped?()
        } else {
            if let url = URL(string: "https://t.me/lap42") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}
