//
//  WalletHomeHeaderView.swift
//  Tedr
//
//  Created by Kostya Lee on 13/05/25.
//

import Foundation
import UIKit

class WalletHomeHeaderView: TemplateView {
    
    private var visualEffectView: UIVisualEffectView? // For blur background
    private var swapButton: UIButton?
    private var titleLabel: UILabel?
    private var scanButton: UIButton?
    private var searchButton: UIButton?
    
    var headerSwapCallback: (() -> Void)?
    var headerScanCallback: (() -> Void)?
    var headerSearchCallback: (() -> Void)?
    
    override func initialize() {
        let theme = Theme()
        
        let blurEffect = UIBlurEffect(style: .dark)
        visualEffectView = UIVisualEffectView(effect: blurEffect)

        swapButton = UIButton()
        swapButton?.setImage(theme.swapIcon, for: .normal)
        swapButton?.tag = 0
        swapButton?.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        visualEffectView?.contentView.addSubview(swapButton!)

        titleLabel = UILabel()
        titleLabel?.text = Strings.wallet
        titleLabel?.font = theme.getFont(size: 18, weight: .bold)
        titleLabel?.textColor = theme.darkTextColor
        visualEffectView?.contentView.addSubview(titleLabel!)

        scanButton = UIButton()
        scanButton?.setImage(theme.scanIcon, for: .normal)
        scanButton?.tag = 1
        scanButton?.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        visualEffectView?.contentView.addSubview(scanButton!)

        searchButton = UIButton()
        searchButton?.setImage(theme.searchIcon, for: .normal)
        searchButton?.tag = 2
        searchButton?.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        visualEffectView?.contentView.addSubview(searchButton!)
        
        self.addSubview(visualEffectView)
    }

    override func updateTheme() {
        let theme = Theme()
        
        backgroundColor = theme.backgroundColor
        swapButton?.setImage(theme.swapIcon, for: .normal)
        titleLabel?.font = theme.getFont(size: 18, weight: .bold)
        titleLabel?.textColor = theme.darkTextColor
        scanButton?.setImage(theme.dappsIcon, for: .normal)
        searchButton?.setImage(theme.searchIcon, for: .normal)
    }

    override func updateSubviewsFrame(_ size: CGSize) {
        let padding: CGFloat = 16

        var x = CGFloat(0)
        var y = CGFloat(0)
        var w = CGFloat(size.width)
        var h = CGFloat(getHeight())
        self.visualEffectView?.frame = CGRect(x: x, y: y, width: w, height: h)

        x = padding
        w = 36
        h = 36
        y = visualEffectView!.frame.height - 12 - h
        self.swapButton?.frame = CGRect(x: x, y: y, width: w, height: h)

        titleLabel?.sizeToFit()
        w = titleLabel?.frame.width ?? 0
        h = titleLabel?.frame.height ?? 0
        x = size.width/2 - w/2
        y = swapButton!.centerY - h/2
        self.titleLabel?.frame = CGRect(x: x, y: y, width: w, height: h)

        w = 36
        h = 36
        x = size.width - padding - w
        y = visualEffectView!.frame.height - 12 - h
        self.searchButton?.frame = CGRect(x: x, y: y, width: w, height: h)

        y = visualEffectView!.frame.height - 12 - h
        x = searchButton!.frame.minX - w
        self.scanButton?.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    func getHeight() -> CGFloat {
        let topSafe = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
        return 52 + topSafe
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            headerSwapCallback?()
        case 1:
            headerScanCallback?()
        case 2:
            headerSearchCallback?()
        default:
            break
        }
    }
}
