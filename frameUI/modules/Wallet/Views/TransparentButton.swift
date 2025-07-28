//
//  TransparentButton.swift
//  Tedr
//
//  Created by Temur on 29/05/2025.
//


import UIKit

final class TransparentButton: TemplateView {

    private let iconView = UIImageView()
    private let titleLabel = UILabel()
    private var action: (() -> Void)?

    override func initialize() {
        let theme = theme ?? Theme()
        backgroundColor = theme.bgWhiteTransparent10

        iconView.contentMode = .scaleAspectFit
        addSubview(iconView)

        titleLabel.font = theme.getFont(size: 14, weight: .medium)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        addSubview(titleLabel)

        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(tap)
    }

    override func updateSubviewsFrame(_ size: CGSize) {
        let padding: CGFloat = 12
        let iconSize: CGFloat = 24
        let totalHeight: CGFloat = iconSize + 8 + 18

        iconView.frame = CGRect(x: (size.width - iconSize) / 2, y: padding, width: iconSize, height: iconSize)
        
        let w = titleLabel.getWidth()
        let h = titleLabel.textHeight(w)
        titleLabel.frame = CGRect(x: padding, y: iconView.maxY + 4, width: w, height: h)
    }

    func configure(title: String, icon: UIImage?, cornerRadius: CGFloat = 20, action: (() -> Void)? = nil) {
        titleLabel.text = title
        iconView.image = icon
        borderRadius = cornerRadius
        self.action = action
    }

    @objc private func didTap() {
        action?()
    }
}
