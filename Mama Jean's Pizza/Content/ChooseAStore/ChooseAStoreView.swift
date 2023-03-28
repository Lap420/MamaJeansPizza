import UIKit

class ChooseAStoreView: UIView {
    // MARK: - Public properties
    let storesTableView: UITableView = {
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
private extension ChooseAStoreView {
    func setup() {
        backgroundColor = GlobalUIConstants.mamaGreenColor

        self.addSubview(storesTableView)
        storesTableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
