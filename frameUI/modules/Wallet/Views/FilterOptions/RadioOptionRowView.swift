//
//  RadioOptionRowView.swift
//  Tedr
//
//  Created by Temur on 24/05/2025.
//

import UIKit

class RadioOptionRowView: TemplateView {

    let label = UILabel()
    let radioButton = CircleRadioButton()

    var onSelect: (() -> Void)?

    var isSelected: Bool = false {
        didSet {
            radioButton.isOn = isSelected
        }
    }

    init(title: String) {
        super.init(frame: .zero)
        label.text = title
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func initialize() {
        let theme = theme ?? Theme()
        backgroundColor = .clear
 
        label.textColor = theme.contentPrimary
        label.font = theme.getFont(size: 17, weight: .semibold)
        addSubview(label)

        radioButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        addSubview(radioButton)

        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapSelf))
        addGestureRecognizer(tap)
    }

    override func updateSubviewsFrame(_ size: CGSize) {
        let padding: CGFloat = 16
        
        var w = CGFloat(24)
        var h = w
        var x = size.width - padding - w
        let y = CGFloat.zero
        radioButton.frame = .init(x: x, y: y, width: w, height: h)
        
        x = padding
        h = size.height
        w = size.width - w - (x*3)
        label.frame = CGRect(x: x, y: y, width: w, height: h)
    }

    func setTitle(_ text: String) {
        label.text = text
    }

    @objc private func didTapSelf() {
        onSelect?()
    }
}
