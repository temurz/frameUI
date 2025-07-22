//
//  UIFontExtensions.swift
//  Tedr
//
//  Created by GK on 11/03/25.
//

import Foundation
import UIKit
extension UIFont {
    static func latoFont(ofSize fontSize: CGFloat, weight: UIFont.Weight, italic: Bool = false) -> UIFont {
        switch weight {
        case .regular:
            return .init(name: italic ? Lato.italic.rawValue : Lato.regular.rawValue, size: fontSize) ?? (italic ? .italicSystemFont(ofSize: fontSize) : .systemFont(ofSize: fontSize))
        case .medium:
            return .init(name: italic ? Lato.mediumItalic.rawValue : Lato.medium.rawValue, size: fontSize) ?? (italic ? .italicSystemFont(ofSize: fontSize) : .systemFont(ofSize: fontSize, weight: .medium))
        case .semibold:
            return .init(name: italic ? Lato.semiBoldItalic.rawValue : Lato.semiBold.rawValue, size: fontSize) ?? (italic ? .italicSystemFont(ofSize: fontSize) : .systemFont(ofSize: fontSize, weight: .semibold))
        case .bold:
            return .init(name: italic ? Lato.boldItalic.rawValue : Lato.bold.rawValue, size: fontSize) ?? (italic ? .italicSystemFont(ofSize: fontSize) : .systemFont(ofSize: fontSize, weight: .bold))
        case .black:
            return .init(name: italic ? Lato.blackItalic.rawValue : Lato.black.rawValue, size: fontSize) ?? (italic ? .italicSystemFont(ofSize: fontSize) : .systemFont(ofSize: fontSize, weight: .black))
        case .light, .ultraLight:
            return .init(name: italic ? Lato.lightItalic.rawValue : Lato.light.rawValue, size: fontSize) ?? (italic ? .italicSystemFont(ofSize: fontSize) : .systemFont(ofSize: fontSize, weight: .light))
        case .heavy:
            return .init(name: italic ? Lato.heavyItalic.rawValue : Lato.heavy.rawValue, size: fontSize) ?? (italic ? .italicSystemFont(ofSize: fontSize) : .systemFont(ofSize: fontSize, weight: .heavy))
        case .thin:
            return .init(name: italic ? Lato.thinItalic.rawValue : Lato.thin.rawValue, size: fontSize) ?? (italic ? .italicSystemFont(ofSize: fontSize) : .systemFont(ofSize: fontSize, weight: .thin))
        default:
            return .init(name: italic ? Lato.italic.rawValue : Lato.regular.rawValue, size: fontSize) ?? (italic ? .italicSystemFont(ofSize: fontSize) : .systemFont(ofSize: fontSize))
        }
    }
    
    static func onest(_ weight: OnestWeight = .regular, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: weight.rawValue, size: size) else {
            return .systemFont(ofSize: size)
        }
        return font
    }
}

public enum OnestWeight: String {
    case black = "Onest-Black"
    case bold = "Onest-Bold"
    case extraBold = "Onest-ExtraBold"
    case extraLight = "Onest-ExtraLight"
    case light = "Onest-Light"
    case medium = "Onest-Medium"
    case regular = "Onest-Regular"
    case semiBold = "Onest-SemiBold"
    case thin = "Onest-Thin"
}
public enum Lato: String, CaseIterable {
    case boldItalic = "Lato-BoldItalic"
    case bold = "Lato-Bold"
    case italic = "Lato-Italic"
    case lightItalic = "Lato-LightItalic"
    case light = "Lato-Light"
    case mediumItalic = "Lato-MediumItalic"
    case medium = "Lato-Medium"
    case regular = "Lato-Regular"
    case semiBoldItalic = "Lato-SemiboldItalic"
    case semiBold = "Lato-Semibold"
    case thin = "Lato-Thin"
    case thinItalic = "Lato-ThinItalic"
    case hairline = "Lato-Hairline"
    case hairlineItalic = "Lato-HairlineItalic"
    case black = "Lato-Black"
    case blackItalic = "Lato-BlackItalic"
    case heavy = "Lato-Heavy"
    case heavyItalic = "Lato-HeavyItalic"
}

func proportionalFontSizeFromFigma(designFontSize: CGFloat, isMinSize: Bool = true) -> CGFloat {
    let designWidth: CGFloat = 375
    let screenWidth = UIScreen.main.bounds.width
    let proportionalFontSize = (designFontSize / designWidth) * screenWidth
    
    return isMinSize ? max(designFontSize, proportionalFontSize) : proportionalFontSize
}

// Global function to calculate proportional height or width based on design size and current screen size
func proportionalViewSizeFromFigma(designSize: CGFloat, isHeight: Bool = true, isMinSize: Bool = true) -> CGFloat {
    let designWidth: CGFloat = 375    // Figma screen width (design base)
    let designHeight: CGFloat = 812   // Figma screen height (design base)
    
    // Get the current screen size
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    // Calculate the proportional size
    if isHeight {
        // If calculating for height
        let calculatedSize = (designSize / designHeight) * screenHeight
        return isMinSize ? max(designSize, calculatedSize) : calculatedSize
    } else {
        // If calculating for width
        let calculatedSize = (designSize / designWidth) * screenWidth
        return isMinSize ? max(designSize, calculatedSize) : calculatedSize
    }
}
