//
//  CircleRadioButton.swift
//  Tedr
//
//  Created by Temur on 24/05/2025.
//


import UIKit

class CircleRadioButton: UIButton {

    private let innerCircle = UIView()

    var isOn: Bool = false {
        didSet {
            updateAppearance()
        }
    }

    var selectedColor = Theme().systemBlueColor

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        borderRadius = bounds.width / 2
        borderWidth = 2
        borderColor = Theme().contentSecondary
        backgroundColor = .clear

        innerCircle.backgroundColor = selectedColor
        innerCircle.layer.cornerRadius = (bounds.width - 10) / 2
        innerCircle.isHidden = true
        addSubview(innerCircle)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
        innerCircle.frame = CGRect(
            x: (bounds.width - 16) / 2,
            y: (bounds.height - 16) / 2,
            width: 16,
            height: 16
        )
        innerCircle.layer.cornerRadius = 8
    }

    private func updateAppearance() {
        innerCircle.isHidden = !isOn
    }

    func toggle() {
        isOn.toggle()
    }
}
