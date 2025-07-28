//
//  SplashView.swift
//  Tedr
//
//  Created by GK on 11/03/25.
//

import Foundation
import UIKit
protocol SplashViewDelegate: AnyObject {
    func signIn()
    func skipRegistration()
}

class SplashView: TemplateView {
    weak var delegate: SplashViewDelegate?
    var imgView: UIImageView?
    var titleLbl: UILabel?
    var signInBtn: UIButton?
    var skipBtn: UIButton?
    
    override func initialize() {
        imgView = UIImageView.initStyled()
        self.addSubview(imgView)
        
        titleLbl = UILabel.initStyled(LabelStyle(font: Theme().getFont(size: 55, weight: .bold), textColor: Theme().darkTextColor, numberOfLines: 3, adjustsFontSizeToFitWidth: true))
        self.addSubview(titleLbl)
        
        signInBtn = UIButton()
        signInBtn?.titleLabel?.adjustsFontSizeToFitWidth = true
        signInBtn?.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        self.addSubview(signInBtn)
        
        skipBtn = UIButton()
        skipBtn?.titleLabel?.adjustsFontSizeToFitWidth = true
        skipBtn?.addTarget(self, action: #selector(skip), for: .touchUpInside)
        self.addSubview(skipBtn)
    }
    
    override func updateTheme() {
        guard let theme else { return }
        titleLbl?.applyStyle(LabelStyle(font: theme.getFont(size: 55, weight: .bold), textColor: theme.darkTextColor, numberOfLines: 3, adjustsFontSizeToFitWidth: true))
        
        let signInTitle = NSMutableAttributedString(string: translate("Already have an account? "), textColor: theme.darkTextColor)
        signInTitle.append(NSAttributedString(string: translate("Sign in"), textColor: theme.systemBlueColor))
        signInBtn?.setAttributedTitle(signInTitle, for: .normal)
        signInBtn?.titleLabel?.font = theme.getFont(size: 16, weight: .regular)
        signInBtn?.titleLabel?.adjustsFontSizeToFitWidth = true
        
        skipBtn?.setTitle(translate("get_started"), for: .normal)
        skipBtn?.setTitleColor(theme.whiteColor, for: .normal)
        skipBtn?.titleLabel?.font = theme.getFont(size: 18, weight: .medium)
        skipBtn?.backgroundColor = theme.orangeColor
    }
    
    override func updateSubviewsFrame(_ size: CGSize) {
        var x = CGFloat(16)
        var w = size.width - 2*x
        var h = CGFloat(24)
        var y = size.height - h - safeAreaInsets.bottom - 16
        self.signInBtn?.frame = .init(x: x, y: y, width: w, height: h)
        
        h = 50
        y = (signInBtn?.frame.minY ?? 0) - h - 16
        self.skipBtn?.frame = .init(x: x, y: y, width: w, height: h)
        skipBtn?.borderRadius = 10
        
        y = safeAreaInsets.top + 16
        h = proportionalFontSizeFromFigma(designFontSize: titleLbl?.font.pointSize ?? 55) * 3 + 10
        self.titleLbl?.frame = .init(x: x, y: y, width: w, height: h)
        
        x = 0
        w = size.width
        y = titleLbl?.maxY ?? 0
        h = size.height - y
        self.imgView?.frame = .init(x: x, y: y, width: w, height: h)
    }
    
    @objc private func signIn() {
        delegate?.signIn()
    }
    
    @objc private func skip() {
        delegate?.skipRegistration()
    }
}

