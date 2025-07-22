//
//  StringExtensions.swift
//  Tedr
//
//  Created by GK on 11/03/25.
//
import CoreImage
import Foundation
import UIKit
public extension NSAttributedString {
    convenience init(string: String, font: UIFont? = nil, textColor: UIColor = UIColor.black, paragraphAlignment: NSTextAlignment? = nil) {
        var attributes: [NSAttributedString.Key: AnyObject] = [:]
        if let font = font {
            attributes[NSAttributedString.Key.font] = font
        }
        attributes[NSAttributedString.Key.foregroundColor] = textColor
        if let paragraphAlignment = paragraphAlignment {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = paragraphAlignment
            attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        }
        self.init(string: string, attributes: attributes)
    }
}
extension String {
    func size(_ font: UIFont?) -> CGSize {
        let str: NSString = self as NSString
        return str.size(withAttributes: [NSAttributedString.Key.font: font as Any])
    }
    func width(_ font: UIFont?) -> CGFloat {
        return size(font).width
    }
    func height(_ font: UIFont?) -> CGFloat {
        return size(font).width
    }
}

extension String {
    func QRCodeImage(scale: CGFloat? = nil) -> UIImage? {
        let data = self.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
}
