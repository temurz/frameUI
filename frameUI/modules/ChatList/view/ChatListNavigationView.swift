//
//  ChatListNavigationView.swift
//  Tedr
//
//  Created by Kostya Lee on 07/06/25.
//

import Foundation
import UIKit

enum ChatListNavigationState {
    case expanded
    case search
    case collapsed
}

final class ChatListNavigationView: UIView {

    private var gradientBgLayer: CAGradientLayer?
    private var titleLabel: UILabel?
    private var scanButton: UIButton?
    private var searchButton: UIButton?
    private var addButton: UIButton?
    private var searchBar: TemplateSearchBar?
    private var cancelButton: UIButton?
    private var storyCollectionView: UICollectionView?
    
    var stateHasChange: ((ChatListNavigationState) -> Void)?
    var didSearchWithText: ((String) -> Void)?
    var addButtonAction: (() -> Void)?
    
    private(set) var state: ChatListNavigationState = .expanded

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        let theme = Theme()
        
        gradientBgLayer = CAGradientLayer()
        gradientBgLayer?.colors = [UIColor.systemPink.cgColor, UIColor.systemPurple.cgColor]
        gradientBgLayer?.startPoint = CGPoint(x: 0, y: 0)
        gradientBgLayer?.endPoint = CGPoint(x: 1, y: 1)
        gradientBgLayer?.frame = bounds
        layer.insertSublayer(gradientBgLayer!, at: 0)

        titleLabel = UILabel()
        titleLabel?.text = "Chats"
        titleLabel?.textAlignment = .center
        titleLabel?.textColor = theme.contentWhite
        titleLabel?.font = theme.getFont(size: 18, weight: .bold)
        addSubview(titleLabel)

        scanButton = UIButton()
        scanButton?.setImage(theme.scanIcon, for: .normal)
        scanButton?.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        addSubview(scanButton)
        
        searchButton = UIButton()
        searchButton?.setImage(theme.searchIcon, for: .normal)
        searchButton?.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        addSubview(searchButton)

        addButton = UIButton()
        addButton?.setImage(theme.plusIcon, for: .normal)
        addButton?.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        addSubview(addButton)
        
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

        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.scrollDirection = .horizontal
        layout.itemSize = ChatListStoryCell.getSize()
        
        storyCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        storyCollectionView?.showsHorizontalScrollIndicator = false
        storyCollectionView?.backgroundColor = .clear
        storyCollectionView?.register(ChatListStoryCell.self, forCellWithReuseIdentifier: ChatListStoryCell.reuseId)
        addSubview(storyCollectionView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let padding = 16.0
        
        var x: CGFloat = 0
        var y: CGFloat = 0
        var w: CGFloat = bounds.width
        var h: CGFloat = 0
        
        gradientBgLayer?.frame = bounds
        
        h = 24
        y = safeAreaInsets.top
        titleLabel?.frame = CGRect(x: 0, y: y, width: w, height: h)

        w = 24
        h = w
        x = padding
        scanButton?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        x = bounds.width - w - padding
        addButton?.frame = CGRect(x: x, y: y, width: w, height: h)

        x -= w + padding
        searchButton?.frame = CGRect(x: x, y: y, width: w, height: h)

        y = titleLabel!.frame.maxY + padding
        h = ChatListStoryCell.getSize().height
        w = bounds.width
        storyCollectionView?.frame = CGRect(x: 0, y: y, width: w, height: h)
        
        let cancelLabel = cancelButton?.titleLabel
        w = cancelLabel?.text?.width(cancelLabel?.font ?? .systemFont(ofSize: 16)) ?? 50
        h = cancelLabel?.textHeight(w) ?? 20
        y = safeAreaInsets.top
        x = bounds.width - w - padding
        cancelButton?.frame = .init(x: x, y: y, width: w, height: h)
        
        h = 40
        w = bounds.width - w - padding*3
        x = padding
        y = safeAreaInsets.top
        searchBar?.frame = .init(x: x, y: y, width: w, height: h)
        
        cancelButton?.y = (searchBar?.centerY ?? 0) - (cancelButton?.size.height ?? 20)/2
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        switch sender {
        case scanButton:
            print("scan button tapped")
        case addButton:
            addButtonAction?()
        case searchButton:
            setState(.search)
        case cancelButton:
            searchBar?.resignFirstResponder()
            setState(.expanded)
        default:
            break
        }
    }
    
    func setCollectionDelegate(_ delegate: UICollectionViewDelegate & UICollectionViewDataSource) {
        self.storyCollectionView?.delegate = delegate
        self.storyCollectionView?.dataSource = delegate
    }
    
    func getHeight() -> CGFloat {
        let topSafeArea = safeAreaInsets.top == 0 ? 62 : safeAreaInsets.top
        switch state {
        case .expanded:
            return 148 + topSafeArea
        default:
            return 48 + topSafeArea
        }
    }

    // MARK: Public API
    
    func setState(_ state: ChatListNavigationState) {
        self.state = state
        
        let changes = { [weak self] in
            guard let self else { return }
            switch state {
            case .expanded:
                show(
                    [titleLabel,
                     scanButton,
                     addButton,
                     searchButton,
                     storyCollectionView]
                )
                hide(
                    [
                        cancelButton,
                        searchBar
                    ]
                )
            case .search:
                hide(
                    [
                        titleLabel,
                        scanButton,
                        addButton,
                        searchButton,
                        storyCollectionView
                    ]
                )
                show(
                    [
                        cancelButton,
                        searchBar
                    ]
                )
            case .collapsed:
                show(
                    [titleLabel,
                     scanButton,
                     addButton,
                     searchButton]
                )
                
                hide(
                    [
                        storyCollectionView,
                        cancelButton,
                        searchBar
                    ]
                )
            }
        }
        
        UIView.animate(withDuration: 0.25, animations: changes)

        stateHasChange?(state)
    }
    
    func show(_ views: [UIView?]) {
        views.forEach { $0?.alpha = 1 }
    }
    
    func hide(_ views: [UIView?]) {
        views.forEach { $0?.alpha = 0 }
    }
}

