//
//  SearchResultPanel.swift
//  Tedr
//
//  Created by Temur on 22/06/2025.
//

import UIKit

// Shown when user searches in chat
class SearchResultPanel: TemplateView {
    var calendarButton: UIButton?
    var resultLabel: UILabel?
    var upButton: UIButton?
    var downButton: UIButton?
    
    override func initialize() {
        let theme = theme ?? Theme()
        self.backgroundColor = theme.backgroundSecondaryColor
        
        calendarButton = UIButton()
        calendarButton?.setImage(theme.calendarIcon, for: .normal)
        if #available(iOS 15.0, *) {
            calendarButton?.configuration?.imagePadding = 10
        } else {
            calendarButton?.imageEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
        }
        self.addSubview(calendarButton)
        
        resultLabel = UILabel()
        resultLabel?.textColor = theme.contentWhite
        resultLabel?.font = theme.onestFont(size: 16, weight: .regular)
        self.addSubview(resultLabel)
        
        downButton = UIButton()
        downButton?.setImage(theme.arrowDownBigIcon, for: .normal)
        if #available(iOS 15.0, *) {
            downButton?.configuration?.imagePadding = 10
        } else {
            downButton?.imageEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
        }
        self.addSubview(downButton)
        
        upButton = UIButton()
        upButton?.setImage(theme.arrowUpBigIcon, for: .normal)
        if #available(iOS 15.0, *) {
            upButton?.configuration?.imagePadding = 10
        } else {
            upButton?.imageEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
        }
        self.addSubview(upButton)
    }
    
    override func updateSubviewsFrame(_ size: CGSize) {
        let padding = CGFloat(16)
        var x: CGFloat = 16
        var y: CGFloat = 16
        var w: CGFloat = 40
        var h: CGFloat = w
        self.calendarButton?.frame = .init(x: x, y: y, width: w, height: h)
        
        x = size.width - w - x
        self.downButton?.frame = .init(x: x, y: y, width: w, height: h)
        
        x -= w
        self.upButton?.frame = .init(x: x, y: y, width: w, height: h)
        
        x = (calendarButton?.maxX ?? 56) + padding/2
        w = size.width - 120 - padding*3
        h = size.height - padding*2
        y = (calendarButton?.centerY ?? 16) - h/2
        self.resultLabel?.frame = .init(x: x, y: y, width: w, height: h)
    }
    
    func updateResultLabel(_ text: String) {
        resultLabel?.text = text
    }
}
