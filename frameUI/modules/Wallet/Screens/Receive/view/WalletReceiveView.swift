//
//  WalletReceiveView.swift
//  Tedr
//
//  Created by Kostya Lee on 24/05/25.
//

import Foundation
import UIKit
class WalletReceiveView: TemplateView {

    private var cancelButton: UIButton?
    private var titleLabel: UILabel?
    private var subtitleLabel: UILabel?
    private var addressLabel: UILabel?
    private var qrImageView: UIImageView?
    
    private var assetBackgroundView: UIView?
    private var assetImageView: UIImageView?
    private var assetNameLabel: UILabel?
    private var assetTickerLabel: UITickerLabel?
    private var arrowImageView: UIImageView?
    private var assetTouchView: UIButton?
    
    private var copyButton: UIButton?
    private var payMeButton: UIButton?
    private var shareButton: UIButton?
    
    var cancel: (() -> Void)?

    override func initialize() {
        let theme = Theme()
        
        backgroundColor = theme.backgroundTertiaryColor

        cancelButton = UIButton()
        cancelButton?.setTitle(Strings.cancel, for: .normal)
        cancelButton?.setTitleColor(theme.contentSecondary, for: .normal)
        cancelButton?.titleLabel?.font = theme.getFont(size: 16, weight: .regular)
        cancelButton?.tag = 0
        cancelButton?.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        self.addSubview(cancelButton)

        titleLabel = UILabel()
        titleLabel?.text = Strings.receive
        titleLabel?.font = theme.getFont(size: 18, weight: .bold)
        titleLabel?.textColor = theme.darkTextColor
        titleLabel?.textAlignment = .center
        self.addSubview(titleLabel)

        subtitleLabel = UILabel()
        subtitleLabel?.text = Strings.yourWallet
        subtitleLabel?.font = theme.getFont(size: 16, weight: .regular)
        subtitleLabel?.textColor = theme.darkTextColor
        subtitleLabel?.textAlignment = .center
        self.addSubview(subtitleLabel)

        addressLabel = UILabel()
        addressLabel?.text = "Txzy66OLL...s33sZYXmm"
        addressLabel?.font = theme.getFont(size: 15, weight: .regular)
        addressLabel?.textColor = theme.contentSecondary
        addressLabel?.textAlignment = .center
        addressLabel?.numberOfLines = 1
        self.addSubview(addressLabel)

        qrImageView = UIImageView()
        qrImageView?.image = UIImage(named: "exampleQRImage")
        qrImageView?.contentMode = .scaleAspectFit
        qrImageView?.layer.cornerRadius = 20
        qrImageView?.clipsToBounds = true
        self.addSubview(qrImageView)
        
        assetBackgroundView = UIView()
        assetBackgroundView?.backgroundColor = theme.whiteColor.withAlphaComponent(0.1)
        self.addSubview(assetBackgroundView)
        
        assetImageView = UIImageView()
        assetImageView?.clipsToBounds = true
        self.addSubview(assetImageView)
        
        assetNameLabel = UILabel()
        assetNameLabel?.font = theme.getFont(size: 17, weight: .medium)
        assetNameLabel?.textColor = theme.darkTextColor
        self.addSubview(assetNameLabel)
        
        assetTickerLabel = UITickerLabel()
        self.addSubview(assetTickerLabel)
        
        arrowImageView = UIImageView()
        arrowImageView?.image = theme.arrowRightIcon
        self.addSubview(arrowImageView)
        
        assetTouchView?.tag = 1
        assetTouchView?.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        self.addSubview(assetTouchView)
        
        copyButton = createActionButton(title: Strings.copy, icon: theme.copyIcon)
        copyButton?.tag = 2
        copyButton?.titleLabel?.adjustsFontSizeToFitWidth = true
        copyButton?.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        payMeButton = createActionButton(title: Strings.payMe, icon: theme.paymeIcon)
        payMeButton?.tag = 3
        payMeButton?.titleLabel?.adjustsFontSizeToFitWidth = true
        payMeButton?.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        shareButton = createActionButton(title: Strings.share, icon: theme.shareIcon)
        shareButton?.tag = 4
        shareButton?.titleLabel?.adjustsFontSizeToFitWidth = true
        shareButton?.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)

        self.addSubview(copyButton)
        self.addSubview(payMeButton)
        self.addSubview(shareButton)
    }

    private func createActionButton(title: String, icon: UIImage?) -> UIButton {
        let button = UIButton()
        let theme = Theme()
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(theme.darkTextColor, for: .normal)
        button.titleLabel?.font = theme.getFont(size: 14, weight: .regular)
        button.setImage(icon, for: .normal)
        button.tintColor = theme.darkTextColor
        button.backgroundColor = theme.whiteColor.withAlphaComponent(0.1)
        button.layer.cornerRadius = 16
        button.titleLabel?.textAlignment = .center
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        
        let spacing: CGFloat = 6

        /// Center imageView and Label   &   place imageView on top of Label
        DispatchQueue.main.async {
            guard let imageSize = button.imageView?.frame.size,
                  let titleSize = button.titleLabel?.frame.size else { return }
            let totalHeight = imageSize.height + spacing + titleSize.height

            button.imageEdgeInsets = UIEdgeInsets(
                top: -(totalHeight - imageSize.height),
                left: (titleSize.width / 2),
                bottom: 0,
                right: -(titleSize.width / 2)
            )

            button.titleEdgeInsets = UIEdgeInsets(
                top: 0,
                left: -(imageSize.width / 2),
                bottom: -(totalHeight - titleSize.height),
                right: (imageSize.width / 2)
            )

            button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        }

        return button
    }

    override func updateSubviewsFrame(_ size: CGSize) {
        let padding: CGFloat = 16
        let totalWidth = size.width

        var x: CGFloat = 0
        var y: CGFloat = 0
        var w: CGFloat = 0
        var h: CGFloat = 0

        titleLabel?.sizeToFit()
        w = titleLabel!.frame.width
        h = titleLabel!.frame.height
        x = (totalWidth - w) / 2
        y = padding*2 + 5
        self.titleLabel?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        w = cancelButton?.titleLabel?.getWidth() ?? 0
        h = cancelButton?.titleLabel?.height ?? 0
        x = padding
        y = (titleLabel?.midY ?? 0) - h/2
        self.cancelButton?.frame = CGRect(x: x, y: y, width: w, height: h)

        y += h + 24
        subtitleLabel?.sizeToFit()
        w = subtitleLabel!.frame.width
        h = subtitleLabel!.frame.height
        x = (totalWidth - w) / 2
        self.subtitleLabel?.frame = CGRect(x: x, y: y, width: w, height: h)

        y += h + 6
        addressLabel?.sizeToFit()
        w = addressLabel!.frame.width
        h = addressLabel!.frame.height
        x = (totalWidth - w) / 2
        self.addressLabel?.frame = CGRect(x: x, y: y, width: w, height: h)

        y += h + padding*2
        w = 200
        h = 200
        x = (totalWidth - w) / 2
        self.qrImageView?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        let assetNameWidth = assetNameLabel?.getWidth() ?? 0
        let assetTickerWidth = assetTickerLabel?.getSize().width ?? 0
        let assetPadding: CGFloat = 12
        
        w = max(assetTickerWidth, assetNameWidth) + assetPadding*4 + 55 + 25
        h = 80
        x = (totalWidth - w) / 2
        y = (qrImageView?.maxY ?? 0) + padding*2
        self.assetBackgroundView?.frame = CGRect(x: x, y: y, width: w, height: h)
        assetBackgroundView?.layer.cornerRadius = 18
        
        x = assetBackgroundView!.minX + assetPadding
        h = 56
        w = h
        y = assetBackgroundView!.minY + assetPadding
        self.assetImageView?.frame = CGRect(x: x, y: y, width: w, height: h)
        assetImageView?.layer.cornerRadius = 16
        
        h = 20
        w = assetNameWidth
        x = assetImageView!.maxX + assetPadding
        y = assetImageView!.minY + 4
        self.assetNameLabel?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        w = assetTickerLabel?.getSize().width ?? 0
        h = assetTickerLabel?.getSize().height ?? 0
        x = assetNameLabel?.minX ?? 0
        y = assetNameLabel!.maxY + 8
        self.assetTickerLabel?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        w = 25
        h = w
        x = assetBackgroundView!.maxX - w - assetPadding
        y = assetBackgroundView!.midY - h/2
        self.arrowImageView?.frame = CGRect(x: x, y: y, width: w, height: h)


        let buttonWidth: CGFloat = (totalWidth - padding * 4) / 4
        let buttonHeight: CGFloat = buttonWidth*0.9
        
        y = size.height - padding*2 - buttonHeight - 60
        x = size.width/2 - buttonWidth/2
        self.payMeButton?.frame = CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight)
        
        x = payMeButton!.minX - buttonWidth - padding
        self.copyButton?.frame = CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight)

        x = payMeButton!.maxX + padding
        self.shareButton?.frame = CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight)
    }
    
    /// One selector for all buttons
    @objc private func buttonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            self.cancel?()
            break
        case 1:
            // Selected asset / Return to currency selection
            break
        case 2:
            // Copy
            break
        case 3:
            // Payme
            break
        case 4:
            // Share
            break
        default:
            break
        }
    }
    
    func configure(with qrImage: UIImage, asset: WalletAssetRow) {
        self.qrImageView?.image = qrImage
        
        assetImageView?.image = UIImage(named: "\(asset.icon)_logo")
        
        assetNameLabel?.text = asset.icon
        assetTickerLabel?.configure(text: asset.network)
    }
}
