//
//  ChatTxInputPanelView.swift
//  Tedr
//
//  Created by Kostya Lee on 29/06/25.
//

import Foundation
import UIKit
final class ChatTxInputPanelView: TemplateView {
    private var balanceLabel: UILabel?
    private var balanceLoaderView: UIView?
    private var amountTextField: UITextField?
    
    private let loader = ShimmerLoader()
    
    var isActive = false
    
    override func initialize() {
        let theme = Theme()
        
        balanceLabel = UILabel()
        self.addSubview(balanceLabel)
        setupBalance(balance: "", currency: "")
        
        balanceLoaderView = UIView()
        self.addSubview(balanceLoaderView)
        if let balanceLoaderView {
            loader.startShimmer(on: balanceLoaderView)
        }
        
        amountTextField = UITextField()
        amountTextField?.font = theme.getFont(size: 32, weight: .semibold)
        amountTextField?.textColor = theme.contentWhite
        amountTextField?.keyboardType = .decimalPad
        self.addSubview(amountTextField)
        amountTextField?.attributedPlaceholder = NSAttributedString(
            string: "0.00",
            attributes: [
                .foregroundColor: theme.contentSecondary,
                .font: theme.getFont(size: 32, weight: .semibold)
            ]
        )
    }
    
    override func deinitValues() {
        loader.stopShimmer()
        balanceLabel?.removeFromSuperview()
        balanceLabel = nil
        balanceLoaderView?.removeFromSuperview()
        balanceLoaderView = nil
        amountTextField?.removeFromSuperview()
        amountTextField = nil
    }

    func setupBalance(balance: String, currency: String) {
        let theme = Theme()
        let firstPart = "Balance: "
        let secondPart = "\(balance) \(currency)"

        let fullText = firstPart + secondPart

        let attributedString = NSMutableAttributedString(string: fullText)

        let firstRange = (fullText as NSString).range(of: firstPart)
        attributedString.addAttribute(.foregroundColor, value: theme.contentWhite, range: firstRange)
        attributedString.addAttribute(.font, value: theme.getFont(size: 14, weight: .medium), range: firstRange)

        let secondRange = (fullText as NSString).range(of: secondPart)
        attributedString.addAttribute(.font, value: theme.getFont(size: 14, weight: .medium), range: secondRange)
        attributedString.addAttribute(.foregroundColor, value: theme.contentWhite, range: secondRange)

        balanceLabel?.attributedText = attributedString
        amountTextField?.attributedPlaceholder = NSAttributedString(
            string: "0.00 \(currency)",
            attributes: [
                .foregroundColor: theme.contentSecondary,
                .font: theme.getFont(size: 32, weight: .semibold)
            ]
        )
    }
    
    override func updateSubviewsFrame(_ size: CGSize) {
        var x = CGFloat(0)
        var y = CGFloat(0)
        var w = CGFloat(size.width)
        var h = CGFloat(20)
        self.balanceLabel?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        x = balanceLabel?.minX ?? 0
        w = 80
        self.balanceLoaderView?.frame = CGRect(x: x, y: y, width: w, height: h)
        balanceLoaderView?.layer.cornerRadius = 6
        
        h = 31
        y = size.height - h
        x = 0
        w = size.width
        self.amountTextField?.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    func getHeight() -> CGFloat {
        58
    }
    
    func setDelegate(_ delegate: UITextFieldDelegate?) {
        amountTextField?.delegate = delegate
    }
    
    func focus() {
        amountTextField?.becomeFirstResponder()
    }
}
