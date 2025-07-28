//
//  ChatListStoryCell.swift
//  Tedr
//
//  Created by Kostya Lee on 07/06/25.
//

import Foundation
import UIKit
final class ChatListStoryCell: UICollectionViewCell {
    static let reuseId = "ChatListStoryCell"

    private var outlineView: UIView?
    private var imageView: UIImageView?
    private var nameLabel: UILabel?
    private var plusButton: UIButton?
    
    private let imageLoader: ImageLoader

    override init(frame: CGRect) {
        self.imageLoader = ImageLoader()
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        let theme = Theme()
        
        imageView = UIImageView()
        imageView?.layer.borderColor = theme.bgBlackTransparent20.cgColor
        imageView?.clipsToBounds = true
        imageView?.contentMode = .scaleAspectFill
        contentView.addSubview(imageView)
        
        outlineView = UIView()
        outlineView?.layer.borderColor = theme.bgBlackTransparent20.cgColor
        contentView.addSubview(outlineView)

        nameLabel = UILabel()
        nameLabel?.font = theme.getFont(size: 14, weight: .semibold)
        nameLabel?.textAlignment = .center
        nameLabel?.textColor = theme.contentWhite
        nameLabel?.numberOfLines = 1
        contentView.addSubview(nameLabel)

        plusButton = UIButton()
        plusButton?.setImage(theme.addIcon, for: .normal)
        plusButton?.isHidden = true
        contentView.addSubview(plusButton)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        var x: CGFloat = 0
        var y: CGFloat = 0
        var w: CGFloat = 0
        var h: CGFloat = 0
        
        let outlineWidth = CGFloat(4)

        w = contentView.frame.width
        h = w
        self.outlineView?.frame = CGRect(x: x, y: y, width: w, height: h)
        outlineView?.layer.borderWidth = outlineWidth
        outlineView?.layer.cornerRadius = h/2
        
        w = size.width - outlineWidth*4
        h = w
        x = (contentView.frame.width - w) / 2
        y = x
        self.imageView?.frame = CGRect(x: x, y: y, width: w, height: h)
        imageView?.layer.cornerRadius = h/2

        w = 16
        h = 16
        x = imageView!.frame.maxX - 12
        y = imageView!.frame.maxY - 12
        self.plusButton?.frame = CGRect(x: x, y: y, width: w, height: h)

        w = contentView.frame.width
        h = 20
        x = 0
        y = outlineView!.maxY + 4
        self.nameLabel?.frame = CGRect(x: x, y: y, width: w, height: h)
    }

    func configure(item: Story) {
        nameLabel?.text = item.userName
        plusButton?.isHidden = !item.isMyStory
        
        // Download avatar
        if let url = item.userAvatarURL {
            imageLoader.downloadImage(url: url) { [weak self] image in
                self?.imageView?.image = image
            }
        }
    }
    
    static func getSize() -> CGSize {
        return CGSize(width: 70, height: 100)
    }
}
