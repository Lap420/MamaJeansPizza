//
//  HomePageView.swift
//  Mama Jean's Pizza
//
//  Created by Lap on 23.03.2023.
//

import UIKit
import GameController

class HomePageView: UIView {
    // MARK: - Public properties
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .white
        scroll.bounces = false
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: UIConstants.screenWidth, y: 0))
        path.addLine(to: CGPoint(x: UIConstants.screenWidth, y: 40))
        path.addLine(to: CGPoint(x: 0, y: 80))
        path.close()
        
        let sublayer = CAShapeLayer()
        sublayer.path = path.cgPath
        sublayer.fillColor = UIConstants.mamaGreenColor.cgColor
        scroll.layer.addSublayer(sublayer)
        return scroll
    }()
    
    let orderAndRepeatStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.spacing = UIConstants.screenWidth * 0.05
        return stack
    }()
    
    let orderNowButton: UIButton = {
       let button = UIButton()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFill
        button.setImage(UIImage(named: "OrderNow"), for: .normal)
        return button
    }()
    
    let repeatOrderButton: UIButton = {
       let button = UIButton()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFill
        button.setImage(UIImage(named: "RepeatOrder"), for: .normal)
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
        static let inset: CGFloat = 16
        static let spacing: CGFloat = 16
        static let itemHeight: CGFloat = 56
    }
}

private extension HomePageView {
    // MARK: - Private methods
    func setup() {
        backgroundColor = UIConstants.mamaGreenColor

        self.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            //make.top.equalTo(self.snp.top).inset(UIConstants.statusBarHeigh)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(orderAndRepeatStack)
        orderAndRepeatStack.addArrangedSubview(orderNowButton)
        orderAndRepeatStack.addArrangedSubview(repeatOrderButton)
        orderAndRepeatStack.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(orderNowButton.snp.width).multipliedBy(9.0 / 21.0)
        }
        
        scrollView.addSubview(tempView)
        tempView.snp.makeConstraints { make in
            make.top.equalTo(orderAndRepeatStack.snp.bottom)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(900)
        }
    }
}
