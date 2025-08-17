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
        let modalWidth = size.width - horizontalPadding * 2
        let contentWidth = modalWidth - horizontalPadding * 2

        // Calculate dynamic heights
        let titleHeight = titleLabel.sizeThatFits(CGSize(width: contentWidth, height: .greatestFiniteMagnitude)).height
        let descriptionHeight = descriptionLabel.sizeThatFits(CGSize(width: contentWidth, height: .greatestFiniteMagnitude)).height

        // Spacing and fixed sizes
        let topSpacing: CGFloat = 32
        let iconSize: CGFloat = 92
        let iconBottomSpacing: CGFloat = 24
        let titleBottomSpacing: CGFloat = 16
        let descriptionBottomSpacing: CGFloat = 16
        let linkViewHeight: CGFloat = 56
        let linkBottomSpacing: CGFloat = 16
        let actionButtonHeight: CGFloat = 50
        let actionBottomSpacing: CGFloat = 16
        let cancelButtonHeight: CGFloat = 50
        let bottomSpacing: CGFloat = 32

        // Sum all heights and spacings
        let heightComponents: [CGFloat] = [
            topSpacing,
            iconSize,
            iconBottomSpacing,
            titleHeight,
            titleBottomSpacing,
            descriptionHeight,
            descriptionBottomSpacing,
            linkViewHeight,
            linkBottomSpacing,
            actionButtonHeight,
            actionBottomSpacing,
            cancelButtonHeight,
            bottomSpacing
        ]

        let requiredHeight = heightComponents.reduce(0, +)

        // Position modal at bottom with 32pt margin
        let modalY = size.height - requiredHeight - 32
        modalContainerView.frame = CGRect(x: horizontalPadding, y: modalY, width: modalWidth, height: requiredHeight)

        // Layout subviews inside modal
        var currentY: CGFloat = topSpacing

        linkIconContainerView.frame = CGRect(x: (modalWidth - iconSize) / 2, y: currentY, width: iconSize, height: iconSize)
        linkIconImageView.frame = linkIconContainerView.bounds.insetBy(dx: 18, dy: 18)
        currentY += iconSize + iconBottomSpacing

        titleLabel.frame = CGRect(x: horizontalPadding, y: currentY, width: contentWidth, height: titleHeight)
        currentY += titleHeight + titleBottomSpacing

        descriptionLabel.frame = CGRect(x: horizontalPadding, y: currentY, width: contentWidth, height: descriptionHeight)
        currentY += descriptionHeight + descriptionBottomSpacing

        linkDisplayView.frame = CGRect(x: horizontalPadding, y: currentY, width: contentWidth, height: linkViewHeight)
        linkTextLabel.frame = CGRect(x: 16, y: 0, width: contentWidth - 32 - 24, height: linkViewHeight)
        copyIconImageView.frame = CGRect(x: linkDisplayView.bounds.width - 16 - 24, y: (linkViewHeight - 24) / 2, width: 24, height: 24)
        currentY += linkViewHeight + linkBottomSpacing

        actionButton.frame = CGRect(x: horizontalPadding, y: currentY, width: contentWidth, height: actionButtonHeight)
        gradientLayer.frame = actionButton.bounds
        currentY += actionButtonHeight + actionBottomSpacing

        cancelButton.frame = CGRect(x: horizontalPadding, y: currentY, width: contentWidth, height: cancelButtonHeight)
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
        linkIconContainerView.clipsToBounds = true

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

    // MARK: - Actions
    @objc private func buttonTapped() {
        onButtonTapped?()
    }

    @objc private func cancelTapped() {
        onCancelTapped?()
    }
}
