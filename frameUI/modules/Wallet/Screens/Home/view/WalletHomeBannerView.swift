//
//  WalletHomeBannerView.swift
//  Tedr
//
//  Created by Kostya Lee on 16/05/25.
//

import Foundation
import UIKit

class WalletHomeBannerView: TemplateView {
    
    private var bannerView: UIImageView?
    private var closeButton: UIButton? // will be invisible
    
    override func initialize() {
        bannerView = UIImageView(image: UIImage(named: "Banner#1"))
        bannerView?.contentMode = .scaleAspectFill
        self.addSubview(bannerView)
        
        closeButton = UIButton()
        closeButton?.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        self.addSubview(closeButton)
    }
    
    override func updateSubviewsFrame(_ size: CGSize) {
        let padding = 16.0
        var x = CGFloat(padding)
        var y = CGFloat(0)
        var w = CGFloat(size.width - padding*2)
        var h = CGFloat(94)
        self.bannerView?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        w = 30
        h = w
        x = size.width - padding*2 - w
        y = padding
        self.closeButton?.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    @objc private func closeButtonTapped() {
        print("Close banner!")
    }
    
    func getHeight() -> CGFloat {
        return 110
    }
}
