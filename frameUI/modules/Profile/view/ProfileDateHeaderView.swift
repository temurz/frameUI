//
//  DateHeaderView.swift
//  Tedr
//
//  Created by Kostya Lee on 09/07/25.
//

import Foundation
import UIKit
final class ProfileDateHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "ProfileDateHeaderView"

    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        let theme = Theme()
        
        backgroundColor = .clear

        titleLabel.font = theme.getFont(size: 14, weight: .medium)
        titleLabel.textColor = theme.contentSecondary
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let padding = CGFloat(16)
        let h = CGFloat(18)
        let y = size.height/2 - h/2
        let w = titleLabel.getWidth()
        self.titleLabel.frame = CGRect(x: padding, y: y, width: w, height: h)
    }

    func configure(with dateString: String) {
        titleLabel.text = dateString
    }
}
