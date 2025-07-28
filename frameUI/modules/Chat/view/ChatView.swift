//
//  ChatView.swift
//  Tedr
//
//  Created by Kostya Lee on 11/06/25.
//

import Foundation
import UIKit
final class ChatView: TemplateView {
    private(set) var navigationView: ChatNavigationView?
    private(set) var tableView: UITableView?
    private(set) var inputPanel: ChatInputPanelView?
    private(set) var searchResultPanel: SearchResultPanel?
    
    private var originalInputPanelFrame: CGRect = .zero
    private let isPreviewMode: Bool
    
    init(isPreviewMode: Bool = false) {
        self.isPreviewMode = isPreviewMode
        super.init(frame: .zero)
    }
    
    @MainActor required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func initialize() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.backgroundColor = Theme().backgroundPrimaryColor

        tableView = UITableView()
        tableView?.separatorStyle = .none
        tableView?.backgroundColor = .clear
        tableView?.transform = CGAffineTransform(scaleX: 1, y: -1)
        tableView?.register(ChatCell.self, forCellReuseIdentifier: ChatCell.reuseId)
        self.addSubview(tableView)
        
        navigationView = ChatNavigationView()
        navigationView?.didSearchWithText = { [weak self] text in
            
        }
        navigationView?.stateHasChange = { [weak self] state in
            self?.setState(state)
        }
        self.addSubview(navigationView)
        
        inputPanel = ChatInputPanelView()
        self.addSubview(inputPanel)
        
        searchResultPanel = SearchResultPanel()
        searchResultPanel?.isHidden = true
        self.addSubview(searchResultPanel)
        
        if isPreviewMode {
            inputPanel?.isHidden = true
            navigationView?.makePreviewMode()
        }
    }
    
    override func deinitValues() {
        super.deinitValues()
        self.removeAllSubviews()
        NotificationCenter.default.removeObserver(self)
    }

    override func updateSubviewsFrame(_ size: CGSize) {
        var x: CGFloat = 0
        var y: CGFloat = 0
        var w: CGFloat = 0
        var h: CGFloat = 0
        tableView?.frame = CGRect(origin: .zero, size: size)
        tableView?.contentInset = UIEdgeInsets(top: 60, left: 0, bottom: 80, right: 0)
        
        h = navigationView!.getHeight()
        x = 0
        y = 0
        w = size.width
        if isPreviewMode {
            h = 56
        }
        navigationView?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        h = inputPanel!.getHeight()
        y = size.height - h
        x = 0
        inputPanel?.frame = CGRect(x: x, y: y, width: w, height: h)
        self.originalInputPanelFrame = inputPanel?.frame ?? .zero
        
        self.searchResultPanel?.frame = .init(x: x, y: y, width: w, height: h)
    }

    override func updateTheme() {
        navigationView?.updateTheme()
        inputPanel?.updateTheme()
        searchResultPanel?.updateTheme()
        tableView?.reloadData()
    }
    
    private func setState(_ state: ChatNavigationState) {
        switch state {
        case .search:
            searchResultPanel?.isHidden = false
            inputPanel?.isHidden = true
        case .default:
            searchResultPanel?.isHidden = true
            inputPanel?.isHidden = false
        }
    }
    
    func updateSearchResultLabel(_ text: String) {
        searchResultPanel?.updateResultLabel(text)
    }
}

// MARK: - ScrollView
extension ChatView {
    @objc func keyboardWillShow(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
            let curveRaw = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
        else { return }
        
        let keyboardHeight = keyboardFrame.height

        var newInputPanelFrame = inputPanel?.frame ?? .zero
        newInputPanelFrame.size.height = 78
        newInputPanelFrame.origin.y = bounds.height - keyboardHeight - newInputPanelFrame.height

        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: UIView.AnimationOptions(rawValue: curveRaw << 16),
            animations: { [weak self] in
                guard let self else { return }
                self.inputPanel?.frame = newInputPanelFrame
                self.searchResultPanel?.frame = newInputPanelFrame
                let newHeight = bounds.height - keyboardHeight - newInputPanelFrame.height
                self.tableView?.frame = .init(x: 0, y: 0, width: self.size.width, height: newHeight)
                self.tableView?.contentInset = .zero
                inputPanel?.isKeyboardActive = true
                inputPanel?.animateUpdateFrames(0.25)
            }
        )
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
            let curveRaw = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
        else { return }
        
        // Вернуть на исходную позицию
        var newFrame = inputPanel?.frame ?? .zero
        newFrame.origin.y = originalInputPanelFrame.minY
        newFrame.size.height = originalInputPanelFrame.height

        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: UIView.AnimationOptions(rawValue: curveRaw << 16),
            animations: { [weak self] in
                guard let self else { return }
                self.inputPanel?.frame = newFrame
                self.searchResultPanel?.frame = newFrame
                self.tableView?.frame = .init(x: 0, y: 0, width: bounds.width, height: bounds.height)
                self.tableView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 70, right: 0)
                inputPanel?.isKeyboardActive = false
                inputPanel?.animateUpdateFrames(0.25)
            }
        )
    }
}
