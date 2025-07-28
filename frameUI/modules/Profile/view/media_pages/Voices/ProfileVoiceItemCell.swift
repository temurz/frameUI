//
//  ProfileVoiceItemCell.swift
//  Tedr
//
//  Created by Kostya Lee on 18/07/25.
//

import UIKit

final class ProfileVoiceItemCell: UICollectionViewCell {
    static let reuseIdentifier = "ProfileVoiceItemCell"
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let playButton = UIButton()
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
        
        playButton.setImage(theme.playIcon, for: .normal)
        playButton.backgroundColor = theme.whiteColor.withAlphaComponent(0.2)
        
        progressView.backgroundColor = .separator
        
        [titleLabel, subtitleLabel, playButton, progressView].forEach {
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
        self.playButton.frame = CGRect(x: x, y: y, width: w, height: h)
        self.playButton.layer.cornerRadius = 12
        
        let textX = playButton.frame.maxX + 12
        let textWidth = bounds.width - textX - padding
        
        x = textX
        y = padding
        w = textWidth
        h = 22
        self.titleLabel.frame = CGRect(x: x, y: y, width: w, height: h)
        
        h = 18
        y = bounds.height - h - padding
        self.subtitleLabel.frame = CGRect(x: x, y: y, width: w, height: h)

        h = 1
        y = bounds.height - h
        w = bounds.width - textX - padding
        self.progressView.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    func configure(title: String, duration: String, date: String) {
        titleLabel.text = "Jane Smith"
        subtitleLabel.text = "0:10  • Apr 27,2025 at 8:22 AM"
    }
    
    static func getHeight() -> CGFloat {
        return 72
    }
}
