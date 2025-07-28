//
//  ChatMessageInputPanelView.swift
//  Tedr
//
//  Created by Kostya Lee on 30/06/25.
//

import Foundation
import UIKit
final class ChatMessageInputPanelView: TemplateView {
    private var textFieldBgView: UIView?
    private var textView: UITextView?
    private var placeholderLabel: UILabel?
    private var emojiButton: UIButton?
    private var attachButton: UIButton?
    
    var attachAction: (() -> Void)?
    var animateUpdateFrames: ((TimeInterval) -> Void)? // Duration of animation
    
    private let padding: CGFloat = 16
    private let buttonSize: CGFloat = 40
    private let iconSize: CGFloat = 24
    let maxInputHeight: CGFloat = 240
    let minContentHeight: CGFloat = 44
    var currentInputHeight: CGFloat = 44
    
    // Hide Coin Button when input is active
    var isKeyboardActive = false
    var isEmodji = false
    
    var textIsEmpty: Bool {
        guard let textView = self.textView else { return true }
        return textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    override public var textInputMode: UITextInputMode? {
        if isEmodji {
            for mode in UITextInputMode.activeInputModes {
                if mode.primaryLanguage == "emoji" {
                    return mode
                }
            }
        } else {
            return UITextInputMode.activeInputModes.first
        }
        
        return nil
    }
    
    override func initialize() {
        let theme = Theme()
        
        textFieldBgView = UIView()
        textFieldBgView?.backgroundColor = theme.textFieldBackgroundColor
        textFieldBgView?.clipsToBounds = true
        self.addSubview(textFieldBgView)

        textView = UITextView()
        textView?.font = theme.getFont(size: 16, weight: .regular)
        textView?.textColor = .white
        textView?.backgroundColor = .clear
        textView?.isScrollEnabled = true
        textView?.showsVerticalScrollIndicator = false
        textView?.showsHorizontalScrollIndicator = false
        textView?.textContainerInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        textView?.textContainer.lineFragmentPadding = 0
        textView?.bounces = false
        textFieldBgView?.addSubview(textView)

        placeholderLabel = UILabel()
        placeholderLabel?.text = Strings.typeMessage
        placeholderLabel?.font = theme.getFont(size: 16, weight: .regular)
        placeholderLabel?.textColor = theme.contentSecondary
        textFieldBgView?.addSubview(placeholderLabel)

        let emojiIcon = theme.smileIcon?.changeColor(theme.contentSecondary)
        emojiButton = UIButton()
        emojiButton?.setImage(emojiIcon, for: .normal)
        emojiButton?.tintColor = theme.contentSecondary
        emojiButton?.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        textFieldBgView?.addSubview(emojiButton)

        let attachIcon = theme.clipIcon?.changeColor(theme.contentSecondary)
        attachButton = UIButton()
        attachButton?.setImage(attachIcon, for: .normal)
        attachButton?.tintColor = theme.contentSecondary
        attachButton?.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        textFieldBgView?.addSubview(attachButton)
    }
    
    override func updateSubviewsFrame(_ size: CGSize) {
        
        var x: CGFloat = 0
        var y: CGFloat = 0
        var w: CGFloat = 0
        var h: CGFloat = 0
        
        h = currentInputHeight
        y = 0
        w = size.width
        x = 0
        self.textFieldBgView?.frame = CGRect(x: x, y: y, width: w, height: h)
        self.textFieldBgView?.layer.cornerRadius = 20
        self.textFieldBgView?.clipsToBounds = true
        self.textFieldBgView?.layer.masksToBounds = true
        
        w = iconSize
        h = iconSize
        x = textFieldBgView!.bounds.width - w - 12
        y = textFieldBgView!.height/2 - h/2
        self.attachButton?.frame = CGRect(x: x, y: y, width: w, height: h)

        x = attachButton!.minX - iconSize - 8
        self.emojiButton?.frame = CGRect(x: x, y: y, width: w, height: h)

        x = 12
        y = 4
        w = emojiButton!.minX - x - 8
        h = currentInputHeight
        self.textView?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        x = 12
        y = 12
        w = emojiButton!.minX - x - 8
        h = 20
        self.placeholderLabel?.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    func calculateInputHeight() -> CGFloat {
        guard let textView = textView else { return minContentHeight }
        
        textView.isScrollEnabled = false
        let textWidth = textView.frame.width
        guard textWidth > 0 else { return minContentHeight }
        
        let textHeight = textView.sizeThatFits(CGSize(width: textWidth, height: CGFloat.greatestFiniteMagnitude)).height
        let calculatedHeight = max(minContentHeight, min(textHeight, maxInputHeight))
        
        if calculatedHeight >= maxInputHeight {
            textView.isScrollEnabled = true
            return maxInputHeight
        } else {
            textView.isScrollEnabled = false
            return calculatedHeight
        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        switch sender {
        case emojiButton:
            isEmodji.toggle()
            showEmoji()
        case attachButton:
            attachAction?()
        default:
            break
        }
    }
    
    @objc private func inputModeDidChange(_ notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            if self?.isEmodji ?? false {
                self?.isEmodji = false
            }
            self?.reloadInputViews()
        }
    }
    
    func clearInput() {
        textView?.text = ""
        textView?.isScrollEnabled = false
        placeholderLabel?.isHidden = false
        isKeyboardActive = false
        
        currentInputHeight = minContentHeight
        
        self.animateUpdateFrames?(0.2)
    }
    
    func showEmoji() {
        if isEmodji {
            return
        }
        
        isEmodji = true
        if !isKeyboardActive {
            textView?.becomeFirstResponder()
        } else {
            textView?.resignFirstResponder()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.isEmodji = true
                self?.textView?.becomeFirstResponder()
            }
        }
    }
}

// MARK: Getters and Setters
extension ChatMessageInputPanelView {
    func hidePlaceholder(_ hide: Bool) {
        placeholderLabel?.isHidden = hide
    }
    
    func setDelegate(_ delegate: UITextViewDelegate) {
        textView?.delegate = delegate
    }
    
    func getText() -> String {
        return textView?.text ?? ""
    }
    
    func focus() {
        textView?.becomeFirstResponder()
    }
    
    func getIsFirstResponder() -> Bool {
        return textView?.isFirstResponder ?? false
    }
}
