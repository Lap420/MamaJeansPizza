//
//  HomePageView.swift
//  Mama Jean's Pizza
//
//  Created by Lap on 23.03.2023.
//

import UIKit
import GameController

class HomePageView: UIView {
    // MARK: - Public methods
    func updateConstraintsForBigScreens() {
        layoutIfNeeded()
        let scrollFrameHeight = scrollView.frame.height
        let scrollContentHeight = scrollView.contentSize.height
        if scrollContentHeight < scrollFrameHeight {
            let newOffset = (scrollFrameHeight - scrollContentHeight - Constants.bigScreenBottomInset) / 2
            rateButton.snp.removeConstraints()
            rateButton.snp.makeConstraints { make in
                make.top.equalTo(pointsCollectionView.snp.bottom).offset(newOffset)
                make.centerX.equalToSuperview()
                make.width.equalToSuperview().multipliedBy(Constants.widthMultiplier)
                make.height.equalTo(rateButton.snp.width).multipliedBy(Constants.rateButtonsRatio)
            }
            bottomButtonsStackView.snp.removeConstraints()
            bottomButtonsStackView.snp.makeConstraints { make in
                make.top.equalTo(rateButton.snp.bottom).offset(newOffset)
                make.bottom.equalToSuperview()
                make.width.equalToSuperview()
                make.height.equalTo(bottomButtonsStackView.snp.width).multipliedBy(Constants.bottomStackRatio)
            }
            layoutIfNeeded()
        }
    }
    
    // MARK: - Public properties
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .white
        scroll.bounces = false
        scroll.showsVerticalScrollIndicator = false
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: GlobalUIConstants.screenWidth, y: 0))
        path.addLine(to: CGPoint(x: GlobalUIConstants.screenWidth, y: 40))
        path.addLine(to: CGPoint(x: 0, y: 80))
        path.close()
        
        let sublayer = CAShapeLayer()
        sublayer.path = path.cgPath
        sublayer.fillColor = GlobalUIConstants.mamaGreenColor.cgColor
        scroll.layer.addSublayer(sublayer)
        return scroll
    }()
    
    let orderAndRepeatStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.spacing = Constants.stackSpacing
        return stack
    }()
    
    let orderNowButton: UIButton = {
       let button = UIButton()
        button.layer.cornerRadius = Constants.cornerRadius
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFill
        button.setImage(UIImage(named: "OrderNow"), for: .normal)
        return button
    }()
    
    let repeatOrderButton: UIButton = {
       let button = UIButton()
        button.layer.cornerRadius = Constants.cornerRadius
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFill
        button.setImage(UIImage(named: "RepeatOrder"), for: .normal)
        return button
    }()
    
    let dealsLabel: UILabel = {
        let label = UILabel()
        label.text = "DEALS"
        label.font = Constants.collectionHeaderFont
        return label
    }()
    
    let dealsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(
            top: 0,
            left: Constants.sectionInset,
            bottom: 0,
            right: Constants.sectionInset)
        layout.minimumInteritemSpacing = Constants.minimumInteritemSpacing
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    let rewardsLabel: UILabel = {
        let label = UILabel()
        label.text = "MAMA REWARDS"
        label.font = Constants.collectionHeaderFont
        return label
    }()
    
    let rewardsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(
            top: 0,
            left: Constants.sectionInset,
            bottom: 0,
            right: Constants.sectionInset)
        layout.minimumInteritemSpacing = Constants.minimumInteritemSpacing
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    let useYourPointsLabel: UILabel = {
        let label = UILabel()
        label.text = "USE YOUR MAMA POINTS"
        label.font = Constants.collectionHeaderFont
        return label
    }()
    
    let pointsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(
            top: 0,
            left: Constants.sectionInset,
            bottom: 0,
            right: Constants.sectionInset)
        layout.minimumInteritemSpacing = Constants.minimumInteritemSpacing
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    let rateButton: UIButton = {
       let button = UIButton()
        button.layer.cornerRadius = Constants.rateButtonCornerRadius
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFill
        button.setImage(UIImage(named: "RateOurApp"), for: .normal)
        return button
    }()
    
    let bottomButtonsStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.spacing = Constants.stackSpacing
        stack.backgroundColor = GlobalUIConstants.mamaGreenColor
        return stack
    }()
    
    let instagramButton: UIButton = {
       let button = UIButton()
        button.layer.cornerRadius = Constants.cornerRadius
        button.setTitle("Instagram", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = Constants.bottomButtonsFont
        return button
    }()
    
    let facebookButton: UIButton = {
       let button = UIButton()
        button.layer.cornerRadius = Constants.cornerRadius
        button.setTitle("Facebook", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = Constants.bottomButtonsFont
        return button
    }()
    
    let linkedinButton: UIButton = {
       let button = UIButton()
        button.layer.cornerRadius = Constants.cornerRadius
        button.setTitle("LinkedIn", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = Constants.bottomButtonsFont
        return button
    }()
    
    let tempView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
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
        static let stackSpacing: CGFloat = GlobalUIConstants.screenWidth * 0.05
        static let cornerRadius: CGFloat = 10
        static let collectionHeaderFont: UIFont = .systemFont(ofSize: 16, weight: .semibold)
        static let sectionInset: CGFloat = GlobalUIConstants.screenWidth * 0.05
        static let minimumInteritemSpacing: CGFloat = GlobalUIConstants.screenWidth * 0.025
        static let afterLabelCollectionInset: CGFloat = 8
        static let rateButtonCornerRadius: CGFloat = 20
        static let bottomButtonsFont: UIFont = .systemFont(ofSize: 15, weight: .regular)
        static let topScrollInset: CGFloat = 32
        static let mainInset: CGFloat = 24
        static let widthMultiplier: CGFloat = 0.9
        static let topButtonsRatio: CGFloat = 9.0 / 21.0
        static let rateButtonsRatio: CGFloat = 9.0 / 49.0
        static let bottomStackRatio: CGFloat = 1.0 / 7.0
        static let bigScreenBottomInset: CGFloat = 69
    }
}

private extension HomePageView {
    // MARK: - Private methods
    func setup() {
        backgroundColor = GlobalUIConstants.mamaGreenColor

        self.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(orderAndRepeatStack)
        orderAndRepeatStack.addArrangedSubview(orderNowButton)
        orderAndRepeatStack.addArrangedSubview(repeatOrderButton)
        orderAndRepeatStack.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.topScrollInset)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(Constants.widthMultiplier)
            make.height.equalTo(orderNowButton.snp.width).multipliedBy(Constants.topButtonsRatio)
        }
        
        scrollView.addSubview(dealsLabel)
        dealsLabel.snp.makeConstraints { make in
            make.top.equalTo(orderAndRepeatStack.snp.bottom).offset(Constants.mainInset)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(Constants.widthMultiplier)
        }
        
        scrollView.addSubview(dealsCollectionView)
        dealsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(dealsLabel.snp.bottom).offset(Constants.afterLabelCollectionInset)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(HomePageCollectionSizes.dealsSize.height + 1)
        }
        
        scrollView.addSubview(rewardsLabel)
        rewardsLabel.snp.makeConstraints { make in
            make.top.equalTo(dealsCollectionView.snp.bottom).offset(Constants.mainInset)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(Constants.widthMultiplier)
        }
        
        scrollView.addSubview(rewardsCollectionView)
        rewardsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(rewardsLabel.snp.bottom).offset(Constants.afterLabelCollectionInset)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(HomePageCollectionSizes.rewardsSize.height + 1)
        }
        
        scrollView.addSubview(useYourPointsLabel)
        useYourPointsLabel.snp.makeConstraints { make in
            make.top.equalTo(rewardsCollectionView.snp.bottom).offset(Constants.mainInset)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(Constants.widthMultiplier)
        }
        
        scrollView.addSubview(pointsCollectionView)
        pointsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(useYourPointsLabel.snp.bottom).offset(Constants.afterLabelCollectionInset)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(HomePageCollectionSizes.pointsSize.height + 1)
        }
        
        scrollView.addSubview(rateButton)
        rateButton.snp.makeConstraints { make in
            make.top.equalTo(pointsCollectionView.snp.bottom).offset(Constants.mainInset)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(Constants.widthMultiplier)
            make.height.equalTo(rateButton.snp.width).multipliedBy(Constants.rateButtonsRatio)
        }
        
        scrollView.addSubview(bottomButtonsStackView)
        bottomButtonsStackView.addArrangedSubview(instagramButton)
        bottomButtonsStackView.addArrangedSubview(facebookButton)
        bottomButtonsStackView.addArrangedSubview(linkedinButton)
        bottomButtonsStackView.snp.makeConstraints { make in
            make.top.equalTo(rateButton.snp.bottom).offset(Constants.mainInset)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(bottomButtonsStackView.snp.width).multipliedBy(Constants.bottomStackRatio)
        }
    }
}

enum HomePageCollectionSizes {
    static let cellHeightCoef: CGFloat = 1 + (GlobalUIConstants.screenWidth - 320) / 480
    static let dealsSize = CGSize(width: 160 * cellHeightCoef, height: 100 * cellHeightCoef)
    static let rewardsSize = CGSize(width: 140 * cellHeightCoef, height: 117 * cellHeightCoef)
    static let pointsSize = CGSize(width: 90 * cellHeightCoef, height: 90 * cellHeightCoef)
}
