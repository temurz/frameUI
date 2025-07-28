//
//  PinCodeDotsView.swift
//  Tedr
//
//  Created by Kostya Lee on 09/05/25.
//

import Foundation
import UIKit
class PinDotsView: TemplateView {
    private var dotViews: [UIView] = []
    var numberOfDots = 4
    
    var filledColor: UIColor {
        theme?.whiteColor ?? .white
    }
    
    var emptyColor: UIColor {
        (theme?.whiteColor ?? .white).withAlphaComponent(0.3)
    }
    
    override func initialize() {
        dotViews.forEach { $0.removeFromSuperview() }
        dotViews.removeAll()

        for _ in 0..<numberOfDots {
            let dot = UIView()
            dot.layer.cornerRadius = 10
            dot.backgroundColor = emptyColor
            addSubview(dot)
            dotViews.append(dot)
        }
    }
    
    override func updateSubviewsFrame(_ size: CGSize) {
        let spacing: CGFloat = 20
        let dotSize: CGFloat = 20
        let totalWidth = CGFloat(numberOfDots) * dotSize + CGFloat(numberOfDots - 1) * spacing
        var x = (size.width - totalWidth) / 2
        let y = (size.height - dotSize) / 2

        for dot in dotViews {
            dot.frame = CGRect(x: x, y: y, width: dotSize, height: dotSize)
            dot.layer.cornerRadius = dotSize / 2
            x += dotSize + spacing
        }
    }
    
    func updateDots(count: Int) {
        for (i, dot) in dotViews.enumerated() {
            dot.backgroundColor = i < count ? filledColor : emptyColor
        }
    }
    
    override func updateTheme() {
        updateDots(count: dotViews.filter { $0.backgroundColor == filledColor }.count)
    }
}
