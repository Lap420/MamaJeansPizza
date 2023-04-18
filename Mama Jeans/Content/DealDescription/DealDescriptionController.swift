// TODO: Corner radius for tableview?

import UIKit

class DealDescriptionController: UIViewController {
    // MARK: - Public properties
    var image: UIImage?
    var dealName = ""
    var dealDescription = ""
    var didOrderButtonClicked: (() -> ())?
    
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    // MARK: - Private properties
    private let dealDescriptionView = DealDescriptionView()
}

// MARK: - Private methods
private extension DealDescriptionController {
    func initialize() {
        view = dealDescriptionView
        initButtonTargets()
        initTableView()
    }
    
    func initButtonTargets() {
        dealDescriptionView.orderButton.addTarget(
            self,
            action: #selector(orderButtonTapped),
            for: .touchUpInside
        )
        dealDescriptionView.backButton.addTarget(
            self,
            action: #selector(backButtonTapped),
            for: .touchUpInside
        )
    }
    
    func initTableView() {
        dealDescriptionView.headerImageView.image = image
        dealDescriptionView.tableView.dataSource = self
        dealDescriptionView.tableView.register(
            DealDescriptionCell.self,
            forCellReuseIdentifier: "cell"
        )
    }
    
    @objc
    func orderButtonTapped() {
        dismiss(animated: true) {
            self.didOrderButtonClicked?()
        }
    }
    
    @objc
    func backButtonTapped() {
        dismiss(animated: true)
    }
}

// MARK: - Table view data source
extension DealDescriptionController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DealDescriptionCell
        cell.configure(name: dealName, description: dealDescription)
        return cell
    }
}
