//
//  WalletSendNavigationBar.swift
//  Tedr
//
//  Created by Kostya Lee on 29/05/25.
//

import Foundation
import UIKit

class WalletSendNavigationBar: TemplateView {
    private var backButton: UIButton?
    private var titleLabel: UILabel?
    private var tickerLabel: UITickerLabel?
    private var scanButton: UIButton?
    
    var scan: (() -> Void)?
    var back: (() -> Void)?
    
    override func initialize() {
        let theme = Theme()
        
        self.backgroundColor = theme.backgroundPrimaryColor
        
        backButton = UIButton()
        backButton?.tag = 0
        backButton?.setImage(theme.arrowLeftLIcon, for: .normal)
        backButton?.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        self.addSubview(backButton)
        
        titleLabel = UILabel()
        titleLabel?.text = "USDT"
        titleLabel?.font = theme.getFont(size: 18, weight: .bold)
        titleLabel?.textColor = theme.darkTextColor
        self.addSubview(titleLabel)
        
        tickerLabel = UITickerLabel()
        tickerLabel?.configure(text: "ETH")
        self.addSubview(tickerLabel)
        
        scanButton = UIButton()
        scanButton?.tag = 1
        scanButton?.setImage(theme.scanIcon, for: .normal)
        scanButton?.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        self.addSubview(scanButton)
    }
    
    override func updateSubviewsFrame(_ size: CGSize) {
        let padding = 16.0
        var x = CGFloat(padding)
        var w = CGFloat(25)
        var h = CGFloat(w)
        var y = CGFloat(size.height - h - padding)
        self.backButton?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        w = tickerLabel?.getSize().width ?? 0
        h = tickerLabel?.getSize().height ?? 0
        x = size.width/2 - w/2 - 4
        y = size.height - h - padding
        self.tickerLabel?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        w = titleLabel?.getWidth() ?? 0
        h = 20
        x = size.width/2 - w/2
        y = tickerLabel!.minY - h - 2
        self.titleLabel?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        w = 25
        h = w
        x = size.width - w - padding
        y = size.height - h - padding
        self.scanButton?.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    override func updateTheme() {
        let theme = Theme()
        
        backButton?.setImage(theme.arrowLeftLIcon, for: .normal)
        titleLabel?.textColor = theme.darkTextColor
        tickerLabel?.updateTheme()
        scanButton?.setImage(theme.scanIcon, for: .normal)
    }
    
    func configureTitle(asset: WalletAssetRow) {
        self.titleLabel?.text = asset.name.uppercased()
        self.tickerLabel?.configure(text: asset.network)
        self.updateSubviewsFrames()
    }
    
    func getHeight() -> CGFloat {
        let topSafe = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
        return 52 + topSafe
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            back?()
        case 1:
            scan?()
        default:
            break
        }
    }
}
