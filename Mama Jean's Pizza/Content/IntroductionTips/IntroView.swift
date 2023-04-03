import UIKit

class IntroView: UIView {
    // MARK: - Public properties
    
    let skipIntroButton: UIButton = {
       let button = UIButton()
        button.layer.cornerRadius = Constants.cornerRadius
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(GlobalUIConstants.mamaGreenColor, for: .normal)
        return button
    }()
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.headerFont
        label.textColor = GlobalUIConstants.mamaGreenColor
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.bodyFont
        label.textColor = GlobalUIConstants.mamaGreenColor
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let finishIntroButton: UIButton = {
       let button = UIButton()
        button.layer.cornerRadius = Constants.cornerRadius
        button.setTitle("Get my 100 points\nand let's get started!", for: .normal)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = GlobalUIConstants.mamaGreenColor
        return button
    }()
    
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = GlobalUIConstants.mamaGreenColor
        pageControl.isUserInteractionEnabled = false
        return pageControl
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
    private enum Constants {
        static let cornerRadius: CGFloat = 25
        static let headerFont: UIFont = .systemFont(ofSize: 24, weight: .bold)
        static let bodyFont: UIFont = .systemFont(ofSize: 20, weight: .regular)
        static let mainInset: CGFloat = 32
        static let skipButtonInset: CGFloat = 24
        static let headerTopInset: CGFloat = GlobalUIConstants.screenHeight * 0.25
        static let bodyTopInset: CGFloat = GlobalUIConstants.screenHeight * 0.10
        static let finishButtonInset: CGFloat = GlobalUIConstants.screenHeight * 0.10
        static let finishButtonHeight: CGFloat = 50
        static let finishButtonWidth: CGFloat = 228
    }
}

// MARK: - Private methods
private extension IntroView {
    func setup() {
        backgroundColor = .white

        self.addSubview(skipIntroButton)
        skipIntroButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(safeAreaLayoutGuide).inset(Constants.skipButtonInset)
        }
        
        self.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.headerTopInset)
            make.leading.trailing.equalToSuperview().inset(Constants.mainInset)
        }
        
        self.addSubview(bodyLabel)
        bodyLabel.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(Constants.bodyTopInset)
            make.leading.trailing.equalToSuperview().inset(Constants.mainInset)
        }
        
        self.addSubview(finishIntroButton)
        finishIntroButton.snp.makeConstraints { make in
            make.top.equalTo(bodyLabel.snp.bottom).offset(Constants.finishButtonInset)
            make.centerX.equalToSuperview()
            make.height.equalTo(Constants.finishButtonHeight)
            make.width.equalTo(Constants.finishButtonWidth)
        }
        
        self.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide).inset(Constants.mainInset)
        }
    }
}
