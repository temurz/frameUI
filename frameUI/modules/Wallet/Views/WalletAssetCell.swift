//
//  WalletAssetCell.swift
//  Tedr
//
//  Created by Kostya Lee on 16/05/25.
//

import Foundation
import UIKit

/// For displaying currency details: Example - bitcoin icon, bitcoin title, bitcoin market value, bitcoin 24hr change
class WalletAssetCell: UITableViewCell {

    static let id = "WalletAssetCell"
    
    private var iconView: UIImageView?
    private var nameLabel: UILabel?
    private var tickerLabel: UITickerLabel?
    private var priceLabel: UILabel?
    private var changeLabel: UILabel?
    private var amountLabel: UILabel?
    private var valueLabel: UILabel?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let theme = Theme()
        
        backgroundColor = .clear
        selectionStyle = .none

        iconView = UIImageView()
        iconView?.clipsToBounds = true
        iconView?.contentMode = .scaleAspectFit
        contentView.addSubview(iconView!)

        nameLabel = UILabel()
        nameLabel?.font = theme.getFont(size: 16, weight: .regular)
        nameLabel?.textColor = theme.darkTextColor
        contentView.addSubview(nameLabel!)

        tickerLabel = UITickerLabel()
        contentView.addSubview(tickerLabel!)

        priceLabel = UILabel()
        priceLabel?.font = theme.getFont(size: 15, weight: .medium)
        priceLabel?.textColor = theme.darkTextColor
        contentView.addSubview(priceLabel!)

        changeLabel = UILabel()
        changeLabel?.font = theme.getFont(size: 14, weight: .semibold)
        changeLabel?.textColor = theme.systemGreenColor
        contentView.addSubview(changeLabel!)

        amountLabel = UILabel()
        amountLabel?.font = theme.getFont(size: 16, weight: .semibold)
        amountLabel?.textColor = theme.darkTextColor
        amountLabel?.textAlignment = .right
        contentView.addSubview(amountLabel!)

        valueLabel = UILabel()
        valueLabel?.font = theme.getFont(size: 14, weight: .regular)
        valueLabel?.textColor = theme.contentSecondary
        valueLabel?.textAlignment = .right
        contentView.addSubview(valueLabel!)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let padding: CGFloat = 16
        let spacing: CGFloat = 8

        var x: CGFloat = 0
        var y: CGFloat = 0
        var w: CGFloat = 0
        var h: CGFloat = 0

        w = 48
        h = w
        x = padding
        y = padding
        self.iconView?.frame = CGRect(x: x, y: y, width: w, height: h)
        iconView?.layer.cornerRadius = 16

        nameLabel?.sizeToFit()
        w = nameLabel?.frame.width ?? 0
        h = nameLabel?.frame.height ?? 20
        x = (iconView?.frame.maxX ?? 0) + spacing
        y = padding
        self.nameLabel?.frame = CGRect(x: x, y: y, width: w, height: h)

        w = tickerLabel?.getSize().width ?? 0
        h = tickerLabel?.getSize().height ?? 0
        x = (nameLabel?.frame.maxX ?? 0) + 6
        y = (nameLabel?.centerY ?? 0) - 10
        self.tickerLabel?.frame = CGRect(x: x, y: y, width: w, height: h)

        w = min(priceLabel?.getWidth() ?? 0, size.width * 0.6)
        h = 20
        x = (iconView?.frame.maxX ?? 0) + spacing
        y = (nameLabel?.frame.maxY ?? 0) + 2
        self.priceLabel?.frame = CGRect(x: x, y: y, width: w, height: h)

        w = changeLabel?.getWidth() ?? 0
        h = 20
        x = (priceLabel?.frame.maxX ?? 0) + spacing
        y = priceLabel?.frame.minY ?? 0
        self.changeLabel?.frame = CGRect(x: x, y: y, width: w, height: h)

        w = amountLabel?.getWidth() ?? 0
        h = 20
        x = bounds.width - padding - w
        y = padding
        self.amountLabel?.frame = CGRect(x: x, y: y, width: w, height: h)

        w = valueLabel?.getWidth() ?? 0
        h = 20
        x = bounds.width - padding - w
        y = (amountLabel?.frame.maxY ?? 0) + 6
        self.valueLabel?.frame = CGRect(x: x, y: y, width: w, height: h)
    }

    static func getHeight() -> CGFloat {
        return 80
    }
    
    func configure(icon: UIImage?, name: String, ticker: String, price: String, change: String, amount: String, value: String) {
        iconView?.image = icon
        nameLabel?.text = name
        tickerLabel?.configure(text: ticker)
        priceLabel?.text = price
        changeLabel?.text = change
        amountLabel?.text = amount
        valueLabel?.text = value
    }
    
    func configure(asset: WalletAssetRow) {
        iconView?.image = UIImage(named: "\(asset.icon)_logo")
        nameLabel?.text = asset.name
        tickerLabel?.configure(text: asset.network)
        priceLabel?.text = "$\(asset.amountInUsd)"
        changeLabel?.text = generateRandomDecimal()
        amountLabel?.text = "$\(asset.amountInUsd)"
        valueLabel?.text = "$\(asset.amountInUsd)"
    }
    
    func generateRandomDecimal(from: Double = 1.0, to: Double = 30.0) -> String {
        let randomValue = Double.random(in: from...to)
        return String(format: "%.2f", randomValue)
    }
}

