//
//  BadgeButton.swift
//  Tedr
//
//  Created by Temur on 20/07/2025.
//


import UIKit

class BadgeButton: UIButton {

    private let badgeLabel = UILabel()
    private let badgeContainer = UIView()

    var badgeCount: Int = 0

    init(icon: UIImage?) {
        super.init(frame: .zero)
        setImage(icon?.withRenderingMode(.alwaysTemplate), for: .normal)
        tintColor = .white
        setupButton()
        setupBadge()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
        
        if let imageView = imageView {
            imageView.contentMode = .scaleAspectFit
            let imageSize: CGFloat = 20
            imageView.frame = CGRect(
                x: (bounds.width - imageSize) / 2,
                y: (bounds.height - imageSize) / 2,
                width: imageSize,
                height: imageSize
            )
        }

        let badgeSize: CGFloat = 24
        let badgeWidth = max(badgeSize, badgeLabel.intrinsicContentSize.width + 8)

        if let _ = superview {
            let buttonFrameInSuperview = frame
            badgeContainer.frame = CGRect(
                x: buttonFrameInSuperview.maxX - badgeWidth * 0.6,
                y: buttonFrameInSuperview.minY - badgeSize * 0.4,
                width: badgeWidth,
                height: badgeSize
            )
        }
        
        badgeContainer.layer.cornerRadius = max(badgeWidth, badgeSize) / 2

        badgeLabel.frame = CGRect(
            x: 0,
            y: 0,
            width: badgeContainer.bounds.width,
            height: badgeContainer.bounds.height
        )
    }

    private func setupButton() {
        backgroundColor = Theme().buttonQuaternaryTransparentDefaultBg
        clipsToBounds = false
    }

    private func setupBadge() {
        badgeContainer.backgroundColor = Theme().contentRed
        badgeContainer.clipsToBounds = true

        badgeLabel.textColor = Theme().contentWhite
        badgeLabel.font = .onest(.bold, size: 14)
        badgeLabel.textAlignment = .center
        badgeContainer.addSubview(badgeLabel)

        badgeContainer.isHidden = true
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if let superview = superview {
            superview.addSubview(badgeContainer)
        }
    }

    func setBadge(_ count: Int) {
        badgeCount = count
        if count > 0 {
            badgeLabel.text = "\(count)"
            badgeContainer.isHidden = false
            setNeedsLayout()
        } else {
            badgeContainer.isHidden = true
        }
    }
}
