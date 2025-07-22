//
//  ThemeExtension.swift
//  Tedr
//
//  Created by GK on 11/03/25.
//

import Foundation
import UIKit
extension UIButton {
    func setBackgroundColor(_ color: UIColor, forState: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(colorImage, for: forState)
    }
    
    func applyButtonStyle(_ style: ButtonStyle, state: UIControl.State = .normal) {
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.titleLabel?.font = style.font
        self.setTitle(style.title, for: state)
        self.setTitleColor(style.titleColor, for: state)
        if let backgroundColor = style.backgroundColor {
            self.setBackgroundColor(backgroundColor, forState: state)
        }
        
        self.imageView?.clipsToBounds = true
        self.imageView?.contentMode = .scaleAspectFit
        if style.selectedTitleColor != nil {
            self.setTitleColor(style.selectedTitleColor, for: .selected)
        }
        if style.image != nil {
            self.setImage(style.image, for: .normal)
        }
        if style.disabledImage != nil {
            self.setImage(style.image, for: .disabled)
        }
        if style.selectedImage != nil {
            self.setImage(style.selectedImage, for: .selected)
        }
        if style.borderRadius != nil {
            self.borderRadius = style.borderRadius!
        }
        if style.borderColor != nil {
            self.borderColor = style.borderColor!
        }
    }
    
    static func initStyled(_ style: ButtonStyle? = nil) -> UIButton {
        let view = UIButton()
        
        if let style = style {
            view.applyButtonStyle(style)
        } else {
            // Apply default style when no style is provided
            let defaultStyle = ButtonStyle(
                font: UIFont.systemFont(ofSize: 16, weight: .regular),
                titleColor: .systemBlue,
                backgroundColor: .clear
            )
            view.applyButtonStyle(defaultStyle)
        }
        
        return view
    }
}

extension UIImageView {
    func applyStyle(contentMode: UIView.ContentMode = .scaleAspectFit, clipsToBounds: Bool = true, _ image: UIImage? = nil) {
        self.contentMode = contentMode
        self.image = image
        self.clipsToBounds = clipsToBounds
    }
    
    static func initStyled(contentMode: UIView.ContentMode = .scaleAspectFit, clipsToBounds: Bool = true, _ image: UIImage? = nil) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = contentMode
        imageView.image = image
        imageView.clipsToBounds = clipsToBounds
        
        return imageView
    }
}

extension UILabel {
    static func initStyled(_ style: LabelStyle) -> UILabel {
        let view = UILabel()
        view.applyStyle(style)
        
        return view
    }
    
    func applyStyle(_ style: LabelStyle) {
        font = style.font
        textColor = style.textColor
        if let text = style.text {
            self.text = text
        }
        textAlignment = style.textAlignment ?? .left
        if style.numberOfLines != nil {
            numberOfLines = style.numberOfLines!
        }
        if style.borderRadius != nil {
            borderRadius = style.borderRadius!
        }
        if style.borderColor != nil {
            borderColor = style.borderColor!
        }
        if style.backgroundColor != nil {
            backgroundColor = style.backgroundColor!
        }
        
        adjustsFontSizeToFitWidth = style.adjustsFontSizeToFitWidth ?? false
    }
}

extension UITextField {
    static func initStyled(_ style: TextFieldStyle? = nil) -> UITextField {
        let textField = UITextField()
        if let style = style {
            textField.applyStyle(style)
        }
        return textField
    }
    
    func applyStyle(_ style: TextFieldStyle) {
        if let font = style.font {
            self.font = font
        }
        
        if let textColor = style.textColor {
            self.textColor = textColor
        }
        
        if let placeholder = style.placeholder {
            self.placeholder = placeholder
        }
        
        if let placeholderColor = style.placeholderColor, let placeholder = self.placeholder {
            self.attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
            )
        }
        
        if let backgroundColor = style.backgroundColor {
            self.backgroundColor = backgroundColor
        }
        
        if let borderColor = style.borderColor {
            self.borderColor = borderColor
        }
        
        if let borderRadius = style.borderRadius {
            self.borderRadius = borderRadius
        }
        
        if let keyboardType = style.keyboardType {
            self.keyboardType = keyboardType
        }
        
        if let textAlignment = style.textAlignment {
            self.textAlignment = textAlignment
        }
        
        if let isSecureTextEntry = style.isSecureTextEntry {
            self.isSecureTextEntry = isSecureTextEntry
        }
        
        if let autocorrectionType = style.autocorrectionType {
            self.autocorrectionType = autocorrectionType
        }
        
        if let autocapitalizationType = style.autocapitalizationType {
            self.autocapitalizationType = autocapitalizationType
        }
    }
}

extension BackwardDetectingTextField {
    static func initBackwardStyled(_ style: TextFieldStyle? = nil) -> BackwardDetectingTextField {
        let textField = BackwardDetectingTextField()
        if let style = style {
            textField.applyStyle(style)
        }
        return textField
    }
}

extension UICollectionView {
    static func initStyled(with layout: UICollectionViewFlowLayout? = nil, direction: ScrollDirection? = nil, backgroundColor: UIColor = .clear, showsHorizontalScrollIndicator: Bool = false, showsVerticalScrollIndicator: Bool = false, cells: [(AnyClass?, String)], headers: [(AnyClass?, String)] = [], footers: [(AnyClass?, String)] = [], dataSource: UICollectionViewDataSource? = nil, delegate: UICollectionViewDelegate? = nil) -> UICollectionView {
        var layout = layout
        if layout == nil {
            layout = UICollectionViewFlowLayout()
        }
        if direction != nil {
            layout?.scrollDirection = direction!
        }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout!)
        collectionView.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
        collectionView.showsVerticalScrollIndicator = showsVerticalScrollIndicator
        collectionView.backgroundColor = backgroundColor
        collectionView.contentInsetAdjustmentBehavior = .never
        
        for cell in cells {
            collectionView.register(cell.0, forCellWithReuseIdentifier: cell.1)
        }

        for header in headers {
            collectionView.register(header.0, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: header.1)
        }
        for footer in footers {
            collectionView.register(footer.0, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footer.1)
        }
        
        if delegate != nil {
            collectionView.delegate = delegate
        }
        if dataSource != nil {
            collectionView.dataSource = dataSource
        }

        return collectionView
    }
}

class LabelStyle {
    let font: UIFont?
    let text: String?
    let textColor: UIColor?
    let backgroundColor: UIColor?
    let textAlignment: NSTextAlignment?
    let numberOfLines: Int?
    let adjustsFontSizeToFitWidth: Bool?
    let borderColor: UIColor?
    let borderRadius: CGFloat?
    
    init(font: UIFont?, text: String? = nil, textColor: UIColor? = nil, backgroundColor: UIColor? = nil, textAlignment: NSTextAlignment? = nil, numberOfLines: Int? = nil, adjustsFontSizeToFitWidth: Bool? = nil, borderColor: UIColor? = nil, borderRadius: CGFloat? = nil) {
        self.font = font
        self.text = text
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
        self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        self.borderColor = borderColor
        self.borderRadius = borderRadius
    }
}

class ButtonStyle {
    let font: UIFont?
    let title: String?
    let image: UIImage?
    let disabledImage: UIImage?
    let selectedImage: UIImage?
    let titleColor: UIColor?
    let backgroundColor: UIColor?
    let borderColor: UIColor?
    let borderRadius: CGFloat?
    let selectedTitleColor: UIColor?
    
    init(font: UIFont? = nil, title: String? = nil, image: UIImage? = nil, disabledImage: UIImage? = nil, selectedImage: UIImage? = nil, titleColor: UIColor? = nil, selectedTitleColor: UIColor? = nil, backgroundColor: UIColor? = nil, borderColor: UIColor? = nil, borderRadius: CGFloat? = nil) {
        self.font = font
        self.title = title
        self.image = image
        self.selectedImage = selectedImage
        self.disabledImage = disabledImage
        self.titleColor = titleColor
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.borderRadius = borderRadius
        self.selectedTitleColor = selectedTitleColor
    }
}

class TextFieldStyle {
    let font: UIFont?
    let textColor: UIColor?
    let placeholder: String?
    let placeholderColor: UIColor?
    let backgroundColor: UIColor?
    let borderColor: UIColor?
    let borderRadius: CGFloat?
    let keyboardType: UIKeyboardType?
    let textAlignment: NSTextAlignment?
    let isSecureTextEntry: Bool?
    let autocorrectionType: UITextAutocorrectionType?
    let autocapitalizationType: UITextAutocapitalizationType?
    
    init(font: UIFont? = nil,
         textColor: UIColor? = nil,
         placeholder: String? = nil,
         placeholderColor: UIColor? = nil,
         backgroundColor: UIColor? = nil,
         borderColor: UIColor? = nil,
         borderRadius: CGFloat? = nil,
         keyboardType: UIKeyboardType? = nil,
         textAlignment: NSTextAlignment? = nil,
         isSecureTextEntry: Bool? = nil,
         autocorrectionType: UITextAutocorrectionType? = nil,
         autocapitalizationType: UITextAutocapitalizationType? = nil) {
        
        self.font = font
        self.textColor = textColor
        self.placeholder = placeholder
        self.placeholderColor = placeholderColor
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.borderRadius = borderRadius
        self.keyboardType = keyboardType
        self.textAlignment = textAlignment
        self.isSecureTextEntry = isSecureTextEntry
        self.autocorrectionType = autocorrectionType
        self.autocapitalizationType = autocapitalizationType
    }
}
