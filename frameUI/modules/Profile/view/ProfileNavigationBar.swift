//
//  UserProfileNavigationBar.swift
//  Tedr
//
//  Created by Kostya Lee on 09/07/25.
//

import Foundation
import UIKit
final class ProfileNavigationBar: TemplateView {
    private var shadowLayer: CAGradientLayer?
    private var gradientLayer: CAGradientLayer?
    private var titleLabel: UILabel?
    private var subtitleLabel: UILabel?
    private var backButton: UIButton?
    private var moreButton: UIButton?
    
    override func initialize() {
        let theme = Theme()
        
        self.setupGradient()
        self.setupOverlay()
        
        titleLabel = UILabel()
        titleLabel?.text = "Jane Smith"
        titleLabel?.textAlignment = .center
        titleLabel?.textColor = theme.contentWhite
        titleLabel?.font = theme.getFont(size: 16, weight: .semibold)
        self.addSubview(titleLabel)
        
        subtitleLabel = UILabel()
        subtitleLabel?.text = "243 files"
        subtitleLabel?.textAlignment = .center
        subtitleLabel?.textColor = theme.contentWhite
        subtitleLabel?.font = theme.getFont(size: 12, weight: .regular)
        self.addSubview(subtitleLabel)
        
        backButton = UIButton()
        backButton?.setImage(theme.arrowLeftLIcon, for: .normal)
        self.addSubview(backButton)
        
        moreButton = UIButton()
        moreButton?.setImage(theme.dotsVerticalIcon, for: .normal)
        self.addSubview(moreButton)
    }
    
    private func setupOverlay() {
        shadowLayer = CAGradientLayer()
        shadowLayer?.colors = [
            UIColor.black.withAlphaComponent(0.4).cgColor,
            UIColor.clear.cgColor
        ]
        shadowLayer?.startPoint = CGPoint(x: 0.5, y: 0.0)
        shadowLayer?.endPoint = CGPoint(x: 0.5, y: 1.0)

        if let shadowLayer {
            self.layer.insertSublayer(shadowLayer, below: gradientLayer)
        }
    }
    
    private func setupGradient() {
        gradientLayer = CAGradientLayer()
        gradientLayer?.colors = [
            UIColor(red: 1.0, green: 0.4, blue: 0.7, alpha: 1).cgColor,
            UIColor(red: 0.9, green: 0.3, blue: 1.0, alpha: 1).cgColor
        ]
        gradientLayer?.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer?.endPoint = CGPoint(x: 1, y: 1)
        if let gradientLayer = gradientLayer {
            layer.insertSublayer(gradientLayer, at: 0)
        }
    }
    
    override func updateSubviewsFrame(_ size: CGSize) {
        var x: CGFloat = 0
        var y: CGFloat = 0
        var w: CGFloat = 0
        var h: CGFloat = 0
        self.shadowLayer?.frame = bounds
        self.gradientLayer?.frame = bounds
        
        x = 16
        w = 24
        h = w
        y = size.height - h - 12
        self.backButton?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        x = size.width - w - 16
        y = size.height - h - 12
        self.moreButton?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        w = subtitleLabel!.getWidth()
        h = 16
        x = size.width/2 - w/2
        y = size.height - h - 4
        self.subtitleLabel?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        w = titleLabel!.getWidth()
        h = 18
        x = size.width/2 - w/2
        y -= h
        self.titleLabel?.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    func updateOffsetChanged(_ offset: CGFloat) {
        guard let gradientLayer = gradientLayer else { return }

        let screenWidth = UIScreen.main.bounds.width
        let progress = min(max(offset / screenWidth, 0), 1)

        gradientLayer.opacity = Float(progress)
        titleLabel?.alpha = progress
        subtitleLabel?.alpha = progress
    }

    
    func getHeight() -> CGFloat {
        return 88
    }
}
