//
//  WalletSendView.swift
//  Tedr
//
//  Created by Kostya Lee on 29/05/25.
//

import Foundation
import UIKit
class WalletSendView: TemplateView {

    private var navigationBar: WalletSendNavigationBar?
    
    private var contentView: UIView?
    private var scrollView: UIScrollView?
    
    private var amountLabel: UILabel?
    private var amountField: UITextField?
    private var amountErrorLabel: UILabel?
    private var availableBalanceLabel: UILabel?
    private var maxButton: UIButton?
    
    private var addressLabel: UILabel?
    private var addressField: TemplateTextField?
    
    private var boardBackground: UIView?
    private var separator: UIView?
    private var feeLabel: UILabel?
    private var feeValueLabel: UILabel?
    private var amountToBeSentLabel: UILabel?
    private var amountToBeSentValueLabel: UILabel?
    private var totalLabel: UILabel?
    private var totalValueLabel: UILabel?
    
    private var sendButtonBg: UIView?
    private var sendButton: GradientSelectableButton?
    
    var originalSendButtonY: CGFloat = 0
    
    var callback: ((WalletSendController.Action) -> Void)?
    
    override func initialize() {
        let theme = Theme()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.backgroundColor = theme.backgroundPrimaryColor
        
        scrollView = UIScrollView()
        self.addSubview(scrollView)
        
        contentView = UIView()
        self.scrollView?.addSubview(contentView)
        
        amountLabel = UILabel()
        amountLabel?.textColor = theme.contentSecondary
        amountLabel?.text = Strings.amount
        self.contentView?.addSubview(amountLabel)
        
        amountField = UITextField()
        amountField?.keyboardType = .decimalPad
        amountField?.font = theme.getFont(size: 32, weight: .bold)
        amountField?.textAlignment = .center
        amountField?.textColor = theme.contentWhite
        amountField?.attributedPlaceholder = NSAttributedString(
            string: "0,00",
            attributes: [NSAttributedString.Key.foregroundColor: theme.contentWhite]
        )
        amountField?.isUserInteractionEnabled = true
        amountField?.delegate = self
        self.contentView?.addSubview(amountField)
        
        amountErrorLabel = UILabel()
        amountErrorLabel?.textColor = theme.systemRedColor
        amountErrorLabel?.text = Strings.Errors.insufficientBalance // Or "Invalid amount"
        self.contentView?.addSubview(amountErrorLabel)
        amountErrorLabel?.isHidden = true
        
        availableBalanceLabel = UILabel()
        availableBalanceLabel?.textColor = theme.contentSecondary
        availableBalanceLabel?.text = translate(Strings.available + ": 0 USDT")
        self.contentView?.addSubview(availableBalanceLabel)
        
        maxButton = UIButton()
        maxButton?.setTitle(Strings.max, for: .normal)
        maxButton?.titleLabel?.font = theme.getFont(size: 15, weight: .regular)
        maxButton?.backgroundColor = theme.whiteColor.withAlphaComponent(0.2)
        maxButton?.titleLabel?.textAlignment = .center
        maxButton?.tag = 0
        maxButton?.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        self.contentView?.addSubview(maxButton)
        
        addressLabel = UILabel()
        addressLabel?.text = Strings.sendTo
        addressLabel?.font = theme.getFont(size: 14, weight: .regular)
        addressLabel?.textColor = theme.contentWhite
        self.contentView?.addSubview(addressLabel)
        
        let pasteButton = UIButton()
        pasteButton.setTitle(Strings.paste, for: .normal)
        pasteButton.setTitleColor(theme.pinkGradientUpColor, for: .normal)
        pasteButton.titleLabel?.font = theme.getFont(size: 16, weight: .regular)
        pasteButton.tag = 1
        pasteButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        let contactButton = UIButton()
        contactButton.setImage(theme.userIcon, for: .normal)
        contactButton.tag = 2
        contactButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        addressField = TemplateTextField(rightButtons: [contactButton, pasteButton])
        addressField?.placeholder = Strings.enterAddress
        addressField?.isUserInteractionEnabled = true
        addressField?.didChangeText = { [weak self] text in
            self?.callback?(.addressChanged(text ?? ""))
        }
        self.contentView?.addSubview(addressField)
        
        boardBackground = UIView()
        boardBackground?.backgroundColor = theme.contentWhite.withAlphaComponent(0.1)
        self.contentView?.addSubview(boardBackground)
        
        separator = UIView()
        separator?.backgroundColor = theme.contentWhite.withAlphaComponent(0.1)
        self.contentView?.addSubview(separator)
        
        feeLabel = UILabel()
        feeValueLabel = UILabel()
        amountToBeSentLabel = UILabel()
        amountToBeSentValueLabel = UILabel()
        totalLabel = UILabel()
        totalValueLabel = UILabel()
        
        feeLabel?.text = Strings.fee
        amountToBeSentLabel?.text = Strings.TransactionDetails.amountToBeSent
        totalLabel?.text = Strings.total
        
        feeValueLabel?.textAlignment = .right
        amountToBeSentValueLabel?.textAlignment = .right
        totalValueLabel?.textAlignment = .right
        
        totalLabel?.font = theme.getFont(size: 17, weight: .semibold)
        totalValueLabel?.font = theme.getFont(size: 17, weight: .semibold)
        [feeLabel, feeValueLabel, amountToBeSentLabel, amountToBeSentValueLabel].forEach { label in
            label?.font = theme.getFont(size: 17, weight: .regular)
        }
        
        feeLabel?.textColor = theme.contentSecondary
        amountToBeSentLabel?.textColor = theme.contentSecondary
        [feeValueLabel, amountToBeSentValueLabel, totalLabel, totalValueLabel].forEach { label in
            label?.textColor = theme.contentWhite
        }

        [feeLabel, feeValueLabel, amountToBeSentLabel, amountToBeSentValueLabel, totalLabel, totalValueLabel].forEach { label in
            self.contentView?.addSubview(label)
        }
        
        // Send button
        sendButtonBg = UIView()
        sendButtonBg?.backgroundColor = theme.backgroundPrimaryColor
        self.addSubview(sendButtonBg)
        
        sendButton = GradientSelectableButton(
            title: Strings.send,
            style: .gradient(
                [theme.pinkGradientUpColor.cgColor, theme.pinkGradientDownColor.cgColor],
                startPoint: CGPoint(x: 1, y: 0),
                endPoint: CGPoint(x: 0, y: 1)
            )
        )
        sendButton?.addTarget(self, action: #selector(send), for: .touchUpInside)
        sendButton?.setEnabled(false)
        self.sendButtonBg?.addSubview(sendButton)

        navigationBar = WalletSendNavigationBar()
        navigationBar?.scan = { [weak self] in
            self?.callback?(.scan)
        }
        navigationBar?.back = { [weak self] in
            self?.callback?(.back)
        }
        self.addSubview(navigationBar)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(tapGesture)
        
        hideBoard(true)
    }
    
    override func deinitValues() {
        super.deinitValues()
        self.removeAllSubviews()
        NotificationCenter.default.removeObserver(self)
    }

    override func updateTheme() {
        guard let theme else { return }

        self.backgroundColor = theme.backgroundPrimaryColor
        amountLabel?.textColor = theme.contentSecondary
        amountField?.textColor = theme.contentWhite
        availableBalanceLabel?.textColor = theme.contentSecondary
        maxButton?.backgroundColor = theme.whiteColor.withAlphaComponent(0.2)
        addressLabel?.textColor = theme.contentWhite
        
        boardBackground?.backgroundColor = theme.contentWhite.withAlphaComponent(0.1)
        separator?.backgroundColor = theme.contentWhite.withAlphaComponent(0.1)
        feeLabel?.textColor = theme.contentSecondary
        amountToBeSentLabel?.textColor = theme.contentSecondary
        [feeValueLabel, amountToBeSentValueLabel, totalLabel, totalValueLabel].forEach { label in
            label?.textColor = theme.contentWhite
        }
    }

    override func updateSubviewsFrame(_ size: CGSize) {
        let padding: CGFloat = 20
        let fieldHeight: CGFloat = 44
        var x = CGFloat(0)
        var y = CGFloat(0)
        var w = CGFloat(size.width)
        var h = CGFloat(navigationBar?.getHeight() ?? 0)
        navigationBar?.frame = CGRect(x: x, y: y, width: w, height: h)

        y = padding
        w = amountLabel!.getWidth()
        h = 20
        x = size.width/2 - w/2
        self.amountLabel?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        w = size.width - padding*2
        h = 40
        x = padding
        y = amountLabel!.maxY + padding
        self.amountField?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        y = amountField!.maxY + 6
        w = amountErrorLabel!.getWidth()
        x = size.width/2 - w/2
        h = 20
        self.amountErrorLabel?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        w = availableBalanceLabel!.getWidth()
        h = 20
        x = size.width/2 - w/2
        y = amountErrorLabel!.maxY + padding
        self.availableBalanceLabel?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        w = 55
        h = 32
        x = size.width/2 - w/2
        y = availableBalanceLabel!.maxY + padding
        self.maxButton?.frame = CGRect(x: x, y: y, width: w, height: h)
        self.maxButton?.layer.cornerRadius = h/2
        
        x = padding*2
        y = maxButton!.maxY + padding*2
        w = addressLabel!.getWidth()
        h = 20
        self.addressLabel?.frame = CGRect(x: x, y: y, width: w, height: h)

        x = padding
        w = size.width - x*2
        h = addressField!.getHeight()
        y = addressLabel!.maxY + 4
        self.addressField?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        x = padding*2
        y = addressField!.maxY + padding*3
        w = feeLabel!.getWidth()
        h = 20
        self.feeLabel?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        w = feeValueLabel!.getWidth()
        x = size.width - padding*2 - w
        self.feeValueLabel?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        x = padding*2
        y = feeLabel!.maxY + padding
        w = amountToBeSentLabel!.getWidth()
        self.amountToBeSentLabel?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        w = amountToBeSentValueLabel!.getWidth() + 5
        x = size.width - padding*2 - w
        self.amountToBeSentValueLabel?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        x = padding*2
        y = amountToBeSentLabel!.maxY + padding
        w = size.width - x*2
        h = 1
        self.separator?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        x = padding*2
        y = separator!.maxY + padding
        w = totalLabel!.getWidth()
        h = 20
        self.totalLabel?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        w = totalValueLabel!.getWidth() + 5
        x = size.width - padding*2 - w
        self.totalValueLabel?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        x = padding
        w = size.width - x*2
        y = feeLabel!.minY - padding
        h = totalLabel!.maxY + padding - y
        self.boardBackground?.frame = CGRect(x: x, y: y, width: w, height: h)
        self.boardBackground?.layer.cornerRadius = 16
        
        x = 0
        w = size.width
        h = 56 + padding*2
        y = size.height - h - padding*2
        self.sendButtonBg?.frame = CGRect(x: x, y: y, width: w, height: h)
        self.originalSendButtonY = y
        
        x = padding
        w = size.width - x*2
        h = 56
        y = padding
        self.sendButton?.frame = CGRect(x: x, y: y, width: w, height: h)
        self.sendButton?.layer.cornerRadius = h/2
        
        h = boardBackground!.maxY - amountLabel!.minY
        h = size.height
        self.contentView?.frame = CGRect(x: 0, y: 0, width: size.width, height: h)
        
        let offset = navigationBar!.getHeight()
        self.scrollView?.frame = self.bounds
        self.scrollView?.contentSize.height = self.contentView?.frame.height ?? 0
        self.scrollView?.contentInset = UIEdgeInsets(top: offset, left: 0, bottom: 0, right: 0)
        self.scrollView?.contentOffset = CGPoint(x: 0, y: -offset)
    }
    
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0: // Max
            self.callback?(.max)
        case 1: // Paste
            if let clipboardText = UIPasteboard.general.string {
                addressField?.text = clipboardText
            }
        case 2: // Contact
            break
        default: break
        }
    }
    
    @objc func send() {
        let amount = amountField?.text ?? ""
        let address = addressField?.text ?? ""

        self.callback?(.send(amount, address))
    }
    
    func updateCurrency(asset: WalletAssetRow) {
        self.navigationBar?.configureTitle(asset: asset)
        self.availableBalanceLabel?.text = Strings.available + ": \(asset.amountInUsd.formatted()) \(asset.name.uppercased())"
        updateSubviewsFrames()
    }
    
    func showAmountError(error: String?) {
        let theme = Theme()
        
        if let error {
            amountField?.textColor = theme.systemRedColor
            amountErrorLabel?.isHidden = false
            amountErrorLabel?.text = error
        } else {
            amountField?.textColor = theme.contentWhite
            amountErrorLabel?.isHidden = true
            amountErrorLabel?.text = nil
        }
    }
    
    func showAddressError(error: String?) {
        self.addressField?.error(error)
    }
    
    func hideBoard(_ hide: Bool) {
        [boardBackground, feeLabel, feeValueLabel, amountToBeSentLabel, amountToBeSentValueLabel, separator, totalLabel, totalValueLabel].forEach { view in
            view?.isHidden = hide
        }
    }
    
    func updateBoardValues(fee: String, amountToBeSent: String, total: String) {
        hideBoard(false)
        
        feeValueLabel?.text = fee
        amountToBeSentValueLabel?.text = amountToBeSent
        totalValueLabel?.text = total
    }
    
    func setSendButtonEnabled(_ enable: Bool) {
        sendButton?.setEnabled(enable)
    }
    
    func updateMaxAmount(_ amount: String) {
        amountField?.text = amount
    }
}

extension WalletSendView: UITextFieldDelegate {
    // Did change amount field selection
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.callback?(.amountChanged(textField.text ?? ""))
    }
}

// MARK: - ScrollView
extension WalletSendView {
    @objc func keyboardWillShow(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
            let curveRaw = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
        else { return }

        let keyboardHeight = keyboardFrame.height

        var newButtonFrame = sendButtonBg?.frame ?? .zero
        newButtonFrame.origin.y = bounds.height - keyboardHeight - newButtonFrame.height

        var newScrollViewFrame = scrollView?.frame ?? .zero
        newScrollViewFrame.size.height = self.frame.height - keyboardHeight
        
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: UIView.AnimationOptions(rawValue: curveRaw << 16),
            animations: { [weak self] in
                guard let self else { return }
                self.sendButtonBg?.frame = newButtonFrame
                self.scrollView?.frame = newScrollViewFrame
            }
        )
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
            let curveRaw = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
        else { return }

        // Вернуть на исходную позицию
        var newFrame = sendButtonBg?.frame ?? .zero
        newFrame.origin.y = originalSendButtonY

        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: UIView.AnimationOptions(rawValue: curveRaw << 16),
            animations: { [weak self] in
                guard let self else { return }
                self.sendButtonBg?.frame = newFrame
                self.scrollView?.frame = self.bounds
            }
        )
    }
}
