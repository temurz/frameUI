//
//  FloatingTabBarDelegate.swift
//  Tedr
//
//  Created by Temur on 17/05/2025.
//


import UIKit

protocol FloatingTabBarDelegate: AnyObject {
    func didSelectTab(index: Int)
}

class FloatingTabBarView: TemplateView {
    
    enum Constants {
        static let spacing = CGFloat(12)
        static let itemWidth = CGFloat(48)
    }

    weak var delegate: FloatingTabBarDelegate?

    private let backgroundView = UIView()
    private let leftButton = UIButton(type: .custom)
    private let rightButton = UIButton(type: .custom)
    private let centerButton = UIButton(type: .custom)
    
    let items: [FloatingTabBarItem]
    var selectedTag: Int

    init(items: [FloatingTabBarItem], selectedTag: Int = 0) {
        self.items = items
        self.selectedTag = selectedTag
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func initialize() {
        backgroundColor = .clear
        let theme = theme ?? Theme()
        // Container background
        backgroundView.backgroundColor = theme.tabbarUnionBackgroundColor
        backgroundView.addShadow(shadowColor: .black, radius: 4, width: 0, height: 2)
        addSubview(backgroundView)

        // Buttons
        leftButton.setImage(theme.walletIcon, for: .normal)
        leftButton.tintColor = theme.whiteColor
        leftButton.tag = 0
        leftButton.addTarget(self, action: #selector(tabTapped(_:)), for: .touchUpInside)
        addSubview(leftButton)

        centerButton.setImage(theme.servicesIcon, for: .normal)
        centerButton.tintColor = theme.whiteColor
        centerButton.tag = 1
        centerButton.addTarget(self, action: #selector(tabTapped(_:)), for: .touchUpInside)
        addSubview(centerButton)
        
        rightButton.setImage(theme.chatIcon, for: .normal)
        rightButton.tintColor = theme.whiteColor
        rightButton.tag = 2
        rightButton.addTarget(self, action: #selector(tabTapped(_:)), for: .touchUpInside)
        addSubview(rightButton)
    }

    override func updateSubviewsFrame(_ size: CGSize) {
        var w = size.width
        var h = size.height
        var x = CGFloat.zero
        var y = CGFloat.zero
        backgroundView.frame = CGRect(x: x, y: y, width: w, height: h)
        backgroundView.layer.cornerRadius = 36

        w = Constants.itemWidth
        h = w
        x = 16
        y = backgroundView.centerY - h / 2
        leftButton.frame = CGRect(x: x, y: y, width: w, height: h)
        leftButton.borderRadius = 24

        x = size.width - 16 - w
        rightButton.frame = CGRect(x: x, y: y, width: w, height: h)
        rightButton.borderRadius = 24

        x = backgroundView.center.x - w / 2
        centerButton.frame = CGRect(x: x, y: y, width: w, height: h)
        centerButton.borderRadius = 24
        
        makeSelected(tag: selectedTag)
    }
    
    func getWidth() -> CGFloat {
        return CGFloat(items.count) * (Constants.spacing + Constants.itemWidth) + Constants.spacing
    }

    @objc private func tabTapped(_ sender: UIButton) {
        makeSelected(tag: sender.tag)
        delegate?.didSelectTab(index: sender.tag)
    }
    
    private func makeSelected(tag: Int) {
        selectedTag = tag
        let theme = theme ?? Theme()
        switch tag {
        case 0:
            UIView.animate(withDuration: 1.0) { [weak self] in
                guard let self else { return }
                centerButton.removeGradient()
                rightButton.removeGradient()
                
                leftButton.addGradient(topColor: theme.pinkGradientDownColor, bottomColor: theme.pinkGradientUpColor)
            }
        case 1:
            UIView.animate(withDuration: 1.0) { [weak self] in
                guard let self else { return }
                leftButton.removeGradient()
                rightButton.removeGradient()
                
                centerButton.addGradient(topColor: theme.pinkGradientDownColor, bottomColor: theme.pinkGradientUpColor)
            }
        default:
            UIView.animate(withDuration: 1.0) { [weak self] in
                guard let self else { return }
                centerButton.removeGradient()
                leftButton.removeGradient()
                   
                rightButton.addGradient(topColor: theme.pinkGradientDownColor, bottomColor: theme.pinkGradientUpColor)
            }
        }
    }
}
