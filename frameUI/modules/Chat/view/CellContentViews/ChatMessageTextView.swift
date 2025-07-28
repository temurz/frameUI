//
//  ChatMessageTextView.swift
//  Tedr
//
//  Created by Kostya Lee on 27/06/25.
//

import Foundation
import UIKit
final class ChatMessageTextView: UIView {
    private let label = UILabel()
    private let timeLabel = UILabel()
    private let readImageView = UIImageView()

    private var isIncoming: Bool = true

    override init(frame: CGRect) {
        super.init(frame: frame)

        let theme = Theme()

        label.numberOfLines = 0
        label.font = ChatMessageTextView.getTextFont()
        label.textColor = theme.contentWhite
        addSubview(label)

        timeLabel.font = theme.getFont(size: 12, weight: .regular)
        timeLabel.textColor = theme.contentWhite
        addSubview(timeLabel)

        readImageView.image = theme.checkIcon
        readImageView.contentMode = .scaleAspectFit
        addSubview(readImageView)
    }

    required init?(coder: NSCoder) { fatalError() }

    func configure(message: ChatMessageRow, content: TextContent) {
        label.text = content.text
        timeLabel.text = ChatDataManager.formatTimeForChat(message.date)
        isIncoming = message.isIncoming

        readImageView.isHidden = isIncoming

        setNeedsLayout()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let timeLabelWidth: CGFloat = isIncoming ? 67 : 82
        let readSize = CGSize(width: 16, height: 16)

        let availableTextWidth = bounds.width - timeLabelWidth

        // Layout label
        let textSize = (label.text as NSString?)?.boundingRect(
            with: CGSize(width: availableTextWidth, height: CGFloat.greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: label.font as Any],
            context: nil
        ).size ?? .zero

        var x: CGFloat = 0
        var y: CGFloat = 0
        var w: CGFloat = availableTextWidth
        var h: CGFloat = ceil(textSize.height)

        label.frame = CGRect(x: x, y: y, width: w, height: h)

        // Layout timeLabel
        let timeSize = timeLabel.sizeThatFits(CGSize(width: timeLabelWidth, height: CGFloat.greatestFiniteMagnitude))
//        x = bounds.width - timeLabelWidth
        x = label.maxX + 6
        y = bounds.height - timeSize.height
        w = timeSize.width
        h = timeSize.height
        timeLabel.frame = CGRect(x: x, y: y, width: w, height: h)

        // Layout readImageView (only for outgoing)
        if !isIncoming {
            x = timeLabel.frame.maxX + 4
            y = timeLabel.frame.minY + (timeLabel.frame.height - readSize.height) / 2
            w = readSize.width
            h = readSize.height

            readImageView.frame = CGRect(x: x, y: y, width: w, height: h)
        }
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let timeLabelWidth: CGFloat = isIncoming ? 70 : 85
        let readImageWidth: CGFloat = isIncoming ? 0 : 16 + 4 // 16 for icon + 4 spacing

        let availableTextWidth = size.width - timeLabelWidth

        let textSize = (label.text as NSString?)?.boundingRect(
            with: CGSize(width: availableTextWidth, height: CGFloat.greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: label.font as Any],
            context: nil
        ).size ?? .zero

        let timeSize = timeLabel.sizeThatFits(CGSize(width: timeLabelWidth, height: CGFloat.greatestFiniteMagnitude))

        let contentHeight = ceil(textSize.height)
        let timeHeight = ceil(timeSize.height)

        // Итоговая высота — максимум текста или времени
        let totalHeight = max(contentHeight, timeHeight)

        // Итоговая ширина — текст + время + иконка
        let totalWidth = ceil(textSize.width) + timeLabelWidth + readImageWidth

        return CGSize(width: totalWidth, height: totalHeight)
    }

    static func getTextFont() -> UIFont {
        Theme().getFont(size: 16, weight: .regular)
    }
}
