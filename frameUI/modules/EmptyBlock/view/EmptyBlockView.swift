//
//  EmptyBlockView.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 16/08/25.
//  
//

import UIKit

class EmptyBlockView: TemplateView {
    // MARK: - UI Components
    private let navBar = UIView()
    private let backButton = UIButton()
    private let titleLabel = UILabel()
    
    private let centerView = UIView()
    private let blockIcon = UIImageView()
    private let emptyTitleLabel = UILabel()
    private let infoButton = UIButton()
    private let blockButton = GradientButton()
    private let bottomLabel = UILabel()
    
    // MARK: - Initialization
    override func initialize() {
        self.theme = self.theme ?? Theme()
        super.initialize()
        setupNavBar()
        setupCenterView()
        setupBottomLabel()
    }
    
    // MARK: - Setup Methods
    private func setupNavBar() {
        // Back button
        backButton.setImage(theme?.arrowLeftIcon, for: .normal)
        backButton.tintColor = theme?.contentPrimary
        backButton.contentHorizontalAlignment = .left
        navBar.addSubview(backButton)
        
        // Title label
        titleLabel.text = "Blocked users"
        titleLabel.font = theme?.onestFont(size: 18, weight: .bold)
        titleLabel.textColor = theme?.contentPrimary
        titleLabel.textAlignment = .center
        navBar.addSubview(titleLabel)
        
        addSubview(navBar)
    }
    
    private func setupCenterView() {
        centerView.backgroundColor = theme?.bgWhiteTransparent10
        centerView.layer.cornerRadius = 40
        
        // Block icon
        blockIcon.image = theme?.blockIcon
        blockIcon.contentMode = .scaleAspectFit
        centerView.addSubview(blockIcon)
        
        // Empty title label
        emptyTitleLabel.text = "You don't have any blocked users yet"
        emptyTitleLabel.font = theme?.onestFont(size: 16, weight: .regular)
        emptyTitleLabel.textColor = theme?.contentPrimary
        emptyTitleLabel.textAlignment = .center
        emptyTitleLabel.numberOfLines = 0
        centerView.addSubview(emptyTitleLabel)
        
        // Info button (plain style)
        infoButton.setTitle("Button", for: .normal)
        infoButton.titleLabel?.font = theme?.onestFont(size: 16, weight: .bold)
        infoButton.setTitleColor(theme?.contentWhite, for: .normal)
        centerView.addSubview(infoButton)
        
        addSubview(centerView)
    }
    
    private func setupBottomLabel() {
        // Block button (gradient style)
        blockButton.setTitle("Block user", for: .normal)
        blockButton.titleLabel?.font = theme?.onestFont(size: 18, weight: .bold)
        blockButton.setTitleColor(theme?.contentWhite, for: .normal)
        blockButton.cornerRadius = 30
        blockButton.gradientColors = [theme?.pinkGradientUpColor, theme?.pinkGradientDownColor].compactMap { $0 }
        blockButton.addTarget(self, action: #selector(didTapBlockButton), for: .touchUpInside)
        addSubview(blockButton)
        
        
        // Bottom info label
        bottomLabel.text = "Users blocked from the group by admins can't rejoin via invite link"
        bottomLabel.font = theme?.onestFont(size: 14, weight: .medium)
        bottomLabel.textColor = theme?.contentSecondary
        bottomLabel.textAlignment = .center
        bottomLabel.numberOfLines = 0
        addSubview(bottomLabel)
    }
    
    // MARK: - Button Action
        @objc private func didTapBlockButton() {
            presentAddMembersFloating()
        }
    
      private func presentAddMembersFloating() {
            guard let parentVC = parentViewController else { return }
            
            let modalVC = UIViewController()
            let modalView = ModalBlockMemberView()
            modalView.theme = self.theme
            
            modalVC.view.addSubview(modalView)
            modalView.frame = modalVC.view.bounds
            modalView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            modalVC.modalPresentationStyle = .pageSheet
            
            if let sheet = modalVC.sheetPresentationController {
                sheet.detents = [.large()]
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 24
                sheet.largestUndimmedDetentIdentifier = .large
            }
            
            parentVC.present(modalVC, animated: true)
        }
    
    // MARK: - Layout
    override func updateSubviewsFrame(_ size: CGSize) {
        let horizontalPadding: CGFloat = 16
        let safeAreaTop = safeAreaInsets.top
        
        // Nav bar
        let navBarHeight: CGFloat = 56
        navBar.frame = CGRect(x: 0, y: 0, width: size.width, height: safeAreaTop + navBarHeight)
        
        backButton.frame = CGRect(x: horizontalPadding, y: safeAreaTop, width: 44, height: navBarHeight)
        titleLabel.frame = CGRect(x: 60, y: safeAreaTop, width: size.width - 120, height: navBarHeight)
        
        // Center view (with 16px side padding)
        let centerViewWidth = size.width - (horizontalPadding * 2)
        let centerViewHeight: CGFloat = 208
        
        // Position center view in the middle of available space (below nav bar)
        let availableHeight = size.height - navBar.frame.maxY
        let centerViewY = navBar.frame.maxY + (availableHeight - centerViewHeight - 56 - 16 - 40) / 2
        
        centerView.frame = CGRect(
            x: horizontalPadding,
            y: centerViewY,
            width: centerViewWidth,
            height: centerViewHeight
        )
        
        // Block icon
        blockIcon.frame = CGRect(
            x: (centerViewWidth - 56) / 2,
            y: 24,
            width: 56,
            height: 56
        )
        
        // Empty title label
        emptyTitleLabel.frame = CGRect(
            x: 0,
            y: blockIcon.frame.maxY + 16,
            width: centerViewWidth,
            height: 20
        )
        
        // Info button
        infoButton.frame = CGRect(
            x: 0,
            y: emptyTitleLabel.frame.maxY + 16,
            width: centerViewWidth,
            height: 56
        )
        
        // Bottom label (fixed at bottom with 16pt padding)
           bottomLabel.frame = CGRect(
               x: horizontalPadding,
               y: size.height - 40 - 16 - safeAreaInsets.bottom,
               width: size.width - (horizontalPadding * 2),
               height: 40
           )
           
           // Block button (10pt above bottom label)
           blockButton.frame = CGRect(
               x: horizontalPadding,
               y: bottomLabel.frame.minY - 56 - 10, // 56 is button height, 10 is spacing
               width: size.width - (horizontalPadding * 2),
               height: 56
           )
    }
    
    // MARK: - Theme Update
    override func updateTheme() {
        super.updateTheme()
        backgroundColor = theme?.backgroundPrimaryColor
        
        // Nav bar
        titleLabel.textColor = theme?.contentPrimary
        backButton.tintColor = theme?.contentPrimary
        backButton.setImage(theme?.arrowLeftIcon, for: .normal)
        
        // Center content
        centerView.backgroundColor = theme?.bgWhiteTransparent10
        blockIcon.image = theme?.blockIcon
        emptyTitleLabel.textColor = theme?.contentPrimary
        infoButton.setTitleColor(theme?.contentPrimary, for: .normal)
        
        // Buttons
        blockButton.gradientColors = [theme?.pinkGradientUpColor, theme?.pinkGradientDownColor].compactMap { $0 }
        
        // Bottom label
        bottomLabel.textColor = theme?.contentSecondary
    }
}

// Helper gradient button class
class GradientButton: UIButton {
    var gradientColors: [UIColor] = [] {
        didSet {
            setNeedsLayout()
        }
    }
    
    var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.insertSublayer(gradientLayer, at: 0)
        clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        gradientLayer.colors = gradientColors.map { $0.cgColor }
    }
}
