import UIKit
import SnapKit

class BasketItemCell: UITableViewCell {
    // MARK: - Public methods
    func configure(viewController: UIViewController, item: BasketItem, image: UIImage?) {
        itemImageView.image = image
        nameLabel.text = item.name
    }
    
    // MARK: - Public properties
    let deleteButton: UIButton = {
        let button = UIButton()
        var conf = UIButton.Configuration.plain()
        conf.image = .init(systemName: "xmark")
        conf.buttonSize = .medium
        button.configuration = conf
        return button
    }()
    
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
    }
}
