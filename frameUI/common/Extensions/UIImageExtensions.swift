//
//  UIImageExtensions.swift
//  Tedr
//
//  Created by Kostya Lee on 09/05/25.
//

import Foundation
import UIKit


extension UIImage {
    /// Creates a 1x1 pixel image filled with the given color.
    ///
    /// - Parameter color: The color to fill the image with.
    /// - Returns: A `UIImage` filled with the specified color.
    static func fromColor(_ color: UIColor) -> UIImage {
        let rect = CGRect(origin: .zero, size: CGSize(width: 1, height: 1))
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
}
