//
//  WalletHomeBalanceView.swift
//  Tedr
//
//  Created by Kostya Lee on 15/05/25.
//

import Foundation
import UIKit
class WalletHomeBalanceView: TemplateView {
    private var balanceLabel: UILabel?
    private var balanceValueLabel: UILabel?
    private var eyeButton: UIButton?
    private var showHistoryButton: UIButton?

    override func initialize() {
        let theme = Theme()
        
        balanceLabel = UILabel()
        balanceLabel?.text = Strings.balance
        balanceLabel?.font = theme.getFont(size: 16, weight: .regular)
        balanceLabel?.textColor = theme.contentSecondary
        balanceLabel?.textAlignment = .center
        self.addSubview(balanceLabel)
        
        balanceValueLabel = UILabel()
        balanceValueLabel?.font = theme.getFont(size: 32, weight: .bold)
        balanceValueLabel?.textColor = theme.darkTextColor
        balanceValueLabel?.textAlignment = .center
        self.addSubview(balanceValueLabel)

        eyeButton = UIButton()
        eyeButton?.setImage(theme.eyeOffIcon, for: .normal)
        self.addSubview(eyeButton)
        
        showHistoryButton = UIButton()
        showHistoryButton?.setTitle(Strings.showHistory, for: .normal)
        showHistoryButton?.setTitleColor(theme.systemBlueColor, for: .normal)
        showHistoryButton?.titleLabel?.textAlignment = .center
        self.addSubview(showHistoryButton)
    }
    
    override func updateSubviewsFrame(_ size: CGSize) {
        let padding = 16.0
        
        var w = CGFloat(balanceLabel?.getWidth() ?? 0)
        var h = CGFloat(20)
        var x = CGFloat(size.width/2 - w/2)
        var y = CGFloat(padding)
        self.balanceLabel?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        x = padding
        y = balanceLabel!.maxY + padding
        w = size.width - padding * 2 - 36
        h = 48
        self.balanceValueLabel?.frame = CGRect(x: x, y: y, width: w, height: h)

        w = 24
        h = w
        x = size.width - padding - w
        y = size.height/2 - h/2
        self.eyeButton?.frame = CGRect(x: x, y: y, width: w, height: h)

        y = balanceValueLabel!.frame.maxY + padding
        w = showHistoryButton?.titleLabel?.getWidth() ?? 0
        h = 20
        x = size.width/2 - w/2
        self.showHistoryButton?.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    override func updateTheme() {
        let theme = Theme()
        balanceLabel?.textColor = theme.contentSecondary
        balanceValueLabel?.textColor = theme.darkTextColor
        eyeButton?.setImage(theme.eyeOffIcon, for: .normal)
        showHistoryButton?.setTitleColor(theme.systemBlueColor, for: .normal)
    }
    
    func configure(wallet: WalletRow) {
        balanceValueLabel?.text = wallet.balance
    }
    
    func configure(balance: String) {
        balanceValueLabel?.text = balance
    }
    
    func getHeight() -> CGFloat {
        140
    }
}
