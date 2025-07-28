//
//  ChatInputPanelView.swift
//  Tedr
//
//  Created by Kostya Lee on 14/06/25.
//

import Foundation
import UIKit
final class ChatInputPanelView: TemplateView {

    private var bgView: UIView?
    private var coinButton: UIButton?
    
    private var messageInputPanel: ChatMessageInputPanelView?
    private var txInputPanel: ChatTxInputPanelView?
    
    private var actionButton: ChatInputPanelActionButton?

    private let padding: CGFloat = 16
    private let buttonSize: CGFloat = 40
    
    var isKeyboardActive: Bool = false {
        didSet {
            messageInputPanel?.isKeyboardActive = isKeyboardActive
        }
    }
    
    var isTransactionMode: Bool {
        get {
            txInputPanel?.isActive ?? false
        }
    }
    
    var shouldShowCoinButton = true {
        didSet {
            self.showAnimateCoinButton(shouldShowCoinButton)
        }
    }
    
    override func initialize() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(inputModeDidChange),
                                               name: UITextInputMode.currentInputModeDidChangeNotification,
                                               object: nil)
        
        let theme = Theme()

        backgroundColor = .clear
        
        bgView = UIView()
        bgView?.backgroundColor = theme.tabbarUnionBackgroundColor
        self.addSubview(bgView)

        coinButton = UIButton()
        coinButton?.setImage(UIImage(named: "ustt_icon_colored"), for: .normal)
        coinButton?.imageView?.contentMode = .scaleAspectFill
        coinButton?.contentHorizontalAlignment = .fill
        coinButton?.contentVerticalAlignment = .fill
        coinButton?.imageEdgeInsets = .zero
        coinButton?.clipsToBounds = true
        coinButton?.addTarget(self, action: #selector(coinButtonTapped), for: .touchUpInside)
        bgView?.addSubview(coinButton)

        actionButton = ChatInputPanelActionButton()
        actionButton?.action = { [weak self] state in
            self?.handleButtonAction(state)
        }
        bgView?.addSubview(actionButton)
        
        messageInputPanel = ChatMessageInputPanelView()
        messageInputPanel?.animateUpdateFrames = { [weak self] duration in
            self?.animateUpdateFrames(duration)
        }
        messageInputPanel?.setDelegate(self)
        bgView?.addSubview(messageInputPanel)
        messageInputPanel?.isUserInteractionEnabled = true
        
        txInputPanel = ChatTxInputPanelView()
        txInputPanel?.setDelegate(self)
        bgView?.addSubview(txInputPanel)
        txInputPanel?.alpha = 0
        txInputPanel?.isHidden = true
        txInputPanel?.setupBalance(balance: "999,948.00", currency: "USTT")
    }
    
    override func deinitValues() {
        NotificationCenter.default.removeObserver(self)
    }

    override func updateSubviewsFrame(_ size: CGSize) {
        let safeBottom = safeAreaInsets.bottom
        var x: CGFloat = 0
        var y: CGFloat = 0
        var w: CGFloat = 0
        var h: CGFloat = 0
        
        x = 0
        w = size.width
        h = getHeight() // TODO: If txInputPanel is active -> height is bigger + Height is dynamic when textView expands
        y = size.height - h
        self.bgView?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        x = padding
        y = padding
        w = buttonSize
        h = w
        self.coinButton?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        x = bounds.width - buttonSize - padding
        y = padding
        self.actionButton?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        x = coinButton!.maxX + 8
        h = txInputPanel!.getHeight()
        y = padding
        w = actionButton!.minX - coinButton!.maxX - padding
        self.txInputPanel?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        let widthOne = size.width - x*2
        let widthTwo = size.width - padding*2 - buttonSize - 8
        h = messageInputPanel!.currentInputHeight
        y = padding
        x = shouldShowCoinButton ? coinButton!.maxX + 8 : padding
        w = shouldShowCoinButton ? widthOne : widthTwo
        self.messageInputPanel?.frame = CGRect(x: x, y: y, width: w, height: h)
    }
}

// MARK: - Actions
extension ChatInputPanelView {
    @objc private func coinButtonTapped() {
        // Animate transition to tx
        // Send request for balance
        // Wait for request by enabling shimmer
        // Get response from server (interactor) or from cache
        // Display balance
        self.handleCoinButtonAction()
    }
    
    @objc private func inputModeDidChange(_ notification: Notification) {
        self.handleInputModeDidChange()
    }
    
    // Update Height if there is more than one line in TextView
    private func updateInputHeight() {
        let newHeight = messageInputPanel?.calculateInputHeight() ?? 0
        
        if newHeight != messageInputPanel?.currentInputHeight ?? 0 {
            messageInputPanel?.currentInputHeight = newHeight
            
            UIView.animate(
                withDuration: 0.25,
                delay: 0,
                options: [.curveEaseInOut],
                animations: {
                    self.updateSubviewsFrame(self.bounds.size)
                }, completion: nil)
        }
    }
    
    private func updateActionButton() {
        if messageInputPanel?.textIsEmpty ?? true {
            actionButton?.state = .mic
        } else {
            actionButton?.state = .send
        }
    }
   
    // Hide Coin Button when input is active
    private func showAnimateCoinButton(_ shouldShow: Bool) {
        UIView.animate(withDuration: 0.15) { [weak self] in
            guard let self else { return }
            
            if shouldShow {
                self.coinButton?.alpha = 1
            } else {
                self.coinButton?.alpha = 0
            }
            self.updateSubviewsFrame(self.bounds.size)
        }
    }
    
    func getHeight() -> CGFloat {
        if isTransactionMode {
            return 106
        } else {
            let inputHeight = messageInputPanel?.currentInputHeight ?? 0
            let minHeight: CGFloat = 78
            let maxHeight: CGFloat = 240
            let calculatedHeight = padding * 2 + max(inputHeight, 44)
            let totalHeight = max(min(calculatedHeight, maxHeight), minHeight)
            let safeBottom = self.safeAreaInsets.bottom
            return totalHeight + safeBottom
        }
    }
    
    func animateUpdateFrames(_ duration: TimeInterval) {
        UIView.animate(withDuration: duration) { [weak self] in
            guard let self else { return }
            self.updateSubviewsFrame(self.bounds.size)
        }
    }
}

// MARK: TextView for message
extension ChatInputPanelView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        shouldShowCoinButton = messageInputPanel?.textIsEmpty ?? true
        
        messageInputPanel?.hidePlaceholder(!textView.text.isEmpty)
        
        updateInputHeight()
        updateActionButton()
        
        if textView.isScrollEnabled {
            let bottom = NSMakeRange(textView.text.count, 0)
            textView.scrollRangeToVisible(bottom)
        }
    }
}

// MARK: TextField for tx
extension ChatInputPanelView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        // Проверить если текст пустой
        // - если да - показать кнопку "х"
        // - если нет - проверить на баланс, валидность суммы и показать кнопку отправить
        if textField.text?.isEmpty ?? true {
            actionButton?.state = .cancel
        } else {
            actionButton?.state = .send
        }
    }
}

extension ChatInputPanelView {
    
    private func handleCoinButtonAction() {
        if txInputPanel?.isActive ?? false {
            // Choose currency -> Present new vc (callback to vc)
        } else {
            txInputPanel?.isActive = true
            showTxInputPanel(true)
            txInputPanel?.focus()
        }
    }
    
    private func handleInputModeDidChange() {
        guard let messageInputPanel else { return }
        guard messageInputPanel.isEmodji && messageInputPanel.getIsFirstResponder() else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            guard let panel = self?.messageInputPanel else { return }
            if panel.isEmodji {
                panel.isEmodji = false
            }
            self?.reloadInputViews()
        }
    }
    
    private func showTxInputPanel(_ show: Bool) {
        messageInputPanel?.isHidden = false
        txInputPanel?.isHidden = false

        let actionButtonModeForMessageInput: ChatInputPanelActionButton.State = (messageInputPanel?.textIsEmpty ?? true) ? .mic : .send

        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            guard let self else { return }

            self.txInputPanel?.alpha = show ? 1.0 : 0.0
            self.messageInputPanel?.alpha = show ? 0.0 : 1.0
            self.actionButton?.state = show ? .cancel : actionButtonModeForMessageInput
            
        }, completion: { [weak self] completed in
            guard let self else { return }
            if completed {
                self.messageInputPanel?.isHidden = show
                self.txInputPanel?.isHidden = !show
            }
        })
    }
    
    // Called when Action Button is pressed (send / mic / cancel)
    private func handleButtonAction(_ state: ChatInputPanelActionButton.State) {
        switch state {
        case .mic:
            break
        case .send:
            break
        case .cancel:
            txInputPanel?.isActive = false
            showTxInputPanel(false)
            messageInputPanel?.focus()
        }
    }
}
