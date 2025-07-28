//
//  ChatListView.swift
//  Tedr
//
//  Created by Kostya Lee on 03/06/25.
//

import Foundation
import UIKit
final class ChatListView: TemplateView {
    var navigationView: ChatListNavigationView?
    var tableView: UITableView?
    var emptyListLabel: UILabel?
    var isSearchResultHidden = true
    var stateHasChange: ((ChatListNavigationState) -> Void)?
    
    var blurView: UIView?
    var focusedChatView: ChatView?
    var contextMenu: ContextMenu?
    private var cancelReorderButton: UIButton?
    private var finishReorderButton: UIButton?
    
    var cancelReorderAction: (() -> Void)?
    var finishReorderAction: (() -> Void)?
    
    override func initialize() {
        let theme = theme ?? Theme()
        self.backgroundColor = theme.backgroundPrimaryColor
        
        tableView = UITableView()
        tableView?.backgroundColor = .clear
        self.addSubview(tableView)
        
        emptyListLabel = UILabel()
        emptyListLabel?.isHidden = true
        emptyListLabel?.text = "NO RESULTS"
        emptyListLabel?.font = theme.onestFont(size: 13, weight: .regular)
        emptyListLabel?.textColor = theme.contentSecondary
        self.addSubview(emptyListLabel)
        
        navigationView = ChatListNavigationView()
        navigationView?.backgroundColor = .systemPink
        navigationView?.stateHasChange = { [weak self] state in
            guard let self else { return }
            isSearchResultHidden = state != .search
            updateSubviewsFrame(bounds.size)
            stateHasChange?(state)
        }
        self.addSubview(navigationView)
        
        blurView = UIView()
        blurView?.isHidden = true
        blurView?.addTapGesture(tapNumber: 1, action: { [weak self] _ in
            guard let self else { return }
            showFocusedViews(false)
        })
        self.addSubview(blurView)
        
        focusedChatView = ChatView(isPreviewMode: true)
        focusedChatView?.isHidden = true
        focusedChatView?.borderRadius = 16
        self.addSubview(focusedChatView)
        
        contextMenu = ContextMenu()
        contextMenu?.isHidden = true
        contextMenu?.borderRadius = 16
        contextMenu?.action = { _ in
            
        }
        self.addSubview(contextMenu)
        
        cancelReorderButton = UIButton()
        cancelReorderButton?.setImage(theme.crossIcon?.withTintColor(.white), for: .normal)
        cancelReorderButton?.isHidden = true
        cancelReorderButton?.backgroundColor = theme.whiteColor.withAlphaComponent(0.2)
        cancelReorderButton?.addTapGesture(tapNumber: 1, action: { [weak self] _ in
            self?.cancelReorderAction?()
        })
        self.addSubview(cancelReorderButton)
        
        finishReorderButton = UIButton()
        finishReorderButton?.setImage(theme.checkIcon, for: .normal)
        finishReorderButton?.backgroundColor = theme.contentBlue
        finishReorderButton?.isHidden = true
        finishReorderButton?.addTapGesture(tapNumber: 1, action: { [weak self] _ in
            self?.finishReorderAction?()
        })
        self.addSubview(finishReorderButton)
    }
    
    override func updateSubviewsFrame(_ size: CGSize) {
        let padding = CGFloat(16)
        var x = CGFloat(0)
        var y = CGFloat(0)
        var w = CGFloat(size.width)
        var h = CGFloat(navigationView!.getHeight())
        self.navigationView?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        y = navigationView!.maxY
        h = size.height
        self.tableView?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        x = 16
        y += 16
        w = emptyListLabel?.text?.width(emptyListLabel?.font) ?? 100
        h = emptyListLabel?.textHeight(w) ?? 24
        emptyListLabel?.frame = .init(x: x, y: y, width: w, height: h)
        
        self.blurView?.frame = .init(origin: .zero, size: size)
        blurView?.applyBlur(style: .regular)
        
        h = contextMenu?.getHeight() ?? 100
        y = size.height - safeAreaInsets.bottom - h - padding - 88
        w = size.width * 0.58
        x = size.width - padding - w
        contextMenu?.frame = .init(x: x, y: y, width: w, height: h)
        
        h = (size.height - (navigationView?.maxY ?? 0) - padding * 2) / 2
        w = size.width - (16*2)
        x = 16
        y = (contextMenu?.minY ?? 0) - h - 8
        focusedChatView?.frame = .init(x: x, y: y, width: w, height: h)
        
        w = 56
        h = w
        y = size.height - safeAreaInsets.bottom - h - padding - 88
        x = size.width/2 - w - padding/2
        self.cancelReorderButton?.frame = .init(x: x, y: y, width: w, height: h)
        cancelReorderButton?.borderRadius = 28
        
        x = (cancelReorderButton?.maxX ?? 0) + padding
        self.finishReorderButton?.frame = .init(x: x, y: y, width: w, height: h)
        finishReorderButton?.borderRadius = 28
    }
    
    override func updateTheme() {
        
    }
    
    func setReorderingState(_ bool: Bool) {
        cancelReorderButton?.isHidden = !bool
        finishReorderButton?.isHidden = !bool
    }
    
    func showFocusedViews(_ bool: Bool) {
        blurView?.isHidden = !bool
        focusedChatView?.isHidden = !bool
        contextMenu?.isHidden = !bool
    }
    
    func showFocusedChat(with provider: UITableViewDataSource & UITableViewDelegate) {
        focusedChatView?.isHidden = false
        blurView?.isHidden = false
        contextMenu?.isHidden = false
        focusedChatView?.tableView?.dataSource = provider
        focusedChatView?.tableView?.delegate = provider
        focusedChatView?.tableView?.reloadData()
        
        let theme = theme ?? Theme()
        contextMenu?.setItems([
            ContextItem(title: "Mark as read", image: theme.readIcon, tag: 0),
            ContextItem(title: "Reorder", image: theme.reorderIcon, tag: 1),
            ContextItem(title: "Pin", image: theme.pinIcon, tag: 2),
            ContextItem(title: "Mute", image: theme.muteIcon, tag: 3),
            ContextItem(title: "Delete", image: theme.trashIcon, color: theme.contentRed, tag: 3),
            
        ])
        updateSubviewsFrame(self.size)
    }
}
