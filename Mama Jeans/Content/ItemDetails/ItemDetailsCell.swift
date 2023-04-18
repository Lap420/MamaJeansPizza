import SnapKit
import UIKit

class ItemDetailsCell: UITableViewCell {
    //MARK: - Public methods
    func configure(name: String, description: String) {
        nameLabel.text = name
        descriptionLabel.text = description
    }
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private properties
    private enum Constants {
        static let nameLabelFont: UIFont = .systemFont(ofSize: 23, weight: .bold)
        static let descriptionLabelFont: UIFont = .systemFont(ofSize: 17)
        static let mainContentColor: UIColor = .systemGray
        static let mainInset: CGFloat = 16
        static let afterNameInset: CGFloat = 24
    }
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.nameLabelFont
        label.textColor = Constants.mainContentColor
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.descriptionLabelFont
        label.textColor = Constants.mainContentColor
        label.numberOfLines = 0
        return label
    }()
}

//MARK: - Private methods
private extension ItemDetailsCell {
    func initialize() {
        selectionStyle = .none

        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(Constants.mainInset)
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(Constants.afterNameInset)
            make.bottom.leading.trailing.equalToSuperview().inset(Constants.mainInset)
        }
    }
}
