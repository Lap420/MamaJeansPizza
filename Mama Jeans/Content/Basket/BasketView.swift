import UIKit

class BasketView: UIView {
    // MARK: - Public properties
    let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .white
        return view
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let orderButton: UIButton = {
        let button = UIButton()
        var conf = UIButton.Configuration.filled()
        conf.title = "Check out"
        conf.titleAlignment = .center
        conf.baseBackgroundColor = GlobalUIConstants.mamaGreenColor
        conf.buttonSize = .medium
        conf.imagePadding = 8
        button.configuration = conf
        return button
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
private extension BasketView {
    func setup() {
        backgroundColor = GlobalUIConstants.mamaGreenColor
        
        self.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        bottomView.addSubview(orderButton)
        orderButton.snp.makeConstraints { make in
            make.top.equalTo(bottomView.snp.top).inset(16)
            make.bottom.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(bottomView.snp.top)
            make.leading.trailing.equalToSuperview()
        }
    }
}
