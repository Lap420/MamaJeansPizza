import UIKit

class OrderPlacedView: UIView {
    // MARK: - Public properties
    func configure(_ isSuccess: Bool) {
        let doneHeader = "Done!"
        let doneBody = "The order has been placed successfully!\nWill keep you posted!"
        let oopsHeader = "Oops!"
        let oopsBody = "Something went wrong with order placing.\nPlease open order history and try again. Thanks!"
        if isSuccess {
            headerLabel.text = doneHeader
            bodyLabel.text = doneBody
        } else {
            headerLabel.text = oopsHeader
            bodyLabel.text = oopsBody
        }
    }
    
    // MARK: - Public properties
    let headerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.textColor = .systemGray2
        return label
    }()
    
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .systemGray2
        label.numberOfLines = 4
        return label
    }()
    
    let okayButton: UIButton = {
        let button = UIButton()
        var conf = UIButton.Configuration.filled()
        conf.title = "Okay"
        conf.baseBackgroundColor = GlobalUIConstants.mamaGreenColor
        conf.buttonSize = .large
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
    
    // MARK: - Private properties
    private let centerView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.layoutMargins = .init(top: 16, left: 16, bottom: 16, right: 16)
        view.isLayoutMarginsRelativeArrangement = true
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.shadowOpacity = 0.6
        view.layer.shadowRadius = 7
        view.layer.shadowOffset = .init(width: 0, height: 0)
        return view
    }()
}

// MARK: - Private methods
private extension OrderPlacedView {
    func setup() {
        backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        self.addSubview(centerView)
        centerView.addArrangedSubview(headerLabel)
        centerView.addArrangedSubview(bodyLabel)
        centerView.addArrangedSubview(okayButton)
        centerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.85)
            make.height.equalTo(centerView.snp.width)
        }
    }
}
