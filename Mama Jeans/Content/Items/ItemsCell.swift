import UIKit

class ItemCell: UICollectionViewCell {
    //MARK: - Public methods
    func configure(name: String, price: String, image: UIImage?) {
        imageView.image = image
        nameLabel.text = name
        priceLabel.text = price
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private properties
    private enum Constants {
        static let textColor: UIColor = .systemGray2
        static let textFont: UIFont = .systemFont(ofSize: 14, weight: .semibold)
    }
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = Constants.textFont
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        label.font = Constants.textFont
        label.textAlignment = .center
        return label
    }()
}

//MARK: - Private methods
private extension ItemCell {
    func initialize() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = GlobalUIConstants.mamaGreenColor.cgColor
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(imageView.snp.width).multipliedBy(0.7)
        }
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).inset(8)
            make.leading.trailing.equalToSuperview()
        }
        contentView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).inset(16)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(8)
        }
    }
}
