//
//  AlertViewController.swift
//  Tedr
//
//  Created by Temur on 27/05/2025.
//


import UIKit

final class AlertViewController: TemplateController {

    private let container = UIView()
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let primaryButton = UIButton(type: .system)
    private let secondaryButton = UIButton(type: .system)
    private let imageView: UIImageView = UIImageView()
    
    private let isCentered: Bool
    private let message: String
    private let titleText: String
    private let primaryTitle: String
    private let secondaryTitle: String?
    private let primaryAction: (() -> Void)?
    private let secondaryAction: (() -> Void)?

    init(title: String,
         message: String,
         primaryTitle: String,
         icon: String?,
         isCentered: Bool = true,
         secondaryTitle: String? = nil,
         primaryAction: (() -> Void)? = nil,
         secondaryAction: (() -> Void)? = nil) {
        self.isCentered = isCentered
        self.titleText = title
        self.message = message
        self.primaryTitle = primaryTitle
        self.secondaryTitle = secondaryTitle
        self.primaryAction = primaryAction
        self.secondaryAction = secondaryAction
        super.init()
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
        
        if let icon {
            imageView.isHidden = false
            imageView.image = UIImage(named: icon)
        } else {
            imageView.isHidden = true
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func initialize() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)

        container.backgroundColor = theme.bgWhiteTransparent10
        container.borderRadius = 20
        container.applyBlur()
        view.addSubview(container)
        
        imageView.contentMode = .scaleAspectFit
        container.addSubview(imageView)

        titleLabel.text = titleText
        titleLabel.font = theme.getFont(size: 18, weight: .bold)
        titleLabel.textColor = theme.whiteColor
        titleLabel.textAlignment = .center
        container.addSubview(titleLabel)

        messageLabel.text = message
        messageLabel.font = theme.getFont(size: 16, weight: .regular)
        messageLabel.textColor = theme.contentPrimary
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        container.addSubview(messageLabel)

        primaryButton.setTitle(primaryTitle, for: .normal)
        primaryButton.setTitleColor(theme.buttonQuaternaryTransparentDefaultContent, for: .normal)
        primaryButton.backgroundColor = theme.buttonQuaternaryTransparentDefaultBg
        primaryButton.titleLabel?.font = theme.getFont(size: 16, weight: .bold)
        primaryButton.layer.cornerRadius = 24
        primaryButton.addTarget(self, action: #selector(primaryTapped), for: .touchUpInside)
        container.addSubview(primaryButton)

        if let secondary = secondaryTitle {
            secondaryButton.setTitle(secondary, for: .normal)
            secondaryButton.setTitleColor(
                theme.buttonQuaternaryTransparentDefaultContent,
                for: .normal
            )
            secondaryButton.titleLabel?.font = theme.getFont(size: 16, weight: .bold)
            secondaryButton.layer.cornerRadius = 24
            secondaryButton.addTarget(self, action: #selector(secondaryTapped), for: .touchUpInside)
            container.addSubview(secondaryButton)
        }
    }
    
    override func updateSubviewsFrames(_ size: CGSize) {
        let padding: CGFloat = 16
        var x = padding
        var y = padding
        var w = size.width - (padding*2)
        var h = size.height
        container.frame = CGRect(x: x, y: 0, width: w, height: h)
        
        w = 48
        h = w
        y = padding
        x = size.width/2 - w/2
        self.imageView.frame = .init(x: x, y: y, width: w, height: h)
        
        y = imageView.isHidden ? padding : imageView.maxY + padding
        w = size.width - (padding*4)
        h = titleLabel.textHeight(w)
        x = padding
        titleLabel.frame = CGRect(x: x, y: y, width: w, height: 22)
        
        
        y += (titleLabel.text?.isEmpty ?? false) ? padding : h + padding
        h = messageLabel.textHeight(w)
        messageLabel.frame = CGRect(x: x, y: y, width: w, height: h)
        
        y += h + padding
        h = 48
        primaryButton.frame = CGRect(x: x, y: y, width: w, height: h)
        
        
        if secondaryTitle != nil {
            y += h + padding
            secondaryButton.frame = CGRect(x: x, y: y, width: w, height: h)
        }
        
        y += h + padding
        container.height = y
        container.y = isCentered ? (size.height - y) / 2 : size.height - y - padding - (bottomSafe ?? 0)
    }

    @objc private func primaryTapped() {
        dismiss(animated: true) { [primaryAction] in
            primaryAction?()
        }
    }

    @objc private func secondaryTapped() {
        dismiss(animated: true) { [secondaryAction] in
            secondaryAction?()
        }
    }
}

extension UIViewController {
    func showAlert(title: String,
                   message: String,
                   primaryTitle: String = "OK",
                   icon: String? = nil,
                   isCentered: Bool = true,
                   secondaryTitle: String? = nil,
                   primaryAction: (() -> Void)? = nil,
                   secondaryAction: (() -> Void)? = nil) {
        let alert = AlertViewController(
            title: title,
            message: message,
            primaryTitle: primaryTitle,
            icon: icon,
            isCentered: isCentered,
            secondaryTitle: secondaryTitle,
            primaryAction: primaryAction,
            secondaryAction: secondaryAction
        )
        present(alert, animated: true)
    }
}
