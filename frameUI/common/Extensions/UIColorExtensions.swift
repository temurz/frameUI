//
//  UIColorExtensions.swift
//  Tedr
//
//  Created by GK on 11/03/25.
//

import Foundation
import UIKit
extension UIColor {
    convenience init(rgb: UInt32) {
        self.init(red: CGFloat((rgb >> 16) & 0xff) / 255.0, green: CGFloat((rgb >> 8) & 0xff) / 255.0, blue: CGFloat(rgb & 0xff) / 255.0, alpha: 1.0)
    }
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
    }
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    convenience init(hex: String) {
        let r, g, b, a: CGFloat
        
        var hexFormatted = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hexFormatted.hasPrefix("#") {
            hexFormatted.removeFirst()
        }
        
        // Ensure the string has 8 characters (RRGGBBAA)
        if hexFormatted.count == 8,
           let hexNumber = UInt32(hexFormatted, radix: 16) {
            
            r = CGFloat((hexNumber >> 24) & 0xFF) / 255.0
            g = CGFloat((hexNumber >> 16) & 0xFF) / 255.0
            b = CGFloat((hexNumber >> 8) & 0xFF) / 255.0
            a = CGFloat(hexNumber & 0xFF) / 255.0
            
            self.init(red: r, green: g, blue: b, alpha: a)
        } else {
            let h = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
            var int = UInt32()
            Foundation.Scanner(string: h).scanHexInt32(&int)
            let a, r, g, b: UInt32
            switch h.count {
            case 3: // RGB (12-bit)
                (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case 6: // RGB (24-bit)
                (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case 8: // ARGB (32-bit)
                (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (a, r, g, b) = (1, 1, 1, 0)
            }
            self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
        }
    }
}
extension UIColor {
    func inverseColor() -> UIColor {
        var alpha: CGFloat = 1.0
        
        var red: CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: 1.0 - red, green: 1.0 - green, blue: 1.0 - blue, alpha: alpha)
        }
        
        var hue: CGFloat = 0.0, saturation: CGFloat = 0.0, brightness: CGFloat = 0.0
        if self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return UIColor(hue: 1.0 - hue, saturation: 1.0 - saturation, brightness: 1.0 - brightness, alpha: alpha)
        }
        
        var white: CGFloat = 0.0
        if self.getWhite(&white, alpha: &alpha) {
            return UIColor(white: 1.0 - white, alpha: alpha)
        }
        
        return self
    }
    
    func contrastColor() -> UIColor {
        var brightness: CGFloat = 0
        getHue(nil, saturation: nil, brightness: &brightness, alpha: nil)

        return brightness < 0.5 ? .white : .black
    }
}

extension UIColor {
    static func make(hex: String, alpha: Double) -> UIColor {
        let postfix = getAlphaHex(value: alpha)
        
        return UIColor(hex: hex + postfix)
    }
    
    private static func getAlphaHex(value: Double) -> String {
        switch value {
        case 1:
            return "FF"
        case 0.99:
            return "FC"
        case 0.98:
            return "FA"
        case 0.97:
            return "F7"
        case 0.96:
            return "F5"
        case 0.95:
            return "F2"
        case 0.94:
            return "F0"
        case 0.93:
            return "ED"
        case 0.92:
            return "EB"
        case 0.91:
            return "E8"
        case 0.90:
            return "E6"
        case 0.89:
            return "E3"
        case 0.88:
            return "E0"
        case 0.87:
            return "DE"
        case 0.86:
            return "DB"
        case 0.85:
            return "D9"
        case 0.84:
            return "D6"
        case 0.83:
            return "D4"
        case 0.82:
            return "D1"
        case 0.81:
            return "CF"
        case 0.80:
            return "CC"
        case 0.79:
            return "C9"
        case 0.78:
            return "C7"
        case 0.77:
            return "C4"
        case 0.76:
            return "C2"
        case 0.75:
            return "BF"
        case 0.74:
            return "BD"
        case 0.73:
            return "BA"
        case 0.72:
            return "B8"
        case 0.71:
            return "B5"
        case 0.70:
            return "B3"
        case 0.69:
            return "B0"
        case 0.68:
            return "AD"
        case 0.67:
            return "AB"
        case 0.66:
            return "A8"
        case 0.65:
            return "A6"
        case 0.64:
            return "A3"
        case 0.63:
            return "A1"
        case 0.62:
            return "9E"
        case 0.61:
            return "9C"
        case 0.60:
            return "99"
        case 0.59:
            return "96"
        case 0.58:
            return "94"
        case 0.57:
            return "91"
        case 0.56:
            return "8F"
        case 0.55:
            return "8C"
        case 0.54:
            return "8A"
        case 0.53:
            return "87"
        case 0.52:
            return "85"
        case 0.51:
            return "82"
        case 0.50:
            return "80"
        case 0.49:
            return "7D"
        case 0.48:
            return "7A"
        case 0.47:
            return "78"
        case 0.46:
            return "75"
        case 0.45:
            return "73"
        case 0.44:
            return "70"
        case 0.43:
            return "6E"
        case 0.42:
            return "6B"
        case 0.41:
            return "69"
        case 0.40:
            return "66"
        case 0.39:
            return "63"
        case 0.38:
            return "61"
        case 0.37:
            return "5E"
        case 0.36:
            return "5C"
        case 0.35:
            return "59"
        case 0.34:
            return "57"
        case 0.33:
            return "54"
        case 0.32:
            return "52"
        case 0.31:
            return "4F"
        case 0.30:
            return "4D"
        case 0.29:
            return "4A"
        case 0.28:
            return "47"
        case 0.27:
            return "45"
        case 0.26:
            return "42"
        case 0.25:
            return "40"
        case 0.24:
            return "3D"
        case 0.23:
            return "3B"
        case 0.22:
            return "38"
        case 0.21:
            return "36"
        case 0.20:
            return "33"
        case 0.19:
            return "30"
        case 0.18:
            return "2E"
        case 0.17:
            return "2B"
        case 0.16:
            return "29"
        case 0.15:
            return "26"
        case 0.14:
            return "24"
        case 0.13:
            return "21"
        case 0.12:
            return "1F"
        case 0.11:
            return "1C"
        case 0.1:
            return "1A"
        case 0.09:
            return "17"
        case 0.08:
            return "14"
        case 0.07:
            return "12"
        case 0.06:
            return "0F"
        case 0.05:
            return "0D"
        case 0.04:
            return "0A"
        case 0.03:
            return "08"
        case 0.02:
            return "05"
        case 0.01:
            return "03"
        case 0:
            return "00"
        default:
            return ""
        }
    }
}
