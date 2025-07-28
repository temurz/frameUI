//
//  ChatCell.swift
//  Tedr
//
//  Created by Kostya Lee on 11/06/25.
//

import Foundation
import UIKit
final class ChatCell: UITableViewCell {
    static let reuseId = "ChatCell"

    private let bubbleView = UIView()
    private var contentViewContainer: UIView? // Контент внутри bubble

    private var message: ChatMessageRow?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear

        bubbleView.layer.cornerRadius = 16
        bubbleView.layer.masksToBounds = true
        contentView.addSubview(bubbleView)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func prepareForReuse() {
        super.prepareForReuse()
        contentViewContainer?.removeFromSuperview()
        contentViewContainer = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        guard let message, let contentViewContainer else { return }

        let isIncoming = message.isIncoming
        let horizontalPadding: CGFloat = 12
        let verticalPadding: CGFloat = 8
        let maxBubbleWidth = contentView.bounds.width * 0.85

        let availableContentWidth = maxBubbleWidth - horizontalPadding * 2

        let contentSize = contentViewContainer.sizeThatFits(CGSize(width: availableContentWidth, height: .greatestFiniteMagnitude))

        let bubbleWidth = contentSize.width + horizontalPadding * 2
        let bubbleHeight = contentSize.height + verticalPadding * 2

        let x: CGFloat = isIncoming ? 16 : contentView.bounds.width - bubbleWidth - 16
        let y: CGFloat = 8
        bubbleView.frame = CGRect(x: x, y: y, width: bubbleWidth, height: bubbleHeight)

        contentViewContainer.frame = CGRect(
            x: horizontalPadding,
            y: verticalPadding,
            width: contentSize.width,
            height: contentSize.height
        )
    }

    func configure(with message: ChatMessageRow) {
        let theme = Theme()
        self.message = message

        // Удаляем старый контент
        contentViewContainer?.removeFromSuperview()

        // Создаем новый контент
        let contentView = ChatContentViewFactory.view(for: message)
        bubbleView.addSubview(contentView)
        contentViewContainer = contentView

        bubbleView.backgroundColor = message.isIncoming ? theme.chatBubbleIncomingColor : theme.chatBubbleOutcomingColor

        setNeedsLayout()
    }
}
