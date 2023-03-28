import UIKit

class DealCell: UICollectionViewCell {
    //MARK: - Public methods
    func configure(image: UIImage?) {
        imageView.image = image
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private properties
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
}

//MARK: - Private methods
private extension DealCell {
    func initialize() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
        layer.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.1)
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
