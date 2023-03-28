import UIKit

class MenuCell: UICollectionViewCell {
    //MARK: - Public methods
    func configure(name: String, image: UIImage?) {
        imageView.image = image
        nameLabel.text = name
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
        static let labelBackgroundColor: UIColor = .init(red: 94/255, green: 94/255, blue: 94/255, alpha: 0.6)
        static let labelTextColor: UIColor = .systemGray6
        static let labelTextFont: UIFont = .systemFont(ofSize: 18, weight: .bold)
    }
    
    //MARK: - Private properties
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = Constants.labelBackgroundColor
        label.textColor = Constants.labelTextColor
        label.font = Constants.labelTextFont
        label.textAlignment = .center
        return label
    }()
}

//MARK: - Private methods
private extension MenuCell {
    func initialize() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
        layer.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.1)
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        imageView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
