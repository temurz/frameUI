//
//  TransactionDetailsView.swift
//  Tedr
//
//  Created by Temur on 30/05/2025.
//  
//

import UIKit

class TransactionDetailsView: TemplateView {
    private let toLabel = UILabel()
    private let avatarImageView = UIImageView()
    private let nameLabel = UILabel()
    private let addressLabel = UILabel()
    private let addressContentLabel = UILabel()

    private let memoContainerView = UIView()
    private let memoLabel = UILabel()
    private let memoContentLabel = UILabel()

    private let amountContainerView = UIView()
    private let networkLabel = UILabel()
    private let networkLogoImageView = UIImageView()
    private let networkNameLabel = UILabel()

    private let feeLabel = UILabel()
    private let feeAmountLabel = UILabel()

    private let amountToBeSentLabel = UILabel()
    private let amountToBeSentContentLabel = UILabel()

    private let totalLabel = UILabel()
    private let totalAmountLabel = UILabel()
    
    private var totalHeight = CGFloat.zero

    private let sendButton = GradientSelectableButton(
        title: Strings.send,
        style: .gradient(
            [Theme().pinkGradientUpColor.cgColor, Theme().pinkGradientDownColor.cgColor],
            startPoint: CGPoint(x: 1, y: 0),
            endPoint: CGPoint(x: 0, y: 1)
        )
    )
    
    var sendAction: (() -> Void)?

    override func initialize() {
        let theme = theme ?? Theme()
        backgroundColor = .clear

        toLabel.text = Strings.to
        toLabel.font = theme.getFont(size: 16, weight: .regular)
        toLabel.textColor = theme.whiteColor
        toLabel.textAlignment = .center
        addSubview(toLabel)

        avatarImageView.borderRadius = 32
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.image = UIImage(named: "sample_avatar") // temporary
        addSubview(avatarImageView)

        nameLabel.font = theme.getFont(size: 24, weight: .semibold)
        nameLabel.textColor = theme.whiteColor
        nameLabel.textAlignment = .center
        addSubview(nameLabel)

        addressLabel.text = Strings.address
        addressLabel.font = theme.getFont(size: 16, weight: .regular)
        addressLabel.textColor = theme.contentSecondary
        addressLabel.textAlignment = .center
        addSubview(addressLabel)

        addressContentLabel.font = theme.getFont(size: 16, weight: .medium)
        addressContentLabel.textColor = theme.whiteColor
        addressContentLabel.textAlignment = .center
        addressContentLabel.numberOfLines = 0
        addSubview(addressContentLabel)

        // Memo Box
        memoContainerView.backgroundColor = theme.bgBlackTransparent20
        memoContainerView.borderRadius = 16
        addSubview(memoContainerView)

        memoLabel.text = Strings.memo
        memoLabel.font = theme.getFont(size: 16, weight: .regular)
        memoLabel.textColor = theme.contentSecondary
        memoContainerView.addSubview(memoLabel)

        memoContentLabel.font = theme.getFont(size: 16, weight: .regular)
        memoContentLabel.textColor = theme.whiteColor
        memoContainerView.addSubview(memoContentLabel)

        // Amount Container
        amountContainerView.backgroundColor = theme.bgBlackTransparent20
        amountContainerView.borderRadius = 20
        addSubview(amountContainerView)

        networkLabel.text = Strings.network
        networkLabel.font = theme.getFont(size: 16, weight: .regular)
        networkLabel.textColor = theme.contentSecondary
        amountContainerView.addSubview(networkLabel)

        networkLogoImageView.contentMode = .scaleAspectFit
        amountContainerView.addSubview(networkLogoImageView)

        networkNameLabel.font = theme.getFont(size: 12, weight: .medium)
        networkNameLabel.textColor = theme.whiteColor
        amountContainerView.addSubview(networkNameLabel)

        feeLabel.text = Strings.fee
        feeLabel.font = theme.getFont(size: 16, weight: .regular)
        feeLabel.textColor = theme.contentSecondary
        amountContainerView.addSubview(feeLabel)

        feeAmountLabel.font = theme.getFont(size: 16, weight: .regular)
        feeAmountLabel.textColor = theme.contentPrimary
        feeAmountLabel.textAlignment = .right
        amountContainerView.addSubview(feeAmountLabel)

        amountToBeSentLabel.text = Strings.TransactionDetails.amountToBeSent
        amountToBeSentLabel.font = theme.getFont(size: 16, weight: .regular)
        amountToBeSentLabel.textColor = theme.contentSecondary
        amountContainerView.addSubview(amountToBeSentLabel)

        amountToBeSentContentLabel.font = theme.getFont(size: 16, weight: .regular)
        amountToBeSentContentLabel.textColor = theme.contentPrimary
        amountToBeSentContentLabel.textAlignment = .right
        amountContainerView.addSubview(amountToBeSentContentLabel)

        totalLabel.text = Strings.total
        totalLabel.font = theme.getFont(size: 16, weight: .bold)
        totalLabel.textColor = theme.contentPrimary
        amountContainerView.addSubview(totalLabel)

        totalAmountLabel.font = theme.getFont(size: 16, weight: .bold)
        totalAmountLabel.textColor = theme.contentPrimary
        totalAmountLabel.textAlignment = .right
        amountContainerView.addSubview(totalAmountLabel)

        sendButton.addTapGesture(tapNumber: 1) { [weak self] _ in
            self?.sendAction?()
        }
        addSubview(sendButton)
    }

    override func updateSubviewsFrame(_ size: CGSize) {
        let padding: CGFloat = 16
        let width = size.width
        var y: CGFloat = padding
        var w = toLabel.getWidth()
        var x = padding
        var h = toLabel.textHeight(w)
        toLabel.frame = CGRect(x: 0, y: y, width: width, height: h)
        
        y = toLabel.maxY + 8
        w = 64
        h = w
        x = width/2 - w/2
        avatarImageView.frame = CGRect(x: x, y: y, width: w, height: h)
        
        y = avatarImageView.maxY + 8
        w = width
        h = nameLabel.textHeight(w)
        x = 0
        nameLabel.frame = CGRect(x: x, y: y, width: w, height: h)
        
        y = nameLabel.maxY + padding
        h = addressLabel.textHeight(w)
        addressLabel.frame = CGRect(x: x, y: y, width: w, height: h)
        
        y = addressLabel.maxY + 8
        h = addressContentLabel.textHeight(w)
        addressContentLabel.frame = CGRect(x: x, y: y, width: w, height: h)
        
        y = addressContentLabel.maxY + padding
        x = padding
        memoContainerView.frame = CGRect(x: x, y: y, width: width - 2 * padding, height: 80)
        
        y = 10
        w = memoContainerView.width - padding*2
        h = memoLabel.textHeight(w)
        memoLabel.frame = CGRect(x: x, y: 10, width: w, height: h)
        
        y = memoLabel.maxY + 8
        h = memoContentLabel.textHeight(w)
        memoContentLabel.frame = CGRect(x: x, y: y, width: w, height: h)
        
        y = memoContainerView.maxY + 16
        w = width - 2 * padding
        h = 160
        amountContainerView.frame = CGRect(x: padding, y: y, width: w, height: h)
        
        y = 10
        w = networkLabel.getWidth()
        h = networkLabel.textHeight(w)
        networkLabel.frame = CGRect(x: x, y: y, width: w, height: h)
        networkLogoImageView.frame = CGRect(x: amountContainerView.frame.width - 70, y: 10, width: 20, height: 20)
        w = networkNameLabel.getWidth()
        networkNameLabel.frame = CGRect(x: amountContainerView.width - padding - w, y: 10, width: w, height: 20)

        feeLabel.frame = CGRect(x: 16, y: 44, width: 200, height: 20)
        feeAmountLabel.frame = CGRect(x: amountContainerView.frame.width - 120, y: 44, width: 104, height: 20)

        amountToBeSentLabel.frame = CGRect(x: 16, y: 72, width: 200, height: 20)
        amountToBeSentContentLabel.frame = CGRect(x: amountContainerView.frame.width - 160, y: 72, width: 144, height: 20)

        totalLabel.frame = CGRect(x: 16, y: 120, width: 100, height: 24)
        totalAmountLabel.frame = CGRect(x: amountContainerView.frame.width - 160, y: 120, width: 144, height: 24)

        y = amountContainerView.maxY + padding * 2
        sendButton.frame = CGRect(x: padding, y: y, width: width - 2 * padding, height: 56)
    }
    
    func configure(details: TransactionDetails) {
        nameLabel.text = details.recipient.name
        addressContentLabel.text = details.address
        memoContentLabel.text = details.memo
        networkNameLabel.text = details.network
        feeAmountLabel.text = details.fee
        amountToBeSentContentLabel.text = details.amountToBeSent
        totalAmountLabel.text = details.total
        
        if let url = URL(string: details.recipient.imageURL) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.avatarImageView.image = image
                    }
                }
            }.resume()
        }
    }
}

extension TransactionDetailsView: BottomSheetContentView {
    func preferredContentHeight() -> CGFloat {
        let size = bounds.size
        updateSubviewsFrame(size)
        return sendButton.maxY
    }
}
