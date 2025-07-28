//
//  ChatNavigationView.swift
//  Tedr
//
//  Created by Kostya Lee on 14/06/25.
//

import Foundation
import UIKit
enum ChatNavigationState {
    case search
    case `default`
}

final class ChatNavigationView: TemplateView {

    private var gradientLayer: CAGradientLayer?
    private var backButton: UIButton?
    private var avatarImageView: UIImageView?
    private var nameLabel: UILabel?
    private var statusLabel: UILabel?
    private var profileTouchView: UIButton?
    private var callButton: UIButton?
    private var searchBar: TemplateSearchBar?
    private var cancelButton: UIButton?
    private var dotsButton: UIButton?
    
    private let imageLoader = ImageLoader()
    
    var backAction: (() -> Void)?
    var callAction: (() -> Void)?
    var profileAction: (() -> Void)?
    var stateHasChange: ((ChatNavigationState) -> Void)?
    var didSearchWithText: ((String) -> Void)?

    override func initialize() {
        setupGradient()
        setupSubviews()
    }

    private func setupGradient() {
        gradientLayer = CAGradientLayer()
        gradientLayer?.colors = [
            UIColor(red: 1.0, green: 0.4, blue: 0.7, alpha: 1).cgColor,
            UIColor(red: 0.9, green: 0.3, blue: 1.0, alpha: 1).cgColor
        ]
        gradientLayer?.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer?.endPoint = CGPoint(x: 1, y: 1)
        if let gradientLayer = gradientLayer {
            layer.insertSublayer(gradientLayer, at: 0)
        }
    }

    private func setupSubviews() {
        let theme = Theme()

        backButton = UIButton()
        backButton?.setImage(theme.arrowLeftLIcon, for: .normal)
        backButton?.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        self.addSubview(backButton)

        avatarImageView = UIImageView()
        avatarImageView?.layer.cornerRadius = 18
        avatarImageView?.clipsToBounds = true
        avatarImageView?.contentMode = .scaleAspectFill
        self.addSubview(avatarImageView)

        nameLabel = UILabel()
        nameLabel?.font = theme.getFont(size: 16, weight: .bold)
        nameLabel?.textColor = .white
        self.addSubview(nameLabel)

        statusLabel = UILabel()
        statusLabel?.font = theme.getFont(size: 13, weight: .regular)
        statusLabel?.textColor = .white
        self.addSubview(statusLabel)

        callButton = UIButton()
        callButton?.setImage(theme.telephoneIcon, for: .normal)
        callButton?.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        self.addSubview(callButton)
        
        profileTouchView = UIButton()
        profileTouchView?.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        self.addSubview(profileTouchView)
        
        if let url = URL(string: "https://randomuser.me/api/portraits/women/1.jpg") {
            configure(name: "Jane Smith", status: "Online", avatarURL: url)
        }
        
        dotsButton = UIButton()
        dotsButton?.setImage(theme.dotsVerticalIcon, for: .normal)
        dotsButton?.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        self.addSubview(dotsButton)
        
        cancelButton = UIButton()
        cancelButton?.setTitle(Strings.cancel, for: .normal)
        cancelButton?.setTitleColor(theme.contentWhite, for: .normal)
        cancelButton?.titleLabel?.font = theme.onestFont(size: 16, weight: .regular)
        cancelButton?.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        cancelButton?.alpha = 0
        addSubview(cancelButton)
        
        searchBar = TemplateSearchBar()
        searchBar?.alpha = 0
        searchBar?.placeholder = Strings.search
        searchBar?.textDidChange = { [weak self] text in
            guard let self else { return }
            didSearchWithText?(text)
        }
        addSubview(searchBar)
    }
    
    override func updateSubviewsFrame(_ size: CGSize) {
        let safeTop = safeAreaInsets.top
        let topInset: CGFloat = safeTop
        let sideInset: CGFloat = 16
        let avatarSize: CGFloat = 36
        let buttonSize: CGFloat = 24
        
        self.gradientLayer?.frame = bounds
        
        var x: CGFloat = sideInset
        var y: CGFloat = topInset + 6
        var w: CGFloat = buttonSize
        var h: CGFloat = buttonSize
        self.backButton?.frame = CGRect(x: x, y: y, width: w, height: h)

        x = backButton!.frame.maxX + 12
        h = avatarSize
        y = size.height - h - 8
        w = avatarSize
        self.avatarImageView?.frame = CGRect(x: x, y: y, width: w, height: h)

        x = avatarImageView!.frame.maxX + 12
        y = avatarImageView!.minY
        w = 200
        h = 18
        self.nameLabel?.frame = CGRect(x: x, y: y, width: w, height: h)

        y = nameLabel!.frame.maxY
        w = statusLabel!.getWidth()
        h = 16
        self.statusLabel?.frame = CGRect(x: x, y: y, width: w, height: h)

        x = bounds.width - sideInset - buttonSize
        y = topInset + 6
        w = buttonSize
        h = buttonSize
        self.dotsButton?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        x = (dotsButton?.minX ?? size.width) - w - sideInset
        self.callButton?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        x = avatarImageView!.minX
        y = avatarImageView!.minY
        w = nameLabel!.maxX - avatarImageView!.minX
        h = avatarImageView!.height
        self.profileTouchView?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        let cancelLabel = cancelButton?.titleLabel
        w = cancelLabel?.text?.width(cancelLabel?.font ?? .systemFont(ofSize: 16)) ?? 50
        h = cancelLabel?.textHeight(w) ?? 20
        y = topInset
        x = size.width - w - sideInset
        cancelButton?.frame = .init(x: x, y: y, width: w, height: h)
        
        h = 40
        w = size.width - w - sideInset*3
        x = sideInset
        y = topInset
        searchBar?.frame = .init(x: x, y: y, width: w, height: h)
        
        cancelButton?.y = (searchBar?.centerY ?? 0) - (cancelButton?.size.height ?? 20)/2
    }

    func configure(name: String, status: String, avatarURL: URL?) {
        nameLabel?.text = name
        statusLabel?.text = status
        if let url = avatarURL {
            imageLoader.downloadImage(url: url) { [weak self] image in
                self?.avatarImageView?.image = image
            }
        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        switch sender {
        case backButton:
            backAction?()
        case callButton:
            callAction?()
        case profileTouchView:
            print("Profile button tapped")
        case dotsButton:
            setState(.search)
        case cancelButton:
            setState(.default)
        default:
            break
        }
    }
    
    private func setState(_ state: ChatNavigationState) {
        let changes = { [weak self] in
            guard let self else { return }
            switch state {
            case .search:
                show([
                    searchBar,
                    cancelButton
                ])
                hide([
                    backButton,
                    avatarImageView,
                    nameLabel,
                    statusLabel,
                    profileTouchView,
                    callButton,
                    dotsButton
                ])
                searchBar?.textFieldBecomeFirstResponder()
            case .default:
                show([
                    backButton,
                    avatarImageView,
                    nameLabel,
                    statusLabel,
                    profileTouchView,
                    callButton,
                    dotsButton
                ])
                hide([
                    searchBar,
                    cancelButton
                ])
                searchBar?.textFieldResignFirstResponder()
            }
        }
        
        UIView.animate(withDuration: 0.25, animations: changes)
        stateHasChange?(state)
    }
    
    func makePreviewMode() {
        hide([backButton, callButton, dotsButton])
    }

    func setBackAction(_ target: Any?, action: Selector) {
        
    }

    func setCallAction(_ target: Any?, action: Selector) {
        callButton?.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func setProfileAction(_ target: Any?, action: Selector) {
        profileTouchView?.addTarget(target, action: action, for: .touchUpInside)
    }

    func getHeight() -> CGFloat {
        return 108 + safeAreaInsets.top
    }
    
    private func show(_ views: [UIView?]) {
        views.forEach { $0?.alpha = 1 }
    }
    
    private func hide(_ views: [UIView?]) {
        views.forEach { $0?.alpha = 0 }
    }
}
