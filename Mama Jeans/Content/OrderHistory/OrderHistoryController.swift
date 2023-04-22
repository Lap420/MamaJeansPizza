import UIKit

class OrderHistoryController: UIViewController {
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // MARK: - Private properties
    private let orderHistoryView = OrderHistoryView()
    private lazy var orderHistoryModel = OrderHistoryModel(context)
    private lazy var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
}

// MARK: - Private methods
private extension OrderHistoryController {
    func initialize() {
        view = orderHistoryView
        self.title = "Order history"
        checkPreviousOrders()
        initTableView()
    }
    
    func checkPreviousOrders() {
        orderHistoryModel.loadOrders()
        guard orderHistoryModel.orders.count == 0 else { return }
        let alert = AlertManager.emptyOrderHistoryAlert() { _ in
            self.navigationController?.popViewController(animated: true)
        }
        present(alert, animated: true)
    }
    
    func initTableView() {
        orderHistoryView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        orderHistoryView.tableView.dataSource = self
        orderHistoryView.tableView.delegate = self
    }
}

extension OrderHistoryController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderHistoryModel.orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        guard let date = orderHistoryModel.orders[indexPath.row].date else { return cell }
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            return formatter
        }()
        content.text = dateFormatter.string(from: date)
        content.secondaryText = "2"
        cell.contentConfiguration = content
        return cell
    }
}

extension OrderHistoryController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let nextVC = MenuController()
//        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
