//
//  UIViewExtensions.swift
//  Tedr
//
//  Created by GK on 11/03/25.
//

import Foundation
import UIKit
extension UIView {
    func removeAllGestures() {
        for g in gestureRecognizers ?? [] {
            removeGestureRecognizer(g)
        }
    }
}
extension UIView {
    func addSubview(_ view: UIView?) {
        if let view {
            self.addSubview(view)
        }
    }
    
    func insertSubview(_ view: UIView?, belowSubview: UIView?) {
        if view != nil && belowSubview != nil {
            self.insertSubview(view!, belowSubview: belowSubview!)
        }
    }
}
extension UIStackView {
    func addArrangedSubview(_ view: UIView?) {
        if let view {
            self.addArrangedSubview(view)
        }
    }
}

public class ClosureTap: UITapGestureRecognizer {
    fileprivate var tapAction: ((UITapGestureRecognizer) -> Void)?
    
    public override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
    }
    
    public convenience init(
        tapCount: Int,
        fingerCount: Int,
        action: ((UITapGestureRecognizer) -> Void)?) {
            self.init()
            self.numberOfTapsRequired = tapCount
            self.numberOfTouchesRequired = fingerCount
            self.tapAction = action
            self.addTarget(self, action: #selector(ClosureTap.didTap(_:)))
    }
    
    @objc public func didTap(_ tap: UITapGestureRecognizer) {
        tapAction?(tap)
    }
}

extension UIView {
    func addTapGesture(tapNumber: Int, target: AnyObject, action: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = tapNumber
        if self.gestureRecognizers?.contains(where: {$0 == tap}) ?? false {
            return
        }
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
    
    func addTapGesture(tapNumber: Int, action: ((UITapGestureRecognizer) -> ())?) {
        let tap = ClosureTap(tapCount: tapNumber, fingerCount: 1, action: action)
        if self.gestureRecognizers?.contains(where: {$0 == tap}) ?? false {
            return
        }
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
    
    func shake() {
        self.transform = CGAffineTransform(translationX: 20, y: 0)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    func addLongPressGesture(target: AnyObject, action: Selector) {
        let longPress = UILongPressGestureRecognizer(target: target, action: action)
        if self.gestureRecognizers?.contains(where: {$0 == longPress}) ?? false {
            return
        }
        
        addGestureRecognizer(longPress)
        isUserInteractionEnabled = true
    }
    
    func addLongPressGesture(minimumDuration: TimeInterval? = nil, action: ((UILongPressGestureRecognizer) -> ())?) {
        let longPress = ClosureLongPress(action: action)
        if minimumDuration != nil {
            longPress.minimumPressDuration = minimumDuration!
        }
        if self.gestureRecognizers?.contains(where: {$0 == longPress}) ?? false {
            return
        }
        
        addGestureRecognizer(longPress)
        isUserInteractionEnabled = true
    }
}

extension UIView {
    var borderRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.clipsToBounds = true
            self.layer.cornerRadius = newValue
        }
    }
    
    var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.borderWidth = 1
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
}

extension UIView {
    func removeGradient() {
        if let oldLayer = layer.sublayers?.firstIndex(where: {$0.name == "Gradient"}) {
            layer.sublayers?.remove(at: oldLayer)
        }
        backgroundColor = .clear
    }
    func addGradient(colors: [CGColor], startPoint: CGPoint? = nil, endPoint: CGPoint? = nil) {
        if colors.count == 1 {
            if let oldLayer = layer.sublayers?.firstIndex(where: {$0.name == "Gradient"}) {
                layer.sublayers?.remove(at: oldLayer)
            }
            
            backgroundColor = UIColor(cgColor: colors.first!)
            return
        }
        if colors.count >= 3 {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = colors
            gradientLayer.startPoint = startPoint ?? CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = endPoint ?? CGPoint(x: 0.0, y: 1.0)
            gradientLayer.locations = [NSNumber(floatLiteral: 0.0), NSNumber(floatLiteral: 0.5), NSNumber(floatLiteral: 1.0)]
            gradientLayer.frame = self.bounds
            
            if let oldLayer = layer.sublayers?.firstIndex(where: {$0.name == "Gradient"}) {
                layer.sublayers?.remove(at: oldLayer)
            }
            gradientLayer.name = "Gradient"
            
            self.layer.insertSublayer(gradientLayer, at: 0)
            return
        }
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = startPoint ?? CGPoint(x: 1, y: 0)
        gradientLayer.endPoint = endPoint ?? CGPoint(x: 0, y: 1)
        gradientLayer.locations = [NSNumber(floatLiteral: 0.0), NSNumber(floatLiteral: 1.0)]
        gradientLayer.frame = self.bounds
        
        if let oldLayer = layer.sublayers?.firstIndex(where: {$0.name == "Gradient"}) {
            layer.sublayers?.remove(at: oldLayer)
        }
        gradientLayer.name = "Gradient"
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addShadow(shadowColor: UIColor, radius: CGFloat? = 2, width: CGFloat? = 0, height: CGFloat? = 3) {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = radius!
        self.layer.shadowOpacity = 0.8
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: width!, height: height!)
    }
    
    func addGradient(topColor: UIColor, bottomColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.locations = [NSNumber(floatLiteral: 0.0), NSNumber(floatLiteral: 1.0)]
        gradientLayer.frame = self.bounds
        
        if let oldLayer = layer.sublayers?.firstIndex(where: {$0.name == "Gradient"}) {
            layer.sublayers?.remove(at: oldLayer)
        }
        gradientLayer.name = "Gradient"
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
extension CGRect {
    init(x: CGFloat?, y: CGFloat?, width: CGFloat?, height: CGFloat?) {
        self.init(x: x ?? 0, y: y ?? 0, width: width ?? 0, height: height ?? 0)
    }
}
extension UIView {
    
    var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set(newX) {
            var newFrame = self.frame
            newFrame.origin.x = newX
            self.frame = newFrame
        }
    }
    
    var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set(newY) {
            var newFrame = self.frame
            newFrame.origin.y = newY
            self.frame = newFrame
        }
    }
    
    var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set(newWidth) {
            var newFrame = self.frame
            newFrame.size.width = newWidth
            self.frame = newFrame
        }
    }
    
    var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set(newHeight) {
            var newFrame = self.frame
            newFrame.size.height = newHeight
            self.frame = newFrame
        }
    }
    var minX: CGFloat {
        get {
            return self.frame.minX
        }
    }
    var midX: CGFloat {
        get {
            return self.frame.midX
        }
    }
    var maxX: CGFloat {
        get {
            return self.frame.maxX
        }
    }
    
    var minY: CGFloat {
        get {
            return self.frame.minY
        }
    }
    var midY: CGFloat {
        get {
            return self.frame.midY
        }
    }
    var maxY: CGFloat {
        get {
            return self.frame.maxY
        }
    }
    
    var size: CGSize {
        get {
            return self.frame.size
        } set {
            self.frame.size = newValue
        }
    }
    
    var origin: CGPoint {
        get {
            return self.frame.origin
        } set {
            self.frame.origin = newValue
        }
    }
    
    var left: CGFloat {
        get {
            return self.x
        } set(value) {
            self.x = value
        }
    }
    
    
    var right: CGFloat {
        get {
            return self.x + self.width
        } set(value) {
            self.x = value - self.width
        }
    }
    
    
    var top: CGFloat {
        get {
            return self.y
        } set(value) {
            self.y = value
        }
    }
    
    
    var bottom: CGFloat {
        get {
            return self.y + self.height
        } set(value) {
            self.y = value - self.height
        }
    }
    
    
    var centerX: CGFloat {
        get {
            return self.center.x
        } set(value) {
            self.center.x = value
        }
    }
    
    var centerY: CGFloat {
        get {
            return self.center.y
        } set(value) {
            self.center.y = value
        }
    }
}

extension UIView {
    /// Adding border around self frame
    func addBorder(_ borderColor: UIColor, width: CGFloat) {
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = width
    }
    /// Adding border with argument frame
    func addBorder(_ borderColor: UIColor, rect: CGRect) {
        if let last = layer.sublayers?.firstIndex(where: {$0.name == "borderLayer"}) {
            layer.sublayers?.remove(at: last)
        }
        
        let border = CALayer()
        border.name = "borderLayer"
        border.backgroundColor = borderColor.cgColor
        border.frame = rect
        self.layer.addSublayer(border)
    }
    
    func removeBorder() {
        for border in self.layer.sublayers ?? [CALayer]() {
            if border.name == "borderLayer" {
                border.removeFromSuperlayer()
            }
        }
    }
    
    func addTopBorder(_ borderColor: UIColor, borderWidth: CGFloat) {
        addBorder(borderColor, rect: CGRect(x: 0, y: 0, width: self.width, height: borderWidth))
    }
    
    func addBottomBorder(_ borderColor: UIColor, borderWidth: CGFloat) {
        addBorder(borderColor, rect: CGRect(x: 0, y: self.height - borderWidth, width: self.width, height: borderWidth))
    }
    
    func addLeftBorder(_ borderColor: UIColor, borderWidth: CGFloat) {
        addBorder(borderColor, rect: CGRect(x: 0, y: 0, width: borderWidth, height: self.height))
    }
    
    func addRightBorder(_ borderColor: UIColor, borderWidth: CGFloat) {
        addBorder(borderColor, rect: CGRect(x: self.height - borderWidth, y: 0, width: borderWidth, height: self.height))
    }
}

extension UIView {

    class func getAllSubviews<T: UIView>(from parenView: UIView) -> [T] {
        return parenView.subviews.flatMap { subView -> [T] in
            var result = getAllSubviews(from: subView) as [T]
            if let view = subView as? T { result.append(view) }
            return result
        }
    }

    class func getAllSubviews(from parenView: UIView, types: [UIView.Type]) -> [UIView] {
        return parenView.subviews.flatMap { subView -> [UIView] in
            var result = getAllSubviews(from: subView) as [UIView]
            for type in types {
                if subView.classForCoder == type {
                    result.append(subView)
                    return result
                }
            }
            return result
        }
    }

    func getAllSubviews<T: UIView>() -> [T] { return UIView.getAllSubviews(from: self) as [T] }
    func get<T: UIView>(all type: T.Type) -> [T] { return UIView.getAllSubviews(from: self) as [T] }
    func get(all types: [UIView.Type]) -> [UIView] { return UIView.getAllSubviews(from: self, types: types) }
    
    
    func takeScreenshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return img
    }
    
    func blurredScreenshot(_ blurValue: CGFloat? = 15.0) -> UIImage? {
        guard let img = takeScreenshot() else { return nil }
        let context = CIContext(options: nil)
        let inputImage = CIImage(image: img)
        let originalOrientation = img.imageOrientation
        let originalScale = img.scale
        
        let filter = CIFilter(name: "CIGaussianBlur")
        filter?.setValue(inputImage, forKey: kCIInputImageKey)
        filter?.setValue(blurValue!, forKey: kCIInputRadiusKey)
        
        let outputImage = filter?.outputImage
        
        var cgImage: CGImage?
        
        if let outputImage = outputImage {
            cgImage = context.createCGImage(outputImage, from: (inputImage?.extent)!)
        }
        
        if let cgImageA = cgImage {
            return UIImage(cgImage: cgImageA, scale: originalScale, orientation: originalOrientation)
        }
        
        return nil
    }
    
    func applyBlur(style: UIBlurEffect.Style = .systemMaterialDark, overlayAlpha: CGFloat = 0.2) {
        let blur = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurView)
        
        let overlay = UIView(frame: bounds)
        overlay.backgroundColor = UIColor.black.withAlphaComponent(overlayAlpha)
        overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.contentView.addSubview(overlay)
    }
}

import UIKit
import SystemConfiguration
import AVFoundation
open class ClosureLongPress: UILongPressGestureRecognizer {
    private var pressed = false
    fileprivate var longPressAction: ((UILongPressGestureRecognizer) -> Void)?
    
    public override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
    }
    
    public convenience init (action: ((UILongPressGestureRecognizer) -> Void)?) {
        self.init()
        longPressAction = action
        addTarget(self, action: #selector(ClosureLongPress.didLongPressed(_:)))
    }
    
    @objc open func didLongPressed(_ longPress: UILongPressGestureRecognizer) {
        if pressed {
            return
        }
        
        switch longPress.state {
        case .began, .changed:
            pressed = true
        default:
            pressed = false
        }
        
        longPressAction?(longPress)
        
        let time = DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time, execute: { [weak self] in
            self?.pressed = false
        })
    }
}
extension UIButton {
    func alignVertical(_ spacing: CGFloat = 6.0) {
        guard let imageSize = self.imageView?.image?.size,
            let text = self.titleLabel?.text,
            let font = self.titleLabel?.font
            else { return }
        self.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageSize.width, bottom: -(imageSize.height + spacing), right: 0.0)
        let labelString = NSString(string: text)
        let titleSize = labelString.size(withAttributes: [kCTFontAttributeName as NSAttributedString.Key: font])
        self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0.0, bottom: 0.0, right: -titleSize.width)
        let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0;
        self.contentEdgeInsets = UIEdgeInsets(top: edgeOffset, left: 0.0, bottom: edgeOffset, right: 0.0)
    }
    
    func centerTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        let writingDirection = UIApplication.shared.userInterfaceLayoutDirection
        let factor: CGFloat = writingDirection == .leftToRight ? 1 : -1

        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount*factor, bottom: 0, right: insetAmount*factor)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount*factor, bottom: 0, right: -insetAmount*factor)
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }
}
extension URL {
    func getThumbnailImage() -> UIImage {
        let asset: AVAsset = AVAsset(url: self)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true
        
        guard let thumbnailImage = try? imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60), actualTime: nil) else { return UIImage() }
        
        return UIImage(cgImage: thumbnailImage).fixOrientation()
    }
}
extension UITextView {
    func getTextHeight(_ fixedWidth: CGFloat) -> CGFloat {
        let newSize = self.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        
        return newSize.height
    }
}
extension UINavigationController {
    func popViewControllerWithDismissAnimation() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromBottom
        self.view.layer.add(transition, forKey: kCATransition)
        self.popViewController(animated: false)
    }
    
    func pushViewControllerWithPresentAnimation(_ controller: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromTop
        self.view.layer.add(transition, forKey: kCATransition)
        self.pushViewController(controller, animated: false)
    }
}


import Foundation
import UIKit
import Photos
extension UIImage {
    func changeColor (_ color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()
        context!.translateBy(x: 0, y: self.size.height)
        context!.scaleBy(x: 1.0, y: -1.0)
        context!.setBlendMode(CGBlendMode.normal)
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context!.clip(to: rect, mask: self.cgImage!)
        color.setFill()
        context!.fill(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

extension UIImageView {
    func setImage(from link: String?) {
        if link?.isEmpty ?? true {
            return
        }
        if let url = URL(string: link!) {
            let image = imageCache.object(forKey: link! as NSString)
            self.image = image
            
            if image == nil {
                ImageLoader().downloadImage(url: url) { [weak self] (img) in
                    self?.image = img
                }
            }
        }
    }
}

extension UIButton {
    func setImage(from link: String?) {
        if link?.isEmpty ?? true {
            return
        }
        if let url = URL(string: link!) {
            let image = imageCache.object(forKey: link! as NSString)
            self.setImage(image, for: .normal)
            
            if image == nil {
                ImageLoader().downloadImage(url: url) { [weak self] (img) in
                    self?.setImage(image, for: .normal)
                }
            }
        }
    }
    
    func loadImage(from link: String?, imageLoaded: @escaping (UIImage?) -> Void) {
        if link?.isEmpty ?? true {
            return
        }
        if let url = URL(string: link!) {
            let image = imageCache.object(forKey: link! as NSString)
            if image != nil {
                imageLoaded(image)
                return
            }
            
            if image == nil {
                ImageLoader().downloadImage(url: url) { (img) in
                    imageLoaded(img)
                }
            }
        }
    }
}

/// Used in TemplateTextField
extension UIButton {
    /// Возвращает ширину контента кнопки:
    /// - 20 если в кнопке изображение (`imageView`).
    /// - Ширину текста (`titleLabel`) если она есть.
    func contentWidth() -> CGFloat {
        if let _ = self.image(for: .normal) {
            return 20
        }

        if let title = self.title(for: .normal), !title.isEmpty {
            return self.titleLabel?.getWidth() ?? 0
        }

        return 0
    }
}

extension UIImage {
    func detectQRCode() -> [CIFeature]? {
        if let ciImage = CIImage.init(image: self) {
            var options: [String: Any]
            let context = CIContext()
            options = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
            let qrDetector = CIDetector(ofType: CIDetectorTypeQRCode, context: context, options: options)
            if ciImage.properties.keys.contains((kCGImagePropertyOrientation as String)) {
                options = [CIDetectorImageOrientation: ciImage.properties[(kCGImagePropertyOrientation as String)] ?? 1]
            } else {
                options = [CIDetectorImageOrientation: 1]
            }
            let features = qrDetector?.features(in: ciImage, options: options)
            return features
        }
        
        return nil
    }
    
    func readValueFromQR() -> String? {
        if let features = detectQRCode(),
           !features.isEmpty,
           case let row as CIQRCodeFeature = features.first,
           let scannedString = row.messageString {
            return scannedString
        }
        
        return nil
    }
}

extension PHAsset {
    var fileName: String? {
        return PHAssetResource.assetResources(for: self).first?.originalFilename
    }
    
    func fetchImage(contentMode: PHImageContentMode, targetSize: CGSize? = nil, fetchedImage: ((UIImage?) -> Void)? = nil) {
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isSynchronous = false
        if targetSize == nil {
            options.resizeMode = .exact
        }
        
        PHImageManager.default().requestImage(for: self, targetSize: targetSize ?? PHImageManagerMaximumSize, contentMode: contentMode, options: options) { image, _ in
            guard let image = image else {
                fetchedImage?(nil)
                return
            }
            DispatchQueue.main.async {
                fetchedImage?(image)
            }
        }
    }
}
extension UIImageView {
    func fetchImage(asset: PHAsset, contentMode: PHImageContentMode, targetSize: CGSize, fetchedImage: ((UIImage) -> Void)? = nil) {
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isSynchronous = false
        PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: contentMode, options: options) { image, _ in
            guard let image = image else { return }
            switch contentMode {
            case .aspectFill:
                self.contentMode = .scaleAspectFill
            case .aspectFit:
                self.contentMode = .scaleAspectFit
            }
            DispatchQueue.main.async { [weak self] in
                self?.image = image
                fetchedImage?(image)
            }
        }
    }
    
    func fetchLimitedImage(asset: PHAsset, contentMode: PHImageContentMode, targetSize: CGSize, fetchedImage: ((UIImage?) -> Void)? = nil) {
        let filteredImagesQueue = DispatchQueue(label: "filter.images.queue")
        let dispatchGroup = DispatchGroup()
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isSynchronous = false
        var assetsWithGrantedAccess: UIImage?
        dispatchGroup.enter()
        PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: contentMode, options: options) { image, _ in
            defer { dispatchGroup.leave() }
            guard let image = image else {
                 return
            }
            filteredImagesQueue.async {
                 assetsWithGrantedAccess = image
            }
        }
   
        dispatchGroup.notify(queue: filteredImagesQueue) {
            DispatchQueue.main.async { [weak self] in
                self?.image = assetsWithGrantedAccess
                fetchedImage?(assetsWithGrantedAccess)
            }
        }
    }
}
extension UIImage {
    func fixOrientation() -> UIImage {
        guard imageOrientation != .up else { return self }
        
        var transform: CGAffineTransform = .identity
        
        switch imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width ,y: size.height).rotated(by: .pi)
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0).rotated(by: .pi)
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height).rotated(by: -.pi/2)
        case .upMirrored:
            transform = transform.translatedBy(x: size.width, y: 0).scaledBy(x: -1, y: 1)
        default: break
        }
        
        guard let cgImage = cgImage, let colorSpace = cgImage.colorSpace,
            let context: CGContext = CGContext(data: nil,
                                               width: Int(size.width),
                                               height: Int(size.height),
                                               bitsPerComponent: cgImage.bitsPerComponent,
                                               bytesPerRow: 0,
                                               space: colorSpace,
                                               bitmapInfo: cgImage.bitmapInfo.rawValue)
            else { return self }
        context.concatenate(transform)
        var rect: CGRect
        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            rect = CGRect(x: 0, y: 0, width: size.height, height: size.width)
        default:
            rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        }
        context.draw(cgImage, in: rect)
        guard let image = context.makeImage() else { return self }
        return UIImage(cgImage: image)
    }
}
