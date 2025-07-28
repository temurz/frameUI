//
//  KeypadView.swift
//  Tedr
//
//  Created by Kostya Lee on 09/05/25.
//

import Foundation
import UIKit

enum KeypadKey {
    case number(String)
    case delete
}

class KeypadView: TemplateView {
    private let buttonTitles: [[KeypadKey?]] = [
        [.number("1"), .number("2"), .number("3")],
        [.number("4"), .number("5"), .number("6")],
        [.number("7"), .number("8"), .number("9")],
        [nil,        .number("0"), .delete]
    ]
    
    private var buttons: [UIButton] = []
    private let onKeyPress: (KeypadKey) -> Void
    
    init(onKeyPress: @escaping (KeypadKey) -> Void) {
        self.onKeyPress = onKeyPress
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func initialize() {
        for row in buttonTitles {
            for key in row {
                let button = UIButton(type: .system)
                button.titleLabel?.font = Theme().getFont(size: 28, weight: .regular)
                button.setTitleColor(Theme().whiteColor, for: .normal)
                button.tintColor = Theme().whiteColor
                button.backgroundColor = .clear
                button.layer.cornerRadius = 10
                button.clipsToBounds = true

                let grayColor = UIColor.white.withAlphaComponent(0.3)
                let image = UIImage.fromColor(grayColor)
                button.setBackgroundImage(image, for: .highlighted)

                if let key = key {
                    switch key {
                    case .number(let digit):
                        button.setTitle(digit, for: .normal)
                    case .delete:
                        let icon = Theme().backspaceIcon?.withRenderingMode(.alwaysTemplate)
                        button.setImage(icon, for: .normal)
                    }
                } else {
                    button.isUserInteractionEnabled = false
                }
                
                button.addTarget(self, action: #selector(keyPressed(_:)), for: .touchUpInside)
                buttons.append(button)
                addSubview(button)
            }
        }
    }
    
    @objc private func keyPressed(_ sender: UIButton) {
        guard let index = buttons.firstIndex(of: sender) else { return }
        let flatIndex = index
        let row = flatIndex / 3
        let col = flatIndex % 3
        guard let key = buttonTitles[row][col] else { return }
        onKeyPress(key)
    }
    
    override func updateSubviewsFrame(_ size: CGSize) {
        let rows = buttonTitles.count
        let cols = 3
        let spacing: CGFloat = 12
        let totalSpacingX = spacing * CGFloat(cols - 1)
        let totalSpacingY = spacing * CGFloat(rows - 1)
        
        let btnWidth = (bounds.width - totalSpacingX) / CGFloat(cols)
        let btnHeight = (bounds.height - totalSpacingY) / CGFloat(rows)
        
        for (i, button) in buttons.enumerated() {
            let row = i / cols
            let col = i % cols
            let x = CGFloat(col) * (btnWidth + spacing)
            let y = CGFloat(row) * (btnHeight + spacing)
            button.frame = CGRect(x: x, y: y, width: btnWidth, height: btnHeight)
        }
    }
    
    func getHeight() -> CGFloat {
        return 350.0
    }
}
