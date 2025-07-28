//
//  ChatMessageTransactionView.swift
//  Tedr
//
//  Created by Kostya Lee on 27/06/25.
//

import Foundation
import UIKit
final class ChatMessageTransactionView: UIView {

    private let titleLabel = UILabel()
    private let statusLabel = UILabel()
    private let coinImageView = UIImageView()
    private let amountLabel = UILabel()
    private let tickerLabel = UITickerLabel()
    private let actionImageView = UIImageView()
    private let lockImageView = UIImageView()
    private let timeLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(titleLabel)
        addSubview(statusLabel)
        addSubview(coinImageView)
        addSubview(amountLabel)
        addSubview(tickerLabel)
        addSubview(actionImageView)
        addSubview(lockImageView)
        addSubview(timeLabel)

        let theme = Theme()

        titleLabel.font = theme.getFont(size: 16, weight: .semibold)
        titleLabel.textColor = theme.contentWhite
        titleLabel.text = "Transfer"

        statusLabel.font = theme.getFont(size: 12, weight: .medium)
        statusLabel.textColor = .white
        statusLabel.backgroundColor = UIColor.systemTeal
        statusLabel.textAlignment = .center
        statusLabel.layer.cornerRadius = 16
        statusLabel.clipsToBounds = true

        coinImageView.contentMode = .scaleAspectFit
        coinImageView.clipsToBounds = true

        amountLabel.font = theme.getFont(size: 18, weight: .bold)
        amountLabel.textColor = theme.contentWhite

        actionImageView.contentMode = .scaleAspectFit
        actionImageView.image = theme.arrowUpRightIcon

        lockImageView.contentMode = .scaleAspectFit
        lockImageView.image = theme.lockIcon

        timeLabel.font = theme.getFont(size: 14, weight: .regular)
        timeLabel.textColor = theme.contentWhite
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with content: TransactionContent, timeText: String) {
        coinImageView.image = UIImage(named: content.coinImageName)

        let amountText = String(format: "%.2f", content.amount)
        amountLabel.text = "\(amountText) \(content.currency)"

        tickerLabel.configure(text: content.token)
        statusLabel.text = content.statusText ?? "In Progress"
        timeLabel.text = timeText

        lockImageView.isHidden = !content.isLocked
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let padding: CGFloat = 6
        let topPadding: CGFloat = 6
        let coinSize: CGFloat = 46

        var x: CGFloat = 0
        var y: CGFloat = 0
        var w: CGFloat = 0
        var h: CGFloat = 0

        x = padding
        y = topPadding
        w = 150
        h = 24
        titleLabel.frame = CGRect(x: x, y: y, width: w, height: h)

        let statusSize = statusLabel.sizeThatFits(CGSize(width: 100, height: CGFloat.greatestFiniteMagnitude))
        x = bounds.width - statusSize.width - padding * 2
        y = topPadding
        w = statusSize.width + 12
        h = 28
        statusLabel.frame = CGRect(x: x, y: y, width: w, height: h)

        x = padding
        w = coinSize
        h = w
        y = size.height - h - padding
        coinImageView.frame = CGRect(x: x, y: y, width: w, height: h)

        x = coinImageView.frame.maxX + padding
        y = coinImageView.minY
        w = bounds.width - coinImageView.frame.maxX - padding * 3
        h = 24
        amountLabel.frame = CGRect(x: x, y: y, width: w, height: h)

        tickerLabel.sizeToFit()
        x = coinImageView.frame.maxX + padding
        w = tickerLabel.getSize().width + 12
        h = 20
        y = size.height - h - padding
        tickerLabel.frame = CGRect(x: x, y: y, width: w, height: h)

        let timeSize = timeLabel.sizeThatFits(CGSize(width: 100, height: CGFloat.greatestFiniteMagnitude))
        w = timeLabel.getWidth()
        x = size.width - w - padding
        h = timeSize.height
        y = size.height - h - padding
        timeLabel.frame = CGRect(x: x, y: y, width: w, height: h)
        
        w = 20
        h = w
        y = timeLabel.minY - h - 4
        x = size.width - w - padding
        lockImageView.frame = CGRect(x: x, y: y, width: w, height: h)

        x = lockImageView.isHidden ? size.width - w - padding : lockImageView.frame.minX - w - 4
        actionImageView.frame = CGRect(x: x, y: y, width: w, height: h)
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: size.width, height: 100)
    }
}
