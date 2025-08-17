//
//  MultiActionAlertViewController.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 11/08/25.
//

import UIKit

struct AlertAction {
    let title: String
    let isCancel: Bool
    let handler: (() -> Void)?
}

final class MultiActionAlertViewController: TemplateController {
    
    private let container = UIView()
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let actionsStack = UIStackView()
    private let cancelButton = UIButton(type: .system)
    
    private let actions: [AlertAction]
    private let cancelAction: AlertAction?
    private let alertTitle: String
    private let alertMessage: String
    private let isCentered: Bool
    
    init(title: String,
         message: String,
         actions: [AlertAction],
         isCentered: Bool = false) { // default = bottom now
        self.alertTitle = title
        self.alertMessage = message
        self.isCentered = isCentered
        
        self.cancelAction = actions.first(where: { $0.isCancel })
        self.actions = actions.filter { !$0.isCancel }
        
        super.init()
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func initialize() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        container.backgroundColor = theme.bgWhiteTransparent10
        container.borderRadius = 20
        container.applyBlur()
        container.clipsToBounds = true
        view.addSubview(container)
        
        titleLabel.text = alertTitle
        titleLabel.font = theme.getFont(size: 18, weight: .bold)
        titleLabel.textColor = theme.whiteColor
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        container.addSubview(titleLabel)
        
        messageLabel.text = alertMessage
        messageLabel.font = theme.getFont(size: 16, weight: .regular)
        messageLabel.textColor = theme.contentPrimary
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        container.addSubview(messageLabel)
        
        actionsStack.axis = .vertical
        actionsStack.spacing = 16 // spacing between buttons
        container.addSubview(actionsStack)
        
        for action in actions {
            let button = createButton(title: action.title) {
                self.dismiss(animated: true) { action.handler?() }
            }
            actionsStack.addArrangedSubview(button)
        }
        
        if let cancel = cancelAction {
            cancelButton.setTitle(cancel.title, for: .normal)
            cancelButton.setTitleColor(theme.buttonQuaternaryTransparentDefaultContent, for: .normal)
            cancelButton.titleLabel?.font = theme.getFont(size: 16, weight: .bold)
            cancelButton.layer.cornerRadius = 24
            cancelButton.backgroundColor = .clear
            cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
            container.addSubview(cancelButton)
        }
    }
    
    override func updateSubviewsFrames(_ size: CGSize) {
        let horizontalPadding: CGFloat = 24
        let verticalPadding: CGFloat = 16
        let containerWidth = size.width - (horizontalPadding * 2)
        var y: CGFloat = verticalPadding
        
       
        let titleHeight = titleLabel.sizeThatFits(CGSize(width: containerWidth - horizontalPadding * 2, height: .greatestFiniteMagnitude)).height
        titleLabel.frame = CGRect(x: horizontalPadding, y: y, width: containerWidth - horizontalPadding * 2, height: titleHeight)
        y += titleHeight + 8
        
       
        let messageHeight = messageLabel.sizeThatFits(CGSize(width: containerWidth - horizontalPadding * 2, height: .greatestFiniteMagnitude)).height
        messageLabel.frame = CGRect(x: horizontalPadding, y: y, width: containerWidth - horizontalPadding * 2, height: messageHeight)
        y += messageHeight + 16
        

        let buttonHeight: CGFloat = 48
        let actionsHeight = CGFloat(actions.count) * buttonHeight + CGFloat(max(actions.count - 1, 0)) * actionsStack.spacing
        actionsStack.frame = CGRect(x: horizontalPadding, y: y, width: containerWidth - horizontalPadding * 2, height: actionsHeight)
        y += actionsHeight + (cancelAction != nil ? verticalPadding : 0)
        
        if cancelAction != nil {
            cancelButton.frame = CGRect(x: horizontalPadding, y: y, width: containerWidth - horizontalPadding * 2, height: buttonHeight)
            y += buttonHeight + verticalPadding
        }
        
        container.frame = CGRect(
            x: horizontalPadding,
            y: size.height - y - (bottomSafe ?? 0) - verticalPadding,
            width: containerWidth,
            height: y
        )
    }
    
    private func createButton(title: String, action: @escaping () -> Void) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 24
        button.titleLabel?.font = theme.getFont(size: 16, weight: .bold)
        button.backgroundColor = theme.buttonQuaternaryTransparentDefaultBg
        button.setTitleColor(theme.buttonQuaternaryTransparentDefaultContent, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.addAction(UIAction { _ in action() }, for: .touchUpInside)
        return button
    }
    
    @objc private func cancelTapped() {
        dismiss(animated: true) { [cancelAction] in
            cancelAction?.handler?()
        }
    }
}

extension UIViewController {
    func showMultiActionAlert(title: String,
                              message: String,
                              actions: [AlertAction],
                              isCentered: Bool = false) {
        let alert = MultiActionAlertViewController(title: title, message: message, actions: actions, isCentered: isCentered)
        present(alert, animated: true)
    }
}
