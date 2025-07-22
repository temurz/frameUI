//
//  Extensions.swift
//  Tedr
//
//  Created by GK on 11/03/25.
//

import UIKit
import Foundation
extension UIApplication {
    
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
    
}

extension UIView {
    func findSuperviewConformingToProtocol<T>(protocolType: T.Type) -> UIView? {
        var currentSuperview = self.superview
        while let superview = currentSuperview {
            if superview is T {
                return superview
            }
            currentSuperview = superview.superview
        }
        return nil
    }
}

extension UILabel {
    
    /**
     Add kerning to a UILabel's existing `attributedText`
     - note: If `UILabel.attributedText` has not been set, the `UILabel.text`
     value will be returned from `attributedText` by default
     - note: This method must be called each time `UILabel.text` or
     `UILabel.attributedText` has been set
     - parameter kernValue: The value of the kerning to add
     */
    func addKern(_ kernValue: CGFloat) {
        guard let attributedText = attributedText,
              attributedText.string.count > 0,
              let fullRange = attributedText.string.range(of: attributedText.string) else {
            return
        }
        let updatedText = NSMutableAttributedString(attributedString: attributedText)
        updatedText.addAttributes([
            .kern: kernValue
        ], range: NSRange(fullRange, in: attributedText.string))
        self.attributedText = updatedText
    }
}

extension Range {
    // usage example: get an Int within the given Range:
    //let nr = (-1000..<1100).randomInt
    var randomInt: Int {
        get {
            var offset = 0
            if let startIndex = lowerBound as? Int, let endIndex = upperBound as? Int {
                if (startIndex as Int) < 0 { // allow negative ranges
                    offset = abs(startIndex as Int)
                }
                
                let mini = UInt32(startIndex as Int + offset)
                let maxi = UInt32(endIndex   as Int + offset)
                
                return Int(mini + arc4random_uniform(maxi - mini)) - offset
            }
            return -1
        }
    }
}
extension UILabel {
    
    func setLineHeight(lineHeight: CGFloat, labelWidth: CGFloat, alignment: NSTextAlignment? = NSTextAlignment.left) -> CGFloat {
        let text = self.text
        if let text = text {
            let attributeString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            style.alignment = alignment!
            style.lineSpacing = lineHeight
            attributeString.addAttribute(kCTParagraphStyleAttributeName as NSAttributedString.Key, value: style, range: NSMakeRange(0, text.count))
            self.attributedText = attributeString
            return self.sizeThatFits(CGSize(width: labelWidth, height: 20)).height
        }
        return 0
    }
}

extension UIImage {
    public func aspectHeightForWidth(_ width: CGFloat) -> CGFloat {
        return (width * self.size.height) / self.size.width
    }
    
    ///
    public func aspectWidthForHeight(_ height: CGFloat) -> CGFloat {
        return (height * self.size.width) / self.size.height
    }
    
    func withInsets(_ insets: UIEdgeInsets) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: size.width + insets.left + insets.right,
                   height: size.height + insets.top + insets.bottom),
            false,
            self.scale)
        
        let origin = CGPoint(x: insets.left, y: insets.top)
        self.draw(at: origin)
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return imageWithInsets
    }
}

extension String {
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
    
    var toDouble: Double {
        if let num = NumberFormatter().number(from: self) {
            return num.doubleValue
        } else {
            return 0
        }
    }
}

extension UITextView {
    open override var frame: CGRect {
        didSet {
            if let lbl = self.viewWithTag(234) as? UILabel {
                lbl.frame = CGRect(x: 5, y: 5, width: self.width - 10, height: min(30, self.height))
            }
        }
    }
    fileprivate func placeholderLbl() -> UILabel {
        if let lbl = self.viewWithTag(234) as? UILabel {
            return lbl
        } else {
            let plLbl = UILabel()
            plLbl.tag = 234
            plLbl.font = UIFont.systemFont(ofSize: 14)
            plLbl.backgroundColor = UIColor.clear
            plLbl.textColor = UIColor.lightGray
            self.addSubview(plLbl)
            return plLbl
        }
    }
    
    var attributedPlaceholder: NSAttributedString? {
        get {
            return self.placeholderLbl().attributedText
        }
        set {
            self.placeholderLbl().attributedText = newValue
        }
    }
}
extension String {
    
    func separate(every: Int, with separator: String) -> String {
        return String(stride(from: 0, to: Array(self).count, by: every).map {
            Array(Array(self)[$0..<min($0 + every, Array(self).count)])
        }.joined(separator: separator))
    }
}
extension String {
    func removeSpaces() -> String {
        return self.replacingOccurrences(of: "^\\s|\\s+|\\s$", with: "", options: .regularExpression)
    }
}
extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension BinaryInteger {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}



// The MIT License (MIT)
//
// Copyright (c) 2015-2016 litt1e-p ( https://github.com/litt1e-p )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
import UIKit
import Foundation

enum WindowRootVcTransitionStyle: UInt
{
    case None,
         ZoomOut,
         ZoomIn,
         Dissolve,
         SliceVertical,
         SliceHorizontal,
         FlipFromLeft,
         FlipFromRight,
         FlipFromTop,
         FlipFromBottom,
         CurlUp,
         CurlDown,
         Random
}

extension UIWindow
{
    func transitRootVc(rootVc: UIViewController, style: WindowRootVcTransitionStyle?, duration: TimeInterval?) {
        var finalStyle: WindowRootVcTransitionStyle = style != nil ? style! : .Random
        if finalStyle == .Random {
            var randomInt: UInt = 0
            arc4random_buf(&randomInt, 11)
            finalStyle = WindowRootVcTransitionStyle(rawValue: UInt(randomInt % 11))!
        }
        transitAnimation(toVc: rootVc, style: finalStyle, duration: duration)
    }
    
    func transitRootVc(identifier: String, style: WindowRootVcTransitionStyle?, duration: TimeInterval?) {
        var finalStyle: WindowRootVcTransitionStyle = style != nil ? style! : .Random
        if finalStyle == .Random {
            var randomInt: UInt = 0
            arc4random_buf(&randomInt, 11)
            finalStyle = WindowRootVcTransitionStyle(rawValue: UInt(randomInt % 11))!
        }
        if let rootVc = rootViewController?.storyboard?.instantiateViewController(withIdentifier: identifier) {
            transitAnimation(toVc: rootVc, style: finalStyle, duration: duration)
        } else {
            fatalError("Instantiate viewController failed")
        }
    }
    
    private func transitAnimation(toVc: UIViewController, style: WindowRootVcTransitionStyle, duration: TimeInterval?) {
        let durationMin: TimeInterval = duration != nil ? duration! : 0.25
        let durationMax: TimeInterval = duration != nil ? duration! : 0.50
        switch style {
        case .ZoomOut:
            let snapshot:UIView = snapshotView(afterScreenUpdates: true)!
            toVc.view.addSubview(snapshot)
            rootViewController = toVc
            UIView.animate(withDuration: durationMin, animations: {() in
                snapshot.layer.opacity = 0.00
                snapshot.layer.transform = CATransform3DMakeScale(1.50, 1.50, 1.50)
            }, completion: {
                (value: Bool) in
                snapshot.removeFromSuperview()
            })
        case .ZoomIn:
            let snapshot:UIView = snapshotView(afterScreenUpdates: true)!
            toVc.view.addSubview(snapshot)
            rootViewController = toVc
            UIView.animate(withDuration: durationMax, animations: {() in
                snapshot.layer.opacity = 0.00
                snapshot.layer.transform = CATransform3DMakeScale(0.01, 0.01, 1.00)
            }, completion: {
                (value: Bool) in
                snapshot.removeFromSuperview()
            })
        case .Dissolve:
            let snapshot:UIView = snapshotView(afterScreenUpdates: true)!
            toVc.view.addSubview(snapshot)
            rootViewController = toVc
            UIView.animate(withDuration: durationMin, animations: {
                snapshot.layer.opacity = 0.00
            }, completion: { (value: Bool) in
                snapshot.removeFromSuperview()
            })
        case .SliceVertical:
            let halfH        = toVc.view.frame.size.height * 0.50
            let aboveRect    = CGRect(x: 0.00, y: 0.00, width: toVc.view.frame.size.width, height: halfH)
            let belowRect    = CGRect(x: 0.00, y: halfH, width: toVc.view.frame.size.width, height: halfH)
            let aboveImgView = UIImageView(image: clipImage(view: self, rect: aboveRect))
            let belowImgView = UIImageView(image: clipImage(view: self, rect: belowRect))
            toVc.view.addSubview(aboveImgView)
            toVc.view.addSubview(belowImgView)
            rootViewController   = toVc
            toVc.view.layer.transform = CATransform3DMakeScale(0.98, 0.98, 1.00)
            UIView.animate(withDuration: durationMax, animations: {
                aboveImgView.layer.transform = CATransform3DMakeTranslation(0.00, -halfH, 0.00)
                belowImgView.layer.transform = CATransform3DMakeTranslation(0.00, halfH, 0.00)
                toVc.view.layer.transform    = CATransform3DIdentity
            }, completion: { (value: Bool) in
                aboveImgView.removeFromSuperview()
                belowImgView.removeFromSuperview()
            })
        case .SliceHorizontal:
            let halfW        = toVc.view.frame.size.width * 0.50
            let wholeH       = toVc.view.frame.size.height
            let leftRect     = CGRect(x: 0.00, y: 0.00, width: halfW, height: wholeH)
            let rightRect    = CGRect(x: halfW, y: 0.00, width: halfW, height: wholeH)
            let leftImgView  = UIImageView(image: clipImage(view: self, rect: leftRect))
            let rightImgView = UIImageView(image: clipImage(view: self, rect: rightRect))
            toVc.view.addSubview(leftImgView)
            toVc.view.addSubview(rightImgView)
            rootViewController   = toVc
            toVc.view.layer.transform = CATransform3DMakeScale(0.98, 0.98, 1.00)
            UIView.animate(withDuration: durationMax, animations: {
                leftImgView.layer.transform = CATransform3DMakeTranslation(-halfW, 0.00, 0.00)
                rightImgView.layer.transform = CATransform3DMakeTranslation(halfW * 2.00, 0.00, 0.00)
                toVc.view.layer.transform = CATransform3DIdentity
            }, completion: { (value: Bool) in
                leftImgView.removeFromSuperview()
                rightImgView.removeFromSuperview()
            })
        case .FlipFromLeft:
            UIView.transition(with: self, duration: durationMin, options: UIView.AnimationOptions.transitionFlipFromLeft, animations: {
                [weak self] in
                self!.rootViewController = toVc
            }, completion: nil)
        case .FlipFromRight:
            UIView.transition(with: self, duration: durationMin, options: UIView.AnimationOptions.transitionFlipFromRight, animations: {
                [weak self] in
                self!.rootViewController = toVc
            }, completion: nil)
        case .CurlUp:
            UIView.transition(with: self, duration: durationMin, options: UIView.AnimationOptions.transitionCurlUp, animations: {
                [weak self] in
                self!.rootViewController = toVc
            }, completion: nil)
        case .CurlDown:
            UIView.transition(with: self, duration: durationMin, options: UIView.AnimationOptions.transitionCurlDown, animations: {
                [weak self] in
                self!.rootViewController = toVc
            }, completion: nil)
        case .FlipFromTop:
            UIView.transition(with: self, duration: durationMin, options: UIView.AnimationOptions.transitionFlipFromTop, animations: {
                [weak self] in
                self!.rootViewController = toVc
            }, completion: nil)
        case .FlipFromBottom:
            UIView.transition(with: self, duration: durationMin, options: UIView.AnimationOptions.transitionFlipFromBottom, animations: {
                [weak self] in
                self!.rootViewController = toVc
            }, completion: nil)
        default:
            rootViewController = toVc
            break
        }
    }
    
    private func clipImage(view: UIView, rect: CGRect) -> UIImage {
        UIGraphicsBeginImageContext(view.frame.size)
        let context = UIGraphicsGetCurrentContext()
        context!.saveGState()
        UIRectClip(rect)
        view.layer.render(in: context!)
        let output = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return output!
    }
}

extension Collection {
    var pairs: [SubSequence] {
        var startIndex = self.startIndex
        let count = self.count
        let n = count/2 + (count % 2 == 0 ? 0 : 1)
        return (0..<n).map { _ in
            let endIndex = index(startIndex, offsetBy: 2, limitedBy: self.endIndex) ?? self.endIndex
            defer { startIndex = endIndex }
            return self[startIndex..<endIndex]
        }
    }
}
extension StringProtocol where Self: RangeReplaceableCollection {
    mutating func insert(separator: Self, every n: Int) {
        for index in indices.reversed() where index != startIndex &&
        distance(from: startIndex, to: index) % n == 0 {
            insert(contentsOf: separator, at: index)
        }
    }
    
    func inserting(separator: Self, every n: Int) -> Self {
        var string = self
        string.insert(separator: separator, every: n)
        return string
    }
}
extension TimeInterval{
    
    func stringFromTimeInterval() -> String {
        
        let time = NSInteger(self)
        
        let seconds = time % 60
        let minutes = (time / 60) % 60
        
        return String(format: "%0.2d:%0.2d",minutes,seconds)
        
    }
}

extension String {
    
    func matches(oneOf expressions: [String]) -> Bool {
        for expression in expressions {
            let r = regex(pattern: expression)
            
            if !r.isEmpty {
                return true
            }
        }
        
        return false
    }
    
    func regex(pattern: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue: 0))
            let nsstr = self as NSString
            let all = NSRange(location: 0, length: nsstr.length)
            var matches : [String] = [String]()
            regex.enumerateMatches(in: self, options: .anchored, range: all) { result, _, _ in
                if let r = result {
                    let result = nsstr.substring(with: r.range) as String
                    matches.append(result)
                }
            }
            
            return matches
        } catch {
            return []
        }
    }
}

func matches(regex: String, in text: String) -> [String] {
    do {
        let regex = try NSRegularExpression(pattern: regex)
        let results = regex.matches(in: text,
                                    range: NSRange(text.startIndex..., in: text))
        return results.map {
            String(text[Range($0.range, in: text)!])
        }
    } catch let error {
        debugPrint("invalid regex: \(error.localizedDescription)")
        return []
    }
}

extension UIResponder {
    public var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}

extension TimeInterval {
    var time: String {
        return String(format:"%02d:%02d", Int(self/60),  Int(ceil(truncatingRemainder(dividingBy: 60))) )
    }
}
extension Int {
    var degreesToRadians : CGFloat {
        return CGFloat(self) * .pi / 180
    }
}
extension Data {
    
    var bytes: Int64 {
        .init(self.count)
    }
    
    var kilobytes: Double {
        return Double(bytes) / 1_024
    }
    
    var megabytes: Double {
        return kilobytes / 1_024
    }
    
    var gigabytes: Double {
        return megabytes / 1_024
    }
    
    func getReadableUnit() -> String {
        
        switch bytes {
        case 0..<1_024:
            return "\(bytes) bytes"
        case 1_024..<(1_024 * 1_024):
            return "\(String(format: "%.2f", kilobytes)) kb"
        case 1_024..<(1_024 * 1_024 * 1_024):
            return "\(String(format: "%.2f", megabytes)) mb"
        case (1_024 * 1_024 * 1_024)...Int64.max:
            return "\(String(format: "%.2f", gigabytes)) gb"
        default:
            return "\(bytes) bytes"
        }
    }
}
extension UITextField {
    func setLeftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension UIViewController {
    public var isModal: Bool {
        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController
        
        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
}

extension UILabel {
    public func textHeight(_ width: CGFloat) -> CGFloat {
        return self.text?.heightWithConstrainedWidth(width: width, font: self.font) ?? 0
    }
    
    func getWidth() -> CGFloat {
        return (self.text ?? "").width(self.font ?? Theme().getFont(size: 16, weight: .regular))
    }
    
    func getWidth(passValueIfNil value: CGFloat) -> CGFloat {
        return self.text?.width(self.font ?? Theme().getFont(size: 16, weight: .regular)) ?? value
    }
}

extension String {
    /// Returns height of text with arg font and line height
    func heightWithWidth(width: CGFloat, font: UIFont, lineHeight: CGFloat? = nil) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        var attributes: [NSAttributedString.Key:Any] = [NSAttributedString.Key.font: font]
        if lineHeight != nil {
            let style = NSMutableParagraphStyle()
            style.lineSpacing = lineHeight!
            attributes[kCTParagraphStyleAttributeName as NSAttributedString.Key] = style
        }
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attributes, context: nil)
        return boundingBox.height
    }
    
    /// Returns height of text with arg font
    public func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height
    }
}

extension String {
    /// Formats a plain number without a suffix.
    ///
    /// - Parameter value: The value to format.
    /// - Returns: A string with up to two decimal digits and no trailing zeros.
    func formatted() -> String {
        guard let value = Double(self) else {
            return self
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.usesGroupingSeparator = false
        
        return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
    }
}


extension UIImage {
    func blurImage() -> UIImage? {
        let context = CIContext(options: nil)
        let inputImage = CIImage(image: self)
        let originalOrientation = self.imageOrientation
        let originalScale = self.scale
        
        let filter = CIFilter(name: "CIGaussianBlur")
        filter?.setValue(inputImage, forKey: kCIInputImageKey)
        filter?.setValue(10.0, forKey: kCIInputRadiusKey)
        let outputImage = filter?.outputImage
        
        var cgImage: CGImage?
        
        if let asd = outputImage
        {
            cgImage = context.createCGImage(asd, from: (inputImage?.extent)!)
        }
        
        if let cgImageA = cgImage
        {
            return UIImage(cgImage: cgImageA, scale: originalScale, orientation: originalOrientation)
        }
        
        return nil
    }
}

//regex
extension String {
    var toInt: Int {
        if let num = NumberFormatter().number(from: self) {
            return num.intValue
        } else {
            return 0
        }
    }
    
    func compareToIgnoreCase(_ str: String) -> ComparisonResult {
        return self.lowercased().compare(str.lowercased())
    }
    
    func containsIgnoreCase(_ str: String) -> Bool {
        return self.lowercased().contains(str.lowercased())
    }
    
    /// Return Bool value after checking for containing argument value
    func contains(_ find: String) -> Bool {
        return self.range(of: find) != nil
    }
    
    /// Return Bool value after checking for containing argument value by compare option
    func contains(_ find: String, compareOption: NSString.CompareOptions) -> Bool {
        return self.range(of: find, options: compareOption) != nil
    }
}
extension Double {
    public func toString() -> String {
        return "\(self)"
    }
    
    func roundTo(_ places: Int) -> String {
        return String(format: "%.\(places)f", self)
    }
    
}

extension Bool {
    init (val: Any) {
        switch val {
        case let num as NSNumber:
            self.init(num.boolValue)
        case let str as NSString:
            self.init(str.boolValue)
        default:
            self.init(0)
        }
    }
    init (_ val: Any?) {
        if let v = val {
            self.init(val: v)
        } else {
            self.init(0)
        }
    }
}


extension Array {
    init(array: [Element]?) {
        if let arr = array {
            self.init(arr)
        } else {
            self.init()
        }
    }
}

extension Array {
    
    /// Returns empty array of elements
    ///
    /// Example:   let array: [Element]!
    ///            array = Array.emptyArray()
    static func emptyArray() -> [Element] {
        return [Element]()
    }
    
    /// If argument array is not nil returns argument array OR returns empty array
    ///
    /// Example:   let argArray = [Element]()
    ///            let resultArray = Array.nvl(argArray)
    static func nvl(_ arr: [Element]?) -> [Element] {
        if let a = arr {
            return a
        } else {
            return [Element]()
        }
    }
    
    
    /// Returns element of array by random index
    ///
    /// Example:   let array = [Element]()
    ///            let randomElement: Element = Array.random()
    func random() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
    
    
    /// If array has argument element returns index of element OR returns nil
    ///
    /// Example:   let array = [String]()
    ///            let index: Int? = array.indexOfObject("stringValue")
    func indexOfObject<T: Equatable>(_ object: T) -> Int? {
        for index in 0..<self.count {
            if let arrayObject = self[index] as? T {
                if arrayObject == object {
                    return index
                }
            }
        }
        
        return nil
    }
    
    /// If array contains argument element this function removes this element in array
    ///
    /// Example:   let array = [Element]()
    ///           let element = scope.getElement()
    ///           array.removeObject(element)
    mutating func removeObject<U: Equatable>(_ object: U) {
        for i in (0..<count).reversed() {
            if let obj = self[i] as? U , obj == object {
                self.remove(at: i)
            }
        }
    }
    
    //    static func distinct(source: [Element]) -> [Element] {
    //        var unique = [Element]()
    //        for item in source {
    //            if !unique.contains(item) {
    //                unique.append(item)
    //            }
    //        }
    //        return unique
    //    }
}


extension Array {
    func asSet<E: Hashable>() -> Set<E> {
        var set = Set<E>()
        for item in self {
            if let item = item as? E {
                set.insert(item)
            }
        }
        return set
    }
    
    static func copyValue<T>(_ original: [T], newLength: Int) -> [T] {
        let end = [original.count,newLength].min()!
        let copyArr = original[0 ..< end]
        return [T](copyArr)
    }
}

extension UIView {
    public func removeAllSubviews() {
        for v in self.subviews {
            v.removeFromSuperview()
        }
    }
}

extension Dictionary {
    ///
    func random() -> NSObject {
        let index: Int = Int(arc4random_uniform(UInt32(self.count)))
        return Array(self.values)[index] as? NSObject ?? .init()
    }
    
    /// Combines the first dictionary with the second and returns single dictionary
    func union(_ other: Dictionary) -> Dictionary {
        var temp = self
        for (key,value) in other {
            temp.updateValue(value, forKey:key)
        }
        return temp
    }
    
    func containsKey(_ key: Key) -> Bool {
        return self.keys.contains(key)
    }
}

extension Float {
    init (val: Any) {
        switch val {
        case let num as NSNumber:
            self.init(num.floatValue)
        case let str as NSString:
            self.init(str.floatValue)
        default:
            self.init(0)
        }
    }
    init (_ val: Any?) {
        if let v = val {
            self.init(val: v)
        } else {
            self.init(-1)
        }
    }
}

extension Double {
    init (val: Any) {
        switch val {
        case let num as NSNumber:
            self.init(num.doubleValue)
        case let str as NSString:
            self.init(str.doubleValue)
        default:
            self.init(0)
        }
    }
    init (_ val: Any?) {
        if let v = val {
            self.init(val: v)
        } else {
            self.init(-1)
        }
    }
}

public extension Int {
    var toString: String { return String(self) }
}

extension Date {
    
    ///
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = DateFormatter.Style.medium
        formatter.dateStyle = DateFormatter.Style.medium
        return formatter.string(from: self)
    }
    
    ///
    func toString(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    //TODO: add in readme
    ///
    static func fromString(_ format: String, string: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: string)
    }
    
    ///
    func daysInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff/86400)
        return diff
    }
    
    ///
    func hoursInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff/3600)
        return diff
    }
    
    ///
    func minutesInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff/60)
        return diff
    }
    
    ///
    func secondsInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff)
        return diff
    }
    
    ///
    func timePassed() -> String {
        let date = Date()
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.year, .month, .day, .hour, .minute, .second], from: self, to: date, options: [])
        var str: String
        
        if components.year! >= 1 {
            components.year == 1 ? (str = "year") : (str = "years")
            return "\(String(describing: components.year)) \(str) ago"
        } else if components.month! >= 1 {
            components.month == 1 ? (str = "month") : (str = "months")
            return "\(String(describing: components.month)) \(str) ago"
        } else if components.day! >= 1 {
            components.day == 1 ? (str = "day") : (str = "days")
            return "\(String(describing: components.day)) \(str) ago"
        } else if components.hour! >= 1 {
            components.hour == 1 ? (str = "hour") : (str = "hours")
            return "\(String(describing: components.hour)) \(str) ago"
        } else if components.minute! >= 1 {
            components.minute == 1 ? (str = "minute") : (str = "minutes")
            return "\(String(describing: components.minute)) \(str) ago"
        } else if components.second == 0 {
            return "Just now"
        } else {
            return "\(String(describing: components.second)) seconds ago"
        }
    }
    
}

extension DateFormatter {
    convenience init(dateFormat: String, localeIdentifier: String) {
        self.init()
        self.dateFormat = dateFormat
        self.locale = Locale(identifier: localeIdentifier)
    }
    
    convenience init(dateFormat: String) {
        self.init(dateFormat: dateFormat, localeIdentifier: "US")
    }
}
extension NSCoder {
    class func empty() -> NSCoder {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.finishEncoding()
        return NSKeyedUnarchiver(forReadingWith: data as Data)
    }
}

extension String {
    func QRCodeImage() -> UIImage? {
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
extension String {
    func size(_ font: UIFont) -> CGSize {
        let str: NSString = self as NSString
        return str.size(withAttributes: [NSAttributedString.Key.font: font])
    }
    func width(_ font: UIFont) -> CGFloat {
        return size(font).width
    }
    func height(_ font: UIFont) -> CGFloat {
        return size(font).width
    }
}

extension UITextView {
    var placeholder: String? {
        get {
            return self.placeholderLbl().text
        }
        set {
            self.placeholderLbl().text = newValue
        }
    }
    
    var placeholderHidden: Bool {
        get {
            return self.placeholderLbl().isHidden
        }
        set {
            self.placeholderLbl().isHidden = newValue
        }
    }
}

extension String {
    func rightJustified(width: Int, pad: String = " ", truncate: Bool = false) -> String {
        guard width > count else {
            return truncate ? String(suffix(width)) : self
        }
        return String(repeating: pad, count: width - count) + self
    }
    
    func leftJustified(width: Int, pad: String = " ", truncate: Bool = false) -> String {
        guard width > count else {
            return truncate ? String(prefix(width)) : self
        }
        return self + String(repeating: pad, count: width - count)
    }
}

extension UIColor {
    var hexString: String {
        return String(self.rgb, radix: 16, uppercase: false).rightJustified(width: 6, pad: "0")
    }
    
    var rgb: UInt32 {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        if self.getRed(&red, green: &green, blue: &blue, alpha: nil) {
            return (UInt32(max(0.0, red) * 255.0) << 16) | (UInt32(max(0.0, green) * 255.0) << 8) | (UInt32(max(0.0, blue) * 255.0))
        } else if self.getWhite(&red, alpha: nil) {
            return (UInt32(max(0.0, red) * 255.0) << 16) | (UInt32(max(0.0, red) * 255.0) << 8) | (UInt32(max(0.0, red) * 255.0))
        } else {
            return 0
        }
    }
}

extension UIBezierPath {
    convenience init(shouldRoundRect rect: CGRect, topLeftRadius: CGSize = .zero, topRightRadius: CGSize = .zero, bottomLeftRadius: CGSize = .zero, bottomRightRadius: CGSize = .zero) {
        
        self.init()
        
        let path = CGMutablePath()
        
        let topLeft = rect.origin
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)
        
        if topLeftRadius != .zero{
            path.move(to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
        } else {
            path.move(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }
        
        if topRightRadius != .zero{
            path.addLine(to: CGPoint(x: topRight.x-topRightRadius.width, y: topRight.y))
            path.addCurve(to:  CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height), control1: CGPoint(x: topRight.x, y: topRight.y), control2:CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height))
        } else {
            path.addLine(to: CGPoint(x: topRight.x, y: topRight.y))
        }
        
        if bottomRightRadius != .zero{
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y-bottomRightRadius.height))
            path.addCurve(to: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y), control1: CGPoint(x: bottomRight.x, y: bottomRight.y), control2: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y))
        } else {
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y))
        }
        
        if bottomLeftRadius != .zero{
            path.addLine(to: CGPoint(x: bottomLeft.x+bottomLeftRadius.width, y: bottomLeft.y))
            path.addCurve(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height), control1: CGPoint(x: bottomLeft.x, y: bottomLeft.y), control2: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height))
        } else {
            path.addLine(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y))
        }
        
        if topLeftRadius != .zero{
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y+topLeftRadius.height))
            path.addCurve(to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y) , control1: CGPoint(x: topLeft.x, y: topLeft.y) , control2: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
        } else {
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }
        
        path.closeSubpath()
        cgPath = path
    }
}
extension UIView{
    public func roundCorners(topLeft: CGFloat = 0, topRight: CGFloat = 0, bottomLeft: CGFloat = 0, bottomRight: CGFloat = 0) {//(topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat) {
        let topLeftRadius = CGSize(width: topLeft, height: topLeft)
        let topRightRadius = CGSize(width: topRight, height: topRight)
        let bottomLeftRadius = CGSize(width: bottomLeft, height: bottomLeft)
        let bottomRightRadius = CGSize(width: bottomRight, height: bottomRight)
        let maskPath = UIBezierPath(shouldRoundRect: bounds, topLeftRadius: topLeftRadius, topRightRadius: topRightRadius, bottomLeftRadius: bottomLeftRadius, bottomRightRadius: bottomRightRadius)
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
}
