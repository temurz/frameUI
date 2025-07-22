//
//  DarkTheme.swift
//  Tedr
//
//  Created by GK on 11/03/25.
//

import Foundation
import UIKit
public class DarkTheme: ThemeProtocol {
    func getFont(size: CGFloat, weight: UIFont.Weight, italic: Bool = false) -> UIFont {
        return UIFont.latoFont(ofSize: proportionalFontSizeFromFigma(designFontSize: size), weight: weight, italic: italic)
    }
    
    func onestFont(size: CGFloat, weight: OnestWeight) -> UIFont {
        return UIFont.onest(weight, size: size)
    }
}
