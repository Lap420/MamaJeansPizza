import UIKit

class OrderHistoryView: UIView {
    // MARK: - Public properties
    let tableView: UITableView = {
        let table = UITableView()
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    // MARK: - View Lifecycle
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods
private extension OrderHistoryView {
    func setup() {
        backgroundColor = GlobalUIConstants.mamaGreenColor

        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
