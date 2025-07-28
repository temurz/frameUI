//
//  PinCodeView.swift
//  Tedr
//
//  Created by Kostya Lee on 09/05/25.
//

import Foundation
import UIKit
protocol PinCodeViewDelegate: AnyObject {
    func didEnterPin(_ pin: String)
    func didTapBack()
}

class PinCodeView: TemplateView {
    weak var delegate: PinCodeViewDelegate?
    
    var titleLbl: UILabel?
    var descLbl: UILabel?
    var pinDotsView: PinDotsView?
    var keypadView: KeypadView?
    var backButton: UIButton?
    
    private var enteredPin: String = "" {
        didSet {
            pinDotsView?.updateDots(count: enteredPin.count)
            if enteredPin.count == (pinDotsView?.numberOfDots ?? 4) {
                delegate?.didEnterPin(enteredPin)
            }
        }
    }
    
    override func initialize() {
        let theme = Theme()
        
        self.backgroundColor = theme.purpleBackgroundColor
        
        titleLbl = UILabel.initStyled(LabelStyle(
            font: theme.getFont(size: 28, weight: .bold),
            textColor: theme.whiteColor,
            textAlignment: .center,
            numberOfLines: 1
        ))
        titleLbl?.text = translate("PIN code")
        addSubview(titleLbl)
        
        descLbl = UILabel.initStyled(LabelStyle(
            font: theme.getFont(size: 16, weight: .regular),
            textColor: theme.whiteColor.withAlphaComponent(0.3),
            textAlignment: .center,
            numberOfLines: 2
        ))
        descLbl?.text = translate("PIN code protects your account\nand verifies sensitive actions")
        addSubview(descLbl)
        
        pinDotsView = PinDotsView()
        addSubview(pinDotsView!)
        
        keypadView = KeypadView { [weak self] key in
            self?.handleKeyInput(key)
        }
        addSubview(keypadView!)
        
        backButton = UIButton(type: .system)
        backButton?.setImage(Theme().arrowLeftLIcon, for: .normal)
        backButton?.tintColor = theme.whiteColor
        backButton?.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        addSubview(backButton!)
    }
    
    override func updateSubviewsFrame(_ size: CGSize) {
        var x: CGFloat = 16
        var w: CGFloat = 40
        var y: CGFloat = safeAreaInsets.top + 10
        var h: CGFloat = w
        backButton?.frame = .init(x: x, y: y, width: w, height: h)
        
        w = size.width - 2*x
        y = backButton!.maxY + 10
        h = 30
        titleLbl?.frame = .init(x: x, y: y, width: w, height: h)
        
        y = titleLbl!.maxY + 12
        h = 44
        descLbl?.frame = .init(x: x, y: y, width: w, height: h)
        
        y = descLbl!.maxY + 40
        w = 240
        x = (size.width - w)/2
        h = 20
        pinDotsView?.frame = .init(x: x, y: y, width: w, height: h)
        
        x = 0
        h = keypadView?.getHeight() ?? 350
        y = size.height - h - safeAreaInsets.bottom
        w = size.width
        keypadView?.frame = .init(x: x, y: y, width: w, height: h)
    }
    
    @objc private func backTapped() {
        delegate?.didTapBack()
    }
    
    private func handleKeyInput(_ key: KeypadKey) {
        switch key {
        case .number(let digit):
            if enteredPin.count < pinDotsView?.numberOfDots ?? 4 {
                enteredPin.append(digit)
            }
        case .delete:
            if !enteredPin.isEmpty {
                enteredPin.removeLast()
            }
        }
    }
}

