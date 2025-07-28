//
//  NewChatButton.swift
//  Tedr
//
//  Created by Temur on 09/07/2025.
//

import UIKit

class CreateChatButton: TemplateView {
    private let iconBgView = UIView()
    private let iconImageView = UIImageView()
    private let textLabel = UILabel()
    
    override func initialize() {
        let theme = theme ?? Theme()
        iconBgView.backgroundColor = theme.whiteColor.withAlphaComponent(0.2)
        self.addSubview(iconBgView)
        
        iconBgView.addSubview(iconImageView)
        
        textLabel.font = .onest(.medium, size: 17)
        textLabel.textColor = theme.contentPrimary
        self.addSubview(textLabel)
    }
    
    override func updateSubviewsFrame(_ size: CGSize) {
        let padding = Constants.padding
        var x = CGFloat(16)
        var y = CGFloat(8)
        var w = CGFloat(56)
        var h = w
        self.iconBgView.frame = .init(x: x, y: y, width: w, height: h)
        iconBgView.borderRadius = Constants.BorderRadius.radius16
        
        y = 16
        w = 24
        h = w
        self.iconImageView.frame = .init(x: x, y: y, width: w, height: h)
        
        x = iconBgView.maxX + padding
        w = size.width - padding*3 - iconBgView.size.width
        h = textLabel.textHeight(w)
        y = iconBgView.centerY - h/2
        self.textLabel.frame = .init(x: x, y: y, width: w, height: h)
    }
    
    func update(icon: UIImage?, title: String) {
        iconImageView.image = icon
        textLabel.text = title
        
        updateSubviewsFrame(self.size)
    }
}
