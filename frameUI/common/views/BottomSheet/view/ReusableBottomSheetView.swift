//
//  ReusableBottomSheetView.swift
//  Tedr
//
//  Created by Temur on 24/05/2025.
//


import UIKit

class ReusableBottomSheetView: TemplateView, BottomSheetContentView {

    let grabBar = UIView()
    let titleLabel = UILabel()
    let contentView = UIView()

    private var customContent: (UIView & BottomSheetContentView)?

    override func initialize() {
        let theme = theme ?? Theme()
        backgroundColor = theme.backgroundTertiaryColor
        borderRadius = 24

        grabBar.backgroundColor = theme.contentSecondary
        grabBar.layer.cornerRadius = 2
        addSubview(grabBar)

        titleLabel.font = theme.getFont(size: 18, weight: .bold)
        titleLabel.textColor = theme.whiteColor
        titleLabel.textAlignment = .center
        addSubview(titleLabel)

        contentView.backgroundColor = .clear
        addSubview(contentView)
    }

    override func updateSubviewsFrame(_ size: CGSize) {
        let padding: CGFloat = 16
        var x = padding
        var y = padding
        var w = CGFloat(40)
        var h = CGFloat(4)

        x = size.width/2 - w / 2
        grabBar.frame = CGRect(x: x, y: y, width: w, height: h)

        y = grabBar.maxY + padding
        w = titleLabel.getWidth()
        h = 24
        x = size.width/2 - w/2
        titleLabel.frame = CGRect(x: x, y: y, width: w, height: h)

        y = titleLabel.maxY
        x = 0
        w = size.width
        let contentHeight = customContent?.preferredContentHeight() ?? 0
        contentView.frame = CGRect(x: x, y: y, width: w, height: contentHeight)
        
        y = 0
        customContent?.frame = CGRect(x: x, y: y, width: w, height: contentHeight)
    }

    func preferredContentHeight() -> CGFloat {
        let padding: CGFloat = 16
        let headerHeight: CGFloat = 4 + 16 + 24 + 24
        let contentHeight = customContent?.preferredContentHeight() ?? 0
        return padding + headerHeight + contentHeight + padding
    }

    func setTitle(_ text: String) {
        titleLabel.text = text
    }

    func setContentView(_ view: BottomSheetContentView) {
        contentView.subviews.forEach { $0.removeFromSuperview() }
        customContent = view
        contentView.addSubview(view)
        setNeedsLayout()
    }
}
