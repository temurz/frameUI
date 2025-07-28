//
//  ProfileLinkItemCell.swift
//  Tedr
//
//  Created by Kostya Lee on 18/07/25.
//

import UIKit

final class ProfileLinkItemCell: UICollectionViewCell {
    static let reuseIdentifier = "ProfileLinkItemCell"
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let linkLabel = UILabel()
    private let imageView = UIButton()
    private let progressView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupViews() {
        let theme = Theme()
        backgroundColor = theme.backgroundPrimaryColor
        
        titleLabel.font = theme.getFont(size: 17, weight: .semibold)
        titleLabel.textColor = theme.contentWhite
        
        subtitleLabel.font = theme.getFont(size: 16, weight: .regular)
        subtitleLabel.textColor = theme.contentSecondary
        
        linkLabel.font = theme.getFont(size: 16, weight: .regular)
        linkLabel.textColor = theme.systemBlueColor
        
        imageView.setImage(theme.linkIcon, for: .normal)
        imageView.backgroundColor = theme.whiteColor.withAlphaComponent(0.2)
        
        progressView.backgroundColor = .separator
        
        [titleLabel, subtitleLabel, linkLabel, imageView, progressView].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let padding: CGFloat = 12
        
        var w: CGFloat = 56
        var h: CGFloat = w
        var x: CGFloat = padding
        var y: CGFloat = (bounds.height - h) / 2
        self.imageView.frame = CGRect(x: x, y: y, width: w, height: h)
        self.imageView.layer.cornerRadius = 12
        
        let textX = imageView.frame.maxX + 12
        let textWidth = bounds.width - textX - padding
        
        x = textX
        y = padding
        w = textWidth
        h = 22
        self.titleLabel.frame = CGRect(x: x, y: y, width: w, height: h)
        
        h = 18
        y = bounds.height - h - padding
        self.linkLabel.frame = CGRect(x: x, y: y, width: w, height: h)

        h = 1
        y = bounds.height - h
        w = bounds.width - textX - padding
        self.progressView.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    func configure(title: String) {
        titleLabel.text = "Instagram"
        linkLabel.text = "https://www.instagram.com/news/2025"
    }
    
    static func getDefaultHeight() -> CGFloat {
        return 72
    }
}
