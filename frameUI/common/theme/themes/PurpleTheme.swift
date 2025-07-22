//
//  PurpleTheme.swift
//  Tedr
//
//  Created by Temur on 27/05/2025.
//

import Foundation
import UIKit
public class PurpleTheme: ThemeProtocol {
    func getFont(size: CGFloat, weight: UIFont.Weight, italic: Bool = false) -> UIFont {
        return UIFont.latoFont(ofSize: proportionalFontSizeFromFigma(designFontSize: size), weight: weight, italic: italic)
    }
    
    func onestFont(size: CGFloat, weight: OnestWeight) -> UIFont {
        return UIFont.onest(weight, size: size)
    }
}
