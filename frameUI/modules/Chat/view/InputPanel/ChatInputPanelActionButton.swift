//
//  ChatInputPanelActionButton.swift
//  Tedr
//
//  Created by Kostya Lee on 30/06/25.
//

import Foundation
import UIKit
final class ChatInputPanelActionButton: TemplateView {
    enum State {
        case mic
        case send
        case cancel // For tx
    }
    
    private var actionButton: UIButton?
    
    var state = State.mic {
        didSet {
            self.update()
        }
    }
    
    var action: ((State) -> Void)?
    
    private func update() {
        let theme = Theme()
        switch state {
        case .cancel:
            _removeGradient()
            actionButton?.setImage(theme.crossIcon, for: .normal)
        case .mic:
            addGradient(color1: theme.blueGradientUpColor, color2: theme.blueGradientDownColor)
            actionButton?.setImage(theme.microphoneOnIcon, for: .normal)
        case .send:
            addGradient(color1: theme.pinkGradientUpColor, color2: theme.pinkGradientDownColor)
            actionButton?.setImage(theme.sendIcon, for: .normal)
        }
    }
    
    override func initialize() {
        actionButton = UIButton()
        actionButton?.addTarget(self, action: #selector(actionSelector), for: .touchUpInside)
        self.addSubview(actionButton)
    }
    
    override func updateSubviewsFrame(_ size: CGSize) {
        self.actionButton?.frame = self.bounds
        self.actionButton?.layer.cornerRadius = self.getSize().height/2
        update()
    }
    
    override func updateTheme() {
        update()
    }
    
    @objc private func actionSelector() {
        action?(self.state)
    }
    
    private func addGradient(color1: UIColor, color2: UIColor) {
        guard let button = actionButton else { return }
        guard button.bounds.size.width > 0, button.bounds.size.height > 0 else { return }

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        gradientLayer.startPoint = CGPoint(x: 1, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.frame = button.bounds
        gradientLayer.cornerRadius = button.layer.cornerRadius

        UIGraphicsBeginImageContextWithOptions(button.bounds.size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return
        }
        gradientLayer.render(in: context)
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        button.setBackgroundImage(gradientImage, for: .normal)
    }

    private func _removeGradient() {
        guard let button = actionButton else { return }
        button.setBackgroundImage(nil, for: .normal)
    }

    func getSize() -> CGSize {
        return CGSize(width: 40, height: 40)
    }
}
