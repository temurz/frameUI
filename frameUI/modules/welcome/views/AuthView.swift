//
//  WelcomeView.swift
//  Tedr
//
//  Created by Temur on 09/05/2025.
//  
//

import UIKit

protocol WelcomeViewDelegate: AnyObject {
    func backAction()
    func signUp()
    func signIn()
}

class WelcomeView: TemplateView {

    weak var delegate: WelcomeViewDelegate?

    private let backButton = UIButton()
    private let logoImageView = UIImageView()
    private let placeholderView = UIView()
    private let titleLabel = UILabel()
    private let signUpButton: GradientSelectableButton
    private let signInButton: GradientSelectableButton

    override init(frame: CGRect) {
        let theme = Theme()

        self.signUpButton = GradientSelectableButton(
            title: "Sign up",
            style: .gradient(
                [theme.pinkGradientUpColor.cgColor, theme.pinkGradientDownColor.cgColor],
                startPoint: CGPoint(x: 1, y: 0),
                endPoint: CGPoint(x: 0, y: 1)
            )
        )

        self.signInButton = GradientSelectableButton(
            title: "Sign in",
            style: .filled(UIColor(white: 1, alpha: 0.1))
        )

        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func initialize() {
        let theme = theme ?? Theme()

        // Back Button
        backButton.setImage(theme.arrowLeftLIcon, for: .normal)
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        addSubview(backButton)

        logoImageView.image = theme.tedrLogo
        logoImageView.contentMode = .scaleAspectFit
        addSubview(logoImageView)

        // Placeholder View
        placeholderView.backgroundColor = UIColor(white: 1, alpha: 0.05)
        placeholderView.layer.cornerRadius = 24
        addSubview(placeholderView)

        // Title Label
        titleLabel.text = "Choose one of the options"
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = theme.getFont(size: 16, weight: .regular)
        addSubview(titleLabel)

        // Buttons
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        addSubview(signUpButton)
        addSubview(signInButton)
    }

    override func updateSubviewsFrame(_ size: CGSize) {
        let padding: CGFloat = 16
        let buttonHeight: CGFloat = 56
        let buttonSpacing: CGFloat = 16
        let width = size.width
        let contentWidth = width - padding * 2

        // Back Button
        var x = padding
        var y = CGFloat(50)
        var w = CGFloat(24)
        var h = w
        backButton.frame = CGRect(x: x, y: y, width: w, height: h)

        // Logo Image
        w = 105
        h = 64
        x = (width - w) / 2
        y = backButton.frame.maxY + 24
        logoImageView.frame = CGRect(x: x, y: y, width: w, height: h)
        
        // Placeholder View (fills remaining space)
        w = width - (padding*2)
        h = w*0.8
        y = logoImageView.frame.maxY + 20
        placeholderView.frame = CGRect(x: padding, y: y, width: contentWidth, height: max(h, 0))

        // Sign In Button (bottom)
        x = padding
        h = buttonHeight
        y = size.height - h - padding - safeAreaInsets.bottom
        w = contentWidth
        signInButton.frame = CGRect(x: x, y: y, width: w, height: h)

        // Sign Up Button (above Sign In)
        y = signInButton.frame.minY - buttonSpacing - buttonHeight
        signUpButton.frame = CGRect(x: x, y: y, width: w, height: h)

        // Title Label (above Sign Up)
        h = 20
        y = signUpButton.frame.minY - buttonSpacing - h
        titleLabel.frame = CGRect(x: x, y: y, width: w, height: h)
    }


    // MARK: - Actions

    @objc private func didTapBackButton() {
        delegate?.backAction()
    }

    @objc private func didTapSignUp() {
        delegate?.signUp()
    }

    @objc private func didTapSignIn() {
        delegate?.signIn()
    }
}
