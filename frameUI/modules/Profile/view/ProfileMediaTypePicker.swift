//
//  MediaTypeHeaderView.swift
//  Tedr
//
//  Created by Kostya Lee on 09/07/25.
//

import Foundation
import UIKit
final class ProfileMediaTypePicker: UIView {

    private let items = ["Media", "Files", "Voice", "Music", "Links"]
    private var buttons: [UIButton] = []
    private var selectedIndex: Int = 0 {
        didSet { updateSelection() }
    }
    
    private let selectedColor = Theme().contentPink
    private let defaultColor = Theme().contentWhite.withAlphaComponent(0.3)

    var onItemSelected: ((Int) -> Void)?

    private let stackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        let theme = Theme()
        
        backgroundColor = theme.backgroundPrimaryColor

        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        addSubview(stackView)
        
        for (index, title) in items.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = theme.getFont(size: 16, weight: .semibold)
            button.setTitleColor(defaultColor, for: .normal)
            button.tag = index
            button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }

        updateSelection()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds.insetBy(dx: 8, dy: 0)
    }

    func getHeight() -> CGFloat {
        return 44
    }

    @objc private func didTapButton(_ sender: UIButton) {
        selectedIndex = sender.tag
        onItemSelected?(selectedIndex)
    }

    private func updateSelection() {
        for (index, button) in buttons.enumerated() {
            if index == selectedIndex {
                button.setTitleColor(selectedColor, for: .normal)
            } else {
                button.setTitleColor(defaultColor, for: .normal)
            }
        }
    }
    
    func setSelectedIndex(_ index: Int) {
        selectedIndex = index
        onItemSelected?(index)
    }
}
