//
//  ProfileContactView.swift
//  Tedr
//
//  Created by Kostya Lee on 09/07/25.
//

import Foundation
import UIKit
final class ProfileContactView: UICollectionViewCell {
    static let reuseIdentifier = "ProfileContactView"

    private let bgView = UIView()
    
    private let emailIcon = UIImageView()
    private let emailLabel = UILabel()
    private let emailValueLabel = UILabel()
    
    private let telephoneIcon = UIImageView()
    private let telephoneLabel = UILabel()
    private let telephoneValueLabel = UILabel()
    
    private let descriptionIcon = UIImageView()
    private let descriptionLabel = UILabel()
    private let descriptionValueLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupUI() {
        let theme = Theme()
        
        bgView.backgroundColor = theme.whiteColor.withAlphaComponent(0.1)
        self.addSubview(bgView)
        
        emailIcon.image = theme.emailIcon
        self.addSubview(emailIcon)
        
        emailLabel.text = "Email"
        emailLabel.textColor = theme.contentSecondary
        self.addSubview(emailLabel)
        
        emailValueLabel.textColor = theme.contentWhite
        self.addSubview(emailValueLabel)
        
        telephoneIcon.image = theme.telephoneIcon
        self.addSubview(telephoneIcon)
        
        telephoneLabel.text = "Telephone"
        telephoneLabel.textColor = theme.contentSecondary
        self.addSubview(telephoneLabel)
        
        telephoneValueLabel.textColor = theme.contentWhite
        self.addSubview(telephoneValueLabel)
        
        descriptionIcon.image = theme.infoIcon
        self.addSubview(descriptionIcon)
        
        descriptionLabel.text = "Description"
        descriptionLabel.textColor = theme.contentSecondary
        self.addSubview(descriptionLabel)
        
        descriptionValueLabel.textColor = theme.contentWhite
        self.addSubview(descriptionValueLabel)
        
        [emailLabel, emailValueLabel, telephoneLabel, telephoneValueLabel, descriptionLabel, descriptionValueLabel].forEach { label in
            label.font = theme.getFont(size: 16, weight: .regular)
        }
        
        emailValueLabel.text = "jane.smith@tedr.com"
        telephoneValueLabel.text = "+1 495 600-20-12"
        descriptionValueLabel.text = "23 years old, programmer from California, Los Angeles"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let bgPadding: CGFloat = 12
        let contentPadding: CGFloat = 24
        let interLabelSpacing: CGFloat = 6
        let blockSpacing: CGFloat = 24
        let iconSize: CGFloat = 24
        let labelHeight: CGFloat = 18
        let valueHeight: CGFloat = 22
        let iconTextSpacing: CGFloat = 12
        let contentWidth = bounds.width - contentPadding * 2
        
        var x: CGFloat = contentPadding
        var y: CGFloat = contentPadding
        var w: CGFloat = 0
        var h: CGFloat = 0
        
        x = bgPadding
        w = bounds.width - x*2
        h = 250
        self.bgView.frame = CGRect(x: x, y: 0, width: w, height: h)
        self.bgView.layer.cornerRadius = 20
        self.bgView.clipsToBounds = true

        // MARK: - Email
        w = iconSize
        h = w
        x = contentPadding
        self.emailIcon.frame = CGRect(x: x, y: y, width: w, height: h)
        
        x += iconSize + iconTextSpacing
        w = contentWidth - iconSize - iconTextSpacing
        h = labelHeight
        self.emailLabel.frame = CGRect(x: x, y: y, width: w, height: h)
        
        y += labelHeight + interLabelSpacing
        h = valueHeight
        self.emailValueLabel.frame = CGRect(x: x, y: y, width: w, height: h)
        
        // MARK: - Telephone
        x = contentPadding
        y += valueHeight + blockSpacing
        w = iconSize
        h = w
        self.telephoneIcon.frame = CGRect(x: x, y: y, width: w, height: h)
        
        x += iconSize + iconTextSpacing
        w = contentWidth - iconSize - iconTextSpacing
        h = labelHeight
        self.telephoneLabel.frame = CGRect(x: x, y: y, width: w, height: h)
        
        y += labelHeight + interLabelSpacing
        h = valueHeight
        self.telephoneValueLabel.frame = CGRect(x: x, y: y, width: w, height: h)
        
        // MARK: - Description
        x = contentPadding
        y += valueHeight + blockSpacing
        w = iconSize
        h = w
        self.descriptionIcon.frame = CGRect(x: x, y: y, width: w, height: h)
        
        x += iconSize + iconTextSpacing
        w = contentWidth - iconSize - iconTextSpacing
        h = labelHeight
        self.descriptionLabel.frame = CGRect(x: x, y: y, width: w, height: h)
        
        y += labelHeight + interLabelSpacing
        h = valueHeight * 2
        self.descriptionValueLabel.frame = CGRect(x: x, y: y, width: w, height: h)
    }

    func configure(number: String, address: String, description: String) {
        telephoneValueLabel.text = number
        emailValueLabel.text = address
        descriptionValueLabel.text = description
    }
    
    static func getHeight() -> CGFloat {
        return 280
    }
}
