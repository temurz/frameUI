//
//  ProfileFileItemCell.swift
//  Tedr
//
//  Created by Kostya Lee on 18/07/25.
//

import UIKit

final class ProfileFileItemCell: UICollectionViewCell {
    static let reuseIdentifier = "ProfileFileItemCell"
    
    private let iconView = UIImageView()
    private let titleLabel = UILabel()
    private let sizeLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupViews() {
        let theme = Theme()
        
        backgroundColor = theme.backgroundPrimaryColor
        
        iconView.contentMode = .scaleAspectFit
        iconView.layer.cornerRadius = 6
        iconView.clipsToBounds = true
        
        titleLabel.font = theme.getFont(size: 17, weight: .semibold)
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.textColor = theme.contentWhite
        
        sizeLabel.font = theme.getFont(size: 16, weight: .regular)
        sizeLabel.textColor = theme.contentSecondary
        
        [iconView, titleLabel, sizeLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let padding: CGFloat = 12
        let vPadding: CGFloat = 8
        let iconSize: CGFloat = 56
        var x: CGFloat = padding
        var y: CGFloat = (bounds.height - iconSize) / 2
        var w: CGFloat = iconSize
        var h: CGFloat = iconSize
        self.iconView.frame = CGRect(x: x, y: y, width: w, height: h)
        self.iconView.layer.cornerRadius = 12
        
        let titleX = iconView.frame.maxX + 12
        sizeLabel.sizeToFit()
        x = titleX
        y = bounds.height - sizeLabel.bounds.height - padding
        w = sizeLabel.bounds.width
        h = sizeLabel.bounds.height
        self.sizeLabel.frame = CGRect(x: x, y: y, width: w, height: h)
        
        y = padding
        w = titleLabel.getWidth()
        h = 22
        self.titleLabel.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    func configure(fileName: String, size: String) {
        iconView.image = UIImage(named: "user3")
        titleLabel.text = "img-5060.jpg"
        sizeLabel.text = "2.2 MB • Apr 27,2025 at 10:10 AM"
    }
    
    static func getHeight() -> CGFloat {
        72
    }
}
