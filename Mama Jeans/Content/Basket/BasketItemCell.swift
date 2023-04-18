import UIKit
import SnapKit

class BasketItemCell: UITableViewCell {
    // MARK: - Public methods
    func configure(viewController: UIViewController, item: BasketItem, image: UIImage?) {
        self.item = item
        itemImageView.image = image
        nameLabel.text = item.name
        minusButton.isEnabled = item.amount != 1
        itemQtyLabel.text = "\(item.amount)"
        let textPrice = String(format: "%.2f AED", item.price * Double(item.amount))
        itemTotalLabel.text = "\(textPrice)"
        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    func itemQtyChanged() {
        guard let item = item else { return }
        minusButton.isEnabled = item.amount != 1
        itemQtyLabel.text = "\(item.amount)"
        let textPrice = String(format: "%.2f AED", item.price * Double(item.amount))
        itemTotalLabel.text = "\(textPrice)"
    }
    
    @objc
    func minusButtonTapped() {
        guard item!.amount > 1 else { return }
        item?.amount -= 1
        delegate?.basketItemCellDidDecreaseQuantity(self)
    }
    
    @objc
    func plusButtonTapped() {
        item?.amount += 1
        delegate?.basketItemCellDidIncreaseQuantity(self)
    }
    
    @objc
    func deleteButtonTapped() {
        delegate?.basketItemCellDidDelete(self)
    }
    
    // MARK: - Public properties
    weak var delegate: BasketItemCellDelegate?
    var item: BasketItem?
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private constants
    private enum UIConstants {
        static let mainInset: CGFloat = 16
        static let halfInset: CGFloat = 8
        static let imageHeight: CGFloat = 80
        static let nameLabelFont: UIFont = .systemFont(ofSize: 17, weight: .bold)
        static let bottomFont: UIFont = .systemFont(ofSize: 17)
    }
    
    // MARK: - Private properties
    private let itemImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .lightGray
        view.clipsToBounds = true
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIConstants.nameLabelFont
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        var conf = UIButton.Configuration.plain()
        conf.image = .init(systemName: "xmark")
        conf.buttonSize = .medium
        button.configuration = conf
        return button
    }()
    
    private let bottomMainStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private let bottomSubStack: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    
    private let minusButton: UIButton = {
        let button = UIButton()
        var conf = UIButton.Configuration.plain()
        conf.image = .init(systemName: "minus.circle")
        conf.buttonSize = .medium
        conf.baseForegroundColor = GlobalUIConstants.mamaGreenColor
        button.configuration = conf
        return button
    }()
    
    private let itemQtyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIConstants.bottomFont
        label.text = "0"
        return label
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton()
        var conf = UIButton.Configuration.plain()
        conf.image = .init(systemName: "plus.circle")
        conf.buttonSize = .medium
        conf.baseForegroundColor = GlobalUIConstants.mamaGreenColor
        button.configuration = conf
        return button
    }()
    
    private let itemTotalLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIConstants.bottomFont
        label.textColor = GlobalUIConstants.mamaGreenColor
        label.text = "0.00 AED"
        return label
    }()
}

// MARK: - Private methods
extension BasketItemCell {
    private func initialize() {
        selectionStyle = .none
    
        contentView.addSubview(itemImageView)
        itemImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(UIConstants.halfInset)
            make.leading.equalToSuperview().inset(UIConstants.mainInset)
            make.width.height.equalTo(UIConstants.imageHeight)
        }
        
        contentView.addSubview(deleteButton)
        deleteButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().inset(UIConstants.halfInset)
            make.width.equalTo(40)
        }
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIConstants.halfInset)
            make.leading.equalTo(itemImageView.snp.trailing).offset(UIConstants.halfInset)
            make.trailing.equalTo(deleteButton.snp.leading).offset(UIConstants.halfInset)
        }
        
        bottomSubStack.addArrangedSubview(minusButton)
        bottomSubStack.addArrangedSubview(itemQtyLabel)
        bottomSubStack.addArrangedSubview(plusButton)
        
        itemQtyLabel.snp.makeConstraints { make in
            make.width.equalTo(21)
        }
        
        bottomMainStack.addArrangedSubview(bottomSubStack)
        bottomMainStack.addArrangedSubview(itemTotalLabel)
        
        contentView.addSubview(bottomMainStack)
        bottomMainStack.snp.makeConstraints { make in
            make.leading.equalTo(itemImageView.snp.trailing)
            make.bottom.equalToSuperview().inset(UIConstants.halfInset)
            make.trailing.equalToSuperview().inset(UIConstants.mainInset)
            make.height.equalTo(30)
        }
    }
}

protocol BasketItemCellDelegate: AnyObject {
    func basketItemCellDidDecreaseQuantity(_ cell: BasketItemCell)
    func basketItemCellDidIncreaseQuantity(_ cell: BasketItemCell)
    func basketItemCellDidDelete(_ cell: BasketItemCell)
}
