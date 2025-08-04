//
//  InviteView.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 04/08/25.
//  
//

import UIKit

class InviteView: TemplateView {
    // MARK: - Callbacks
    var onButtonTapped: (() -> Void)?
    var onCancelTapped: (() -> Void)?

    private let purpleTheme = PurpleTheme()

    // MARK: - UI Components
    private let modalContainerView = UIView()
    private let linkIconContainerView = UIView()
    private let linkIconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let linkDisplayView = UIView()
    private let linkTextLabel = UILabel()
    private let copyIconImageView = UIImageView()
    private let actionButton = UIButton(type: .system)
    private let gradientLayer = CAGradientLayer()
    private let cancelButton = UIButton(type: .system)

    // MARK: - Initialization
    override func initialize() {
        super.initialize()
        setupUI()
        updateTheme()
    }

    // MARK: - Frame Layout
    override func updateSubviewsFrame(_ size: CGSize) {
        super.updateSubviewsFrame(size)

        let horizontalPadding: CGFloat = 16
        let modalWidth = size.width - (horizontalPadding * 2)
        
        var requiredHeight: CGFloat = 0
        let contentWidth = modalWidth - (horizontalPadding * 2)

        requiredHeight += 32
        requiredHeight += 92
        requiredHeight += 24

        let titleHeight = titleLabel.sizeThatFits(CGSize(width: contentWidth, height: .greatestFiniteMagnitude)).height
        requiredHeight += titleHeight
        requiredHeight += 16

        let descriptionHeight = descriptionLabel.sizeThatFits(CGSize(width: contentWidth, height: .greatestFiniteMagnitude)).height
        requiredHeight += descriptionHeight
        requiredHeight += 16

        requiredHeight += 56
        requiredHeight += 16
        requiredHeight += 50
        requiredHeight += 16
        requiredHeight += 50
        requiredHeight += 32

        let modalHeight = requiredHeight
        let modalY = size.height - modalHeight - 32
        
        modalContainerView.frame = CGRect(x: horizontalPadding, y: modalY, width: modalWidth, height: modalHeight)


        var currentY: CGFloat = 32

        linkIconContainerView.frame = CGRect(x: (modalWidth - 92) / 2, y: currentY, width: 92, height: 92)
        linkIconImageView.frame = linkIconContainerView.bounds.insetBy(dx: 18, dy: 18)
        currentY += linkIconContainerView.frame.height + 24

        titleLabel.frame = CGRect(x: horizontalPadding, y: currentY, width: contentWidth, height: titleHeight)
        currentY += titleLabel.frame.height + 16

        descriptionLabel.frame = CGRect(x: horizontalPadding, y: currentY, width: contentWidth, height: descriptionHeight)
        currentY += descriptionLabel.frame.height + 16

        linkDisplayView.frame = CGRect(x: horizontalPadding, y: currentY, width: contentWidth, height: 56)
        linkTextLabel.frame = CGRect(x: 16, y: 0, width: contentWidth - 32 - 24, height: 56)
        copyIconImageView.frame = CGRect(x: linkDisplayView.bounds.width - 16 - 24, y: (56 - 24) / 2, width: 24, height: 24)
        currentY += linkDisplayView.frame.height + 16

        actionButton.frame = CGRect(x: horizontalPadding, y: currentY, width: contentWidth, height: 50)
        gradientLayer.frame = actionButton.bounds
        currentY += actionButton.frame.height + 16
        
        cancelButton.frame = CGRect(x: horizontalPadding, y: currentY, width: contentWidth, height: 50)
    }

    // MARK: - Theme & Style Setup
    override func updateTheme() {
        super.updateTheme()
        
        self.backgroundColor = purpleTheme.backgroundColor.withAlphaComponent(0.6)
        modalContainerView.backgroundColor = purpleTheme.bgWhiteTransparent10
        linkIconContainerView.backgroundColor = purpleTheme.contentPurple
        linkIconImageView.image = purpleTheme.linkIcon
        
        titleLabel.font = purpleTheme.onestFont(size: 18, weight: .bold)
        titleLabel.textColor = purpleTheme.contentWhite
        
        descriptionLabel.font = purpleTheme.onestFont(size: 16, weight: .regular)
        descriptionLabel.textColor = purpleTheme.contentWhite
        
        linkDisplayView.backgroundColor = purpleTheme.bgBlackTransparent20
        linkTextLabel.font = purpleTheme.onestFont(size: 16, weight: .regular)
        linkTextLabel.textColor = purpleTheme.contentWhite
        
        copyIconImageView.image = purpleTheme.copyIcon
        copyIconImageView.tintColor = purpleTheme.contentWhite
        
        actionButton.titleLabel?.font = purpleTheme.onestFont(size: 16, weight: .bold)
        actionButton.setTitleColor(purpleTheme.contentWhite, for: .normal)
        gradientLayer.colors = [purpleTheme.pinkGradientUpColor.cgColor, purpleTheme.pinkGradientDownColor.cgColor]

        cancelButton.titleLabel?.font = purpleTheme.onestFont(size: 16, weight: .bold)
        cancelButton.setTitleColor(purpleTheme.contentWhite, for: .normal)
    }

    // MARK: - Private Setup Helpers
    private func setupUI() {
        addSubview(modalContainerView)
        [linkIconContainerView, titleLabel, descriptionLabel, linkDisplayView, actionButton, cancelButton].forEach { modalContainerView.addSubview($0) }
        linkIconContainerView.addSubview(linkIconImageView)
        linkDisplayView.addSubview(linkTextLabel)
        linkDisplayView.addSubview(copyIconImageView)


        modalContainerView.layer.cornerRadius = 40
        linkIconContainerView.layer.cornerRadius = 46
        
        titleLabel.text = "Invite link"
        titleLabel.textAlignment = .center
        
        descriptionLabel.text = "Everyone who is registered in the Tedr app will receive an invitation to join this group."
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        
        linkDisplayView.layer.cornerRadius = 16
        linkTextLabel.text = "Tedr.me/719ATempLaTe"
        copyIconImageView.contentMode = .scaleAspectFit
        
        actionButton.setTitle("Button", for: .normal)
        actionButton.layer.cornerRadius = 25
        actionButton.layer.masksToBounds = true
        actionButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        actionButton.layer.insertSublayer(gradientLayer, at: 0)
        
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.backgroundColor = .clear
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        onButtonTapped?()
    }
    
    @objc private func cancelTapped() {
        onCancelTapped?()
    }
}
