//
//  TemplateTextField.swift
//  Tedr
//
//  Created by Kostya Lee on 30/05/25.
//

import Foundation
import UIKit

/*
    Usage:
 
    let buttonOne = UIButton()
    buttonOne.setTitle(translate("Button One"), for: .normal)
    buttonOne.setTitleColor(theme.pinkGradientUpColor, for: .normal)
    buttonOne.titleLabel?.font = theme.getFont(size: 16, weight: .regular)
 
    let buttonTwo = UIButton()
    buttonTwo.setImage(theme.buttonTwoIcon, for: .normal)
 
    addressField = TemplateTextField(rightButtons: [buttonTwo, buttonOne])
 */
class TemplateTextField: TemplateView, UITextFieldDelegate {
    private var bgView: UIView?
    private var textField: UITextField?
    private var rightButtons: [UIButton] = []
    private var clearButton: UIButton?
    private var errorLabel: UILabel?
    
    var hasError = false
    
    var placeholder: String? {
        didSet {
            textField?.attributedPlaceholder = NSAttributedString(
                string: placeholder ?? "",
                attributes: [
                    .foregroundColor: Theme().whiteColor.withAlphaComponent(0.6)
                ]
            )
        }
    }
    
    var keyboardType: UIKeyboardType = .default {
        didSet {
            textField?.keyboardType = keyboardType
        }
    }
    
    var text: String? {
        get {
            textField?.text
        }
        set {
            textField?.text = newValue
        }
    }
    
    var didChangeText: ((String?) -> Void)?
    
    init(rightButtons: [UIButton] = []) {
        self.rightButtons = rightButtons
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func initialize() {
        let theme = Theme()
        
        bgView = UIView()
        bgView?.backgroundColor = theme.textFieldBackgroundColor
        self.addSubview(bgView)
        
        textField = UITextField()
        textField?.textColor = theme.contentWhite
        textField?.font = theme.getFont(size: 16, weight: .regular)
        textField?.delegate = self
        self.addSubview(textField)
        
        rightButtons.forEach { button in
            self.addSubview(button)
        }
        
        clearButton = UIButton()
        clearButton?.setImage(theme.crossCircleIcon, for: .normal)
        clearButton?.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        self.addSubview(clearButton)
        clearButton?.isHidden = true
        
        errorLabel = UILabel()
        errorLabel?.font = theme.getFont(size: 14, weight: .regular)
        errorLabel?.textColor = theme.systemRedColor
        self.addSubview(errorLabel)
        errorLabel?.isHidden = true
    }
    
    override func updateSubviewsFrame(_ size: CGSize) {
        var x = CGFloat(0)
        var y = CGFloat(0)
        var w = CGFloat(0)
        var h = CGFloat(0)
        let padding = 16.0
        let rightButtonsWidth: CGFloat = rightButtons.reduce(0) { $0 + $1.contentWidth() } + padding/2*CGFloat(rightButtons.count)
        
        self.bgView?.frame = self.bounds
        bgView?.layer.cornerRadius = 16
        
        x = padding
        if (textField?.text ?? "").isEmpty {
            w = size.width - x*2 - rightButtonsWidth
        } else {
            w = size.width - x*3 - 20
        }
        h = 20
        y = size.height/2 - h/2
        self.textField?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        x = size.width - padding/2
        h = 20
        y = (size.height - h)/2
        rightButtons.forEach { button in
            w = button.contentWidth()
            x -= w + padding/2
            button.frame = CGRect(x: x, y: y, width: w, height: h)
        }
        
        w = 20
        h = w
        x = bgView!.maxX - padding - w
        y = bgView!.centerY - h/2
        self.clearButton?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        x = padding*2
        y = bgView!.maxY + 6
        w = errorLabel!.getWidth()
        h = 20
        self.errorLabel?.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    override func updateTheme() {
        let theme = Theme()
        bgView?.backgroundColor = theme.textFieldBackgroundColor
        textField?.textColor = theme.contentWhite
        clearButton?.setImage(theme.crossCircleIcon, for: .normal)
        errorLabel?.textColor = theme.systemRedColor
    }
    
    @objc func clearButtonTapped() {
        textField?.text = nil
    }
    
    func getHeight() -> CGFloat {
        return 52
    }
    
    func error(_ error: String?) {
        let theme = Theme()
        
        hasError = error != nil
        if let error {
            errorLabel?.isHidden = false
            errorLabel?.text = error
            bgView?.layer.borderColor = theme.systemRedColor.cgColor
            bgView?.layer.borderWidth = 1
        } else {
            errorLabel?.isHidden = true
            errorLabel?.text = nil
            bgView?.layer.borderWidth = 0
        }
        
        updateSubviewsFrames()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.didChangeText?(textField.text)
        
        if !(textField.text?.isEmpty ?? true) {
            clearButton?.isHidden = false
            rightButtons.forEach { button in
                button.isHidden = true
            }
        } else {
            clearButton?.isHidden = true
            rightButtons.forEach { button in
                button.isHidden = false
            }
        }
    }
}
