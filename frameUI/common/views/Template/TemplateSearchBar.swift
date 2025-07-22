//
//  TemplateSearchBar.swift
//  Tedr
//
//  Created by Kostya Lee on 19/05/25.
//

import Foundation
import UIKit
class TemplateSearchBar: UIView, UITextFieldDelegate {

    private var textField: UITextField?
    private var iconView: UIImageView?
    
    var placeholder: String? {
        didSet {
            textField?.placeholder = placeholder
        }
    }

    var textDidChange: ((String) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        backgroundColor = UIColor.white.withAlphaComponent(0.2)
        clipsToBounds = true

        iconView = UIImageView(image: Theme().searchIcon)
        iconView?.contentMode = .scaleAspectFit
        addSubview(iconView!)

        textField = UITextField()
        textField?.placeholder = "Search"
        textField?.font = Theme().getFont(size: 16, weight: .regular)
        textField?.textColor = Theme().whiteColor
        textField?.attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: [
                .foregroundColor: Theme().whiteColor.withAlphaComponent(0.6)
            ]
        )
        textField?.delegate = self
        textField?.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        textField?.returnKeyType = .search
        addSubview(textField!)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = self.getHeight() / 2
        
        var x = CGFloat(0)
        var y = CGFloat(0)
        var w = CGFloat(0)
        var h = CGFloat(0)

        let padding: CGFloat = 12
        let iconSize: CGFloat = 20

        x = padding
        y = (bounds.height - iconSize) / 2
        w = iconSize
        h = iconSize
        iconView?.frame = CGRect(x: x, y: y, width: w, height: h)

        x = x + w + 8
        y = 0
        w = bounds.width - x - padding
        h = bounds.height
        textField?.frame = CGRect(x: x, y: y, width: w, height: h)
    }

    func getHeight() -> CGFloat {
        44
    }
    
    func setText(_ text: String) {
        textField?.text = text
    }

    func getText() -> String {
        return textField?.text ?? ""
    }

    func textFieldBecomeFirstResponder() {
        textField?.becomeFirstResponder()
    }

    func textFieldResignFirstResponder() {
        textField?.resignFirstResponder()
    }

    @objc private func textChanged() {
        textDidChange?(textField?.text ?? "")
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
