//
//  ChatListCell.swift
//  Tedr
//
//  Created by Kostya Lee on 05/06/25.
//

import Foundation
import UIKit
final class ChatListCell: UITableViewCell {
    static let reuseId = "ChatListCell"

    private var avatarImageView: UIImageView?
    private var titleLabel: UILabel?
    private var subtitleLabel: UILabel?
    private var timeLabel: UILabel?
    private var unreadBadgeLabel: UILabel?
    private var muteIconView: UIImageView?
    private var overlayView: UIView?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        let theme = Theme() 
        
        avatarImageView = UIImageView()
        avatarImageView?.clipsToBounds = true
        avatarImageView?.backgroundColor = .purple
        self.contentView.addSubview(avatarImageView)
        
        titleLabel = UILabel()
        titleLabel?.font = theme.getFont(size: 17, weight: .semibold)
        titleLabel?.textColor = theme.contentWhite
        self.contentView.addSubview(titleLabel)
        
        subtitleLabel = UILabel()
        subtitleLabel?.font = theme.getFont(size: 16, weight: .regular)
        subtitleLabel?.textColor = theme.contentSecondary
        self.contentView.addSubview(subtitleLabel)
        
        timeLabel = UILabel()
        timeLabel?.font = theme.getFont(size: 13, weight: .medium)
        timeLabel?.textColor = theme.contentSecondary
        timeLabel?.textAlignment = .right
        self.contentView.addSubview(timeLabel)
        
        unreadBadgeLabel = UILabel()
        unreadBadgeLabel?.font = theme.getFont(size: 12, weight: .bold)
        unreadBadgeLabel?.textColor = theme.contentWhite
        unreadBadgeLabel?.backgroundColor = theme.whiteColor.withAlphaComponent(0.25)
        unreadBadgeLabel?.clipsToBounds = true
        unreadBadgeLabel?.textAlignment = .center
        self.contentView.addSubview(unreadBadgeLabel)
        
        muteIconView = UIImageView()
        muteIconView?.image = theme.muteIcon?.changeColor(theme.contentSecondary)
        muteIconView?.tintColor = theme.contentSecondary
        muteIconView?.isHidden = true
        self.contentView.addSubview(muteIconView)
        
        overlayView = UIView()
        overlayView?.backgroundColor = theme.backgroundPrimaryColor.withAlphaComponent(0.6)
        overlayView?.isHidden = true
        self.contentView.addSubview(overlayView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let padding = CGFloat(16)
        
        var x = CGFloat(0)
        var y = CGFloat(0)
        var w = CGFloat(0)
        var h = CGFloat(0)

        w = 64
        h = w
        x = padding
        y = size.height/2 - h/2
        self.avatarImageView?.frame = CGRect(x: x, y: y, width: w, height: h)
        avatarImageView?.layer.cornerRadius = h/2

        x = avatarImageView!.frame.maxX + 12
        w = titleLabel!.getWidth() // size.width - x - 85
        h = 20
        y = avatarImageView!.midY - h - 3
        self.titleLabel?.frame = CGRect(x: x, y: y, width: w, height: h)

        w = 20
        h = w
        x = titleLabel!.frame.maxX + 6
        y = titleLabel!.midY - h/2
        self.muteIconView?.frame = CGRect(x: x, y: y, width: w, height: h)

        x = avatarImageView!.frame.maxX + 12
        y = avatarImageView!.midY + 3
        w = size.width - x - 60
        h = 18
        self.subtitleLabel?.frame = CGRect(x: x, y: y, width: w, height: h)

        w = 50
        h = 20
        x = size.width - w - padding
        y = avatarImageView!.midY - h - 3
        self.timeLabel?.frame = CGRect(x: x, y: y, width: w, height: h)

        x = size.width - 36
        y = avatarImageView!.midY + 3
        w = 20
        h = 20
        self.unreadBadgeLabel?.frame = CGRect(x: x, y: y, width: w, height: h)
        unreadBadgeLabel?.layer.cornerRadius = 6
        
        overlayView?.frame = .init(origin: .zero, size: contentView.size)
    }

    func configure(with chat: Chat, isReordering: Bool = false) {
        titleLabel?.text = chat.title
        subtitleLabel?.text = chat.lastMessage
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        timeLabel?.text = formatter.string(from: chat.lastMessageDate ?? Date())

        muteIconView?.isHidden = !chat.isMuted
        unreadBadgeLabel?.isHidden = chat.unreadCount == 0
        unreadBadgeLabel?.text = "\(chat.unreadCount)"

        if let url = chat.avatarURL {
            ImageLoader().downloadImage(url: url, completion: { [weak self] uiImage in
                self?.avatarImageView?.image = uiImage
            })
        } else {
            avatarImageView?.image = UIImage(systemName: "person.circle")
        }
        
        if isReordering {
            if !chat.isPinned {
                overlayView?.isHidden = false
            }
        }
    }
    
    static func getHeight() -> CGFloat {
        return 84
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        overlayView?.isHidden = true
    }
}
