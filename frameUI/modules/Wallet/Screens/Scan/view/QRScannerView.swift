//
//  QRScannerView.swift
//  Tedr
//
//  Created by Temur on 29/05/2025.
//  
//

import UIKit

final class QRScannerView: TemplateView {

    private let titleLabel = UILabel()
    private let closeButton = UIButton()
    private let overlayLayer = CAShapeLayer()
    private let cornerLayer = CAShapeLayer()
    private let scanLine = UIView()
    private var scanRect: CGRect = .zero
    private let galleryButton = TransparentButton()
    
    var closeAction: (() -> Void)?

    //MARK: - Lifecycle
    override func initialize() {
        let theme = theme ?? Theme()
        backgroundColor = .clear

        overlayLayer.fillRule = .evenOdd
        overlayLayer.fillColor = UIColor.black.withAlphaComponent(0.5).cgColor
        layer.addSublayer(overlayLayer)

        cornerLayer.strokeColor = UIColor.white.cgColor
        cornerLayer.lineWidth = 4
        cornerLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(cornerLayer)

        scanLine.backgroundColor = .white
        addSubview(scanLine)
        
        titleLabel.text = Strings.Scan.Qr.title
        titleLabel.font = theme.getFont(size: 18, weight: .bold)
        titleLabel.textColor = theme.whiteColor
        addSubview(titleLabel)
        
        closeButton.setImage(theme.crossIcon, for: .normal)
        closeButton.addTapGesture(tapNumber: 1) { [weak self] _ in
            self?.closeAction?()
        }
        addSubview(closeButton)
        
        galleryButton.configure(title: Strings.gallery, icon: theme.pictureIcon) {
            
        }
        addSubview(galleryButton)
    }

    override func updateSubviewsFrame(_ size: CGSize) {
        let side = min(size.width - 80, size.height / 2.5)
        scanRect = CGRect(x: (size.width - side) / 2, y: (size.height - side) / 2, width: side, height: side)

        let path = UIBezierPath(rect: bounds)
        path.append(UIBezierPath(rect: scanRect).reversing())
        overlayLayer.path = path.cgPath

        let corners = UIBezierPath()
        let l: CGFloat = 48, r = scanRect

        corners.move(to: CGPoint(x: r.minX, y: r.minY + l))
        corners.addLine(to: CGPoint(x: r.minX, y: r.minY))
        corners.addLine(to: CGPoint(x: r.minX + l, y: r.minY))

        corners.move(to: CGPoint(x: r.maxX - l, y: r.minY))
        corners.addLine(to: CGPoint(x: r.maxX, y: r.minY))
        corners.addLine(to: CGPoint(x: r.maxX, y: r.minY + l))

        corners.move(to: CGPoint(x: r.minX, y: r.maxY - l))
        corners.addLine(to: CGPoint(x: r.minX, y: r.maxY))
        corners.addLine(to: CGPoint(x: r.minX + l, y: r.maxY))

        corners.move(to: CGPoint(x: r.maxX - l, y: r.maxY))
        corners.addLine(to: CGPoint(x: r.maxX, y: r.maxY))
        corners.addLine(to: CGPoint(x: r.maxX, y: r.maxY - l))

        cornerLayer.path = corners.cgPath

        scanLine.frame = CGRect(x: scanRect.minX, y: scanRect.minY, width: scanRect.width, height: 2)
        scanLine.layer.removeAllAnimations()
        UIView.animate(withDuration: 2.0, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.scanLine.frame.origin.y = self.scanRect.maxY - 2
        }, completion: nil)
        
        let padding = CGFloat(16)
        var w = titleLabel.getWidth()
        var h = titleLabel.textHeight(w)
        var x = size.width/2 - w/2
        var y = safeAreaInsets.top + padding
        titleLabel.frame = .init(x: x, y: y, width: w, height: h)
        
        w = 24
        h = 24
        x = padding
        closeButton.frame = .init(x: x, y: y, width: w, height: h)
        
        y = scanRect.maxY + padding
        w = 80
        h = 72
        x = size.width/2 - w/2
        galleryButton.frame = .init(x: x, y: y, width: w, height: h)
    }
}
