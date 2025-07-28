//
//  NewMessageView.swift
//  Tedr
//
//  Created by Temur on 09/07/2025.
//  
//

import UIKit

class NewMessageView: TemplateView {
    private let searchBar = TemplateSearchBar()
    private let optionsBgView = UIView()
    private let newGroupButton = CreateChatButton()
    private let newConferenceButton = CreateChatButton()
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    var newGroupAction: (() -> Void)?
    
    override func initialize() {
        let theme = theme ?? Theme()
        
        self.addSubview(searchBar)
        
        optionsBgView.backgroundColor = theme.bgSecondaryTransparent20
        optionsBgView.layer.cornerRadius = 12
        self.addSubview(optionsBgView)
        
        newGroupButton.update(icon: theme.groupIcon, title: "New group")
        newGroupButton.addTapGesture(tapNumber: 1) { [weak self] _ in
            self?.newGroupAction?()
        }
        optionsBgView.addSubview(newGroupButton)
        
        newConferenceButton.update(icon: theme.loaderIcon, title: "New conference")
        optionsBgView.addSubview(newConferenceButton)
        
        tableView.register(ContactCell.self, forCellReuseIdentifier: ContactCell.identifier)
        tableView.rowHeight = 72
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.sectionFooterHeight = 0
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = nil
        self.addSubview(tableView)
    }
    
    override func updateSubviewsFrame(_ size: CGSize) {
        let padding: CGFloat = 16
        let searchBarHeight: CGFloat = 44
        let optionsTop: CGFloat = 20
        let buttonHeight: CGFloat = 56
        let buttonSpacing: CGFloat = 8
        
        var x = padding
        var y = padding
        var w = size.width - 2 * padding
        var h = searchBarHeight
        searchBar.frame = CGRect(x: x, y: y, width: w, height: h)
        
        y = searchBar.frame.maxY + optionsTop
        w = size.width - (2 * padding)
        h = buttonHeight * 2 + buttonSpacing + (padding * 2)
        optionsBgView.frame = CGRect(x: x, y: y, width: w, height: h)
        
        x = 0
        y = buttonSpacing
        w = optionsBgView.frame.width
        h = buttonHeight
        newGroupButton.frame = CGRect(x: x, y: y, width: w, height: h)
        
        x = 0
        y = newGroupButton.frame.maxY + buttonSpacing
        w = optionsBgView.frame.width
        h = buttonHeight
        newConferenceButton.frame = CGRect(x: x, y: y, width: w, height: h)
        
        x = 0
        y = optionsBgView.maxY + padding
        w = size.width
        h = size.height - y
        self.tableView.frame = .init(x: x, y: y, width: w, height: h)
    }
    override func updateTheme() {}
    
    func setTableViewDataSourceAndDelegate(_ datasource: UITableViewDataSource & UITableViewDelegate) {
        tableView.dataSource = datasource
        tableView.delegate = datasource
    }
    
    func reloadTableViewData() {
        tableView.reloadData()
    }
}
