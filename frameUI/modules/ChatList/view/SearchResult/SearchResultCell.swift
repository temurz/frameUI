//
//  SearchResultCell.swift
//  Tedr
//
//  Created by Temur on 11/06/2025.
//

import UIKit

final class SearchResultCell: UITableViewCell {
    static let reuseId = "SearchResultCell"
    
    private let avatarView = UIImageView()
    private let nameLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let messageLabel = UILabel()
    private let timeLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        let theme = Theme()
        
        avatarView.backgroundColor = .gray
        avatarView.borderRadius = 20
        avatarView.tintColor = .lightGray

        nameLabel.font = theme.onestFont(size: 17, weight: .semiBold)
        nameLabel.textColor = theme.contentPrimary

        subtitleLabel.font = theme.onestFont(size: 16, weight: .regular)
        subtitleLabel.textColor = theme.contentSecondary

        messageLabel.font = theme.onestFont(size: 16, weight: .regular)
        messageLabel.textColor = theme.contentSecondary

        timeLabel.font = theme.onestFont(size: 13, weight: .regular)
        timeLabel.textColor = theme.contentSecondary
        timeLabel.textAlignment = .right

        contentView.addSubview(avatarView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(messageLabel)
        contentView.addSubview(timeLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        avatarView.frame = CGRect(x: 16, y: 10, width: 40, height: 40)
        nameLabel.frame = CGRect(x: 64, y: 10, width: contentView.frame.width - 130, height: 20)
        subtitleLabel.frame = CGRect(x: 64, y: 30, width: contentView.frame.width - 80, height: 18)
        messageLabel.frame = CGRect(x: 64, y: 30, width: contentView.frame.width - 130, height: 18)
        timeLabel.frame = CGRect(x: contentView.frame.width - 60, y: 10, width: 50, height: 18)
    }

    func configure(_ item: ChatSearchResult) {
        nameLabel.text = item.name
        subtitleLabel.isHidden = item.subtitle == nil
        subtitleLabel.text = item.subtitle
        messageLabel.isHidden = item.message == nil
        messageLabel.text = item.message
        timeLabel.isHidden = item.time == nil
        timeLabel.text = item.time
        if let url = item.imageUrl {
            ImageLoader().downloadImage(url: url, completion: { [weak self] uiImage in
                self?.avatarView.image = uiImage
            })
        } else {
            avatarView.image = UIImage(systemName: "person.circle")
        }
    }
}
