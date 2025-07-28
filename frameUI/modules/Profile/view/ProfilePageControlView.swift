//
//  StoriesPageControlView.swift
//  Tedr
//
//  Created by Kostya Lee on 16/07/25.
//

import Foundation
import UIKit
final class ProfilePageControlView: UIView {
    var numberOfPages: Int = 0 {
        didSet { setNeedsLayout() }
    }
    var currentPage: Int = 0 {
        didSet { updateProgress() }
    }

    private var segments: [UIView] = []

    private let spacing: CGFloat = 6
    private let activeColor = UIColor.white
    private let inactiveColor = UIColor.white.withAlphaComponent(0.3)

    override func layoutSubviews() {
        super.layoutSubviews()

        // Удаляем старые сегменты
        segments.forEach { $0.removeFromSuperview() }
        segments.removeAll()

        guard numberOfPages > 0 else { return }

        let totalSpacing = spacing * CGFloat(numberOfPages - 1)
        let segmentWidth = (bounds.width - totalSpacing) / CGFloat(numberOfPages)
        let segmentHeight: CGFloat = 3

        for i in 0..<numberOfPages {
            let segment = UIView()
            segment.backgroundColor = i == currentPage ? activeColor : inactiveColor
            segment.layer.cornerRadius = segmentHeight / 2
            let x = CGFloat(i) * (segmentWidth + spacing)
            segment.frame = CGRect(x: x, y: 0, width: segmentWidth, height: segmentHeight)
            addSubview(segment)
            segments.append(segment)
        }
    }

    private func updateProgress() {
        for (index, segment) in segments.enumerated() {
            segment.backgroundColor = index == currentPage ? activeColor : inactiveColor
        }
    }
}

