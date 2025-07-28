//
//  RegistrationTypeView.swift
//  Tedr
//
//  Created by Temur on 05/05/2025.
//

import UIKit

protocol RegistrationTypeViewDelegate: AnyObject {
    func backAction()
    func signIn()
    func individualUser()
    func businessUser()
}

class RegistrationTypeView: TemplateView {
    weak var delegate: RegistrationTypeViewDelegate?
    
    
    private let backButton = UIButton()
    private let globeImageView = UIImageView()
    private let titleLabel = UILabel()
    private lazy var individualButton = GradientSelectableButton(
        title: "Individual",
        style: .gradient(
            [theme?.pinkGradientUpColor.cgColor ?? UIColor.gray.cgColor , theme?.pinkGradientDownColor.cgColor ?? UIColor.gray.cgColor], startPoint: .init(x: 1, y: 0), endPoint: .init(x: 0, y: 1)
        )
    )
    private lazy var businessButton = GradientSelectableButton(
        title: "Business",
        style: .filled(.init(white: 1, alpha: 0.1))
    )
    private let signInButton = UIButton()

    override func initialize() {
        var theme: Theme
        if let parentTheme = super.theme {
            theme = parentTheme
        } else {
            theme = Theme()
            super.theme = theme
        }
        // Back Button
        backButton.setImage(theme.arrowLeftLIcon, for: .normal)
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        addSubview(backButton)

        // Globe Image
        globeImageView.image = theme.globe
        globeImageView.contentMode = .scaleAspectFit
        addSubview(globeImageView)

        // Title
        titleLabel.text = "Choose one of the options\nto sign up to the app"
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = theme.getFont(size: 16, weight: .regular)
        addSubview(titleLabel)

        // Individual Button
        individualButton.addTarget(self, action: #selector(didTapIndividualButton), for: .touchUpInside)
        addSubview(individualButton)

        // Business Button
        businessButton.addTarget(self, action: #selector(didTapBusinessButton), for: .touchUpInside)
        addSubview(businessButton)

        // Sign In Button
        signInButton.titleLabel?.adjustsFontSizeToFitWidth = true
        signInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        self.addSubview(signInButton)
    }

    override func updateSubviewsFrame(_ size: CGSize) {
        let padding: CGFloat = 16
        let buttonHeight: CGFloat = 56
        let width = size.width
        let contentWidth = width - padding * 2
        let theme = theme ?? Theme()

        // Back Button
        var x = padding
        var y = CGFloat(50)
        var w = CGFloat(24)
        var h = w
        backButton.frame = CGRect(x: x, y: y, width: w, height: h)

        // Globe Image
        x = 0
        y = backButton.frame.maxY + 40
        w = width
        h = 300
        globeImageView.frame = CGRect(x: x, y: y, width: w, height: h)
        
        // Sign In Button
        x = padding
        h = 20
        y = size.height - h - padding - self.safeAreaInsets.bottom
        w = contentWidth
        signInButton.frame = CGRect(x: x, y: y, width: w, height: h)
        
        // Business Button
        x = padding
        h = buttonHeight
        y = signInButton.frame.minY - h - padding
        w = contentWidth
        businessButton.frame = CGRect(x: x, y: y, width: w, height: h)
        businessButton.borderRadius = 28
        
        // Individual Button
        x = padding
        h = buttonHeight
        y = businessButton.minY - h - padding
        w = contentWidth
        individualButton.frame = CGRect(x: x, y: y, width: w, height: h)
        individualButton.addGradient(colors: [theme.pinkGradientUpColor.cgColor, theme.pinkGradientDownColor.cgColor], startPoint: .init(x: 1, y: 0), endPoint: .init(x: 0, y: 1))
        individualButton.borderRadius = 28
        
        // Title Label
        x = padding
        h = 50
        y = individualButton.minY - h - 24
        w = contentWidth
        titleLabel.frame = CGRect(x: x, y: y, width: w, height: h)
    }

    override func updateTheme() {
        guard let theme else { return }
        let signInTitle = NSMutableAttributedString(string: translate("Already have an account? "), textColor: theme.contentSecondary)
        signInTitle.append(NSAttributedString(string: translate("Sign in"), textColor: theme.systemGreenColor))
        signInButton.setAttributedTitle(signInTitle, for: .normal)
        signInButton.titleLabel?.font = theme.getFont(size: 16, weight: .regular)
        signInButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    //MARK: - Private
    @objc private func didTapBackButton() {
        delegate?.backAction()
    }
    
    @objc private func signIn() {
        delegate?.signIn()
    }
    
    @objc private func didTapIndividualButton() {
        delegate?.individualUser()
    }
    
    @objc private func didTapBusinessButton() {
        delegate?.businessUser()
    }
}
