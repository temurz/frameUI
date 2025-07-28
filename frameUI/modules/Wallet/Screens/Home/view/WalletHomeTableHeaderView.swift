//
//  WalletHomeTableHeaderView.swift
//  Tedr
//
//  Created by Kostya Lee on 16/05/25.
//

import Foundation
import UIKit
/// The header above all content which is used to make content scrollable vertically including balance view, send and receive buttons and banner.
class WalletHomeTableHeaderView: TemplateView {
    
    var balanceView: WalletHomeBalanceView?
    var sendButton: UIButton?
    var receiveButton: UIButton?
    var bannerView: WalletHomeBannerView?
    
    var receiveCallback: (() -> Void)?
    var sendCallback: (() -> Void)?
    
    override func initialize() {
        balanceView = WalletHomeBalanceView()
        self.addSubview(balanceView)
        
        sendButton = UIButton(type: .system)
        sendButton?.tag = 0
        configureActionButton(
            button: sendButton,
            image: Theme().arrowUpRightIcon!,
            title: Strings.send
        )
        
        receiveButton = UIButton(type: .system)
        receiveButton?.tag = 1
        configureActionButton(
            button: receiveButton,
            image: Theme().arrowDownLeftIcon!,
            title: Strings.receive
        )
        
        bannerView = WalletHomeBannerView()
        self.addSubview(bannerView)
    }
    
    private func configureActionButton(button: UIButton?, image: UIImage, title: String) {
        button?.backgroundColor = .white.withAlphaComponent(0.2)
        button?.setTitle(title, for: .normal)
        button?.setImage(image, for: .normal)

        button?.semanticContentAttribute = .forceLeftToRight

        button?.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 5)
        button?.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: -5)

        button?.tintColor = .white
        button?.setTitleColor(.white, for: .normal)
        button?.titleLabel?.font = Theme().getFont(size: 17, weight: .bold)
        
        button?.addTarget(self, action: #selector(actionButtonTapped(_:)), for: .touchUpInside)
        self.addSubview(button)
    }
    
    override func updateSubviewsFrame(_ size: CGSize) {
        let padding = CGFloat(16)
        
        var x = CGFloat(0)
        var y = CGFloat(0)
        var w = CGFloat(size.width)
        var h = CGFloat(balanceView!.getHeight())
        self.balanceView?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        x = padding
        y = balanceView!.maxY + padding*3
        w = (size.width - padding*3)/2
        h = CGFloat(56)
        self.sendButton?.frame = CGRect(x: x, y: y, width: w, height: h)
        sendButton?.layer.cornerRadius = 12
        
        x = sendButton!.maxX + padding
        self.receiveButton?.frame = CGRect(x: x, y: y, width: w, height: h)
        receiveButton?.layer.cornerRadius = 12
        
        x = 0
        y = receiveButton!.maxY + padding*3
        w = size.width
        h = bannerView!.getHeight()
        self.bannerView?.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    override func updateTheme() {
        balanceView?.updateTheme()
        sendButton?.setImage(Theme().arrowUpRightIcon, for: .normal)
        receiveButton?.setImage(Theme().arrowDownLeftIcon, for: .normal)
        bannerView?.updateTheme()
    }
    
    func configure(with wallet: WalletRow) {
        balanceView?.configure(wallet: wallet)
    }
    
    @objc private func actionButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0: // Send
            sendCallback?()
        case 1: // Receive
            receiveCallback?()
        default:
            break
        }
    }
}
