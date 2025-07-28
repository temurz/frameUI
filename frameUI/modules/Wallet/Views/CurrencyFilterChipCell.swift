//
//  CurrencyFilterChipCell.swift
//  Tedr
//
//  Created by Kostya Lee on 17/05/25.
//

import Foundation
import UIKit
class CurrencyFilterChipCell: UICollectionViewCell {
    
    static let id = "CurrencyCurrencyFilterChipCell"
    
    private var background: UIView?
    private var imageViewBackground: UIView?
    private var imageView: UIImageView?
    private var textLabel: UILabel?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let theme = Theme()
        
        background = UIView()
        background?.backgroundColor = theme.darkTextColor.withAlphaComponent(0.1)
        self.contentView.addSubview(background)
        
        imageViewBackground = UIView()
        imageViewBackground?.backgroundColor = theme.darkTextColor.withAlphaComponent(0.07)
        self.contentView.addSubview(imageViewBackground)

        imageView = UIImageView()
        self.contentView.addSubview(imageView!)
        
        textLabel = UILabel()
        textLabel?.textColor = Theme().whiteColor
        textLabel?.font = CurrencyFilterChipCell.getTextLabelFont()
        textLabel?.contentMode = .center
        self.contentView.addSubview(textLabel!)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let padding = CGFloat(8)
        
        var w = CGFloat(28)
        var h = w
        var y = size.height/2 - h/2
        var x = padding
        self.imageViewBackground?.frame = CGRect(x: x, y: y, width: w, height: h)
        imageViewBackground?.layer.cornerRadius = 7
        
        x += 5
        y += 5
        w -= 10
        h -= 10
        self.imageView?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        h = 22
        w = textLabel?.getWidth() ?? 0
        x = (imageViewBackground?.maxX ?? 0) + padding
        y = size.height/2 - h/2
        self.textLabel?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        background?.frame = self.bounds
        background?.layer.cornerRadius = 16
    }

    func configure(with title: String, selected: Bool = false, disabled: Bool = false) {
        textLabel?.text = title.uppercased()

        var iconName = (title == Strings.allNetworks) ? "all_networks_icon" : "\(title.lowercased())_icon_white"
        
        /// All casees from Network type
        switch title.lowercased() {
        case "bitcoin":
            iconName = "btc_icon_white"
        case "fiat":
            iconName = "ustt_icon_white"
        case "bsc":
            iconName = "bnb_icon_white"
        default:
            break
        }
        
        imageView?.image = UIImage(named: iconName)?.withAlignmentRectInsets(
            UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        )

        background?.backgroundColor = selected
            ? Theme().tabbarUnionBackgroundColor
            : Theme().darkTextColor.withAlphaComponent(0.1)

        imageViewBackground?.backgroundColor = Theme().darkTextColor.withAlphaComponent(0.07)
        textLabel?.textColor = Theme().whiteColor

        setNeedsLayout()
    }

    
    static func getTextLabelFont() -> UIFont {
        Theme().getFont(size: 15, weight: .regular)
    }
}
