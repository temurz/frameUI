//
//  AddMembersView.swift
//  Tedr
//
//  Created by Temur on 09/07/2025.
//

import UIKit

class AddMembersView: TemplateView {
    private let searchBar = TemplateSearchBar()
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    override func initialize() {
        
        self.addSubview(searchBar)
        
        tableView.register(ContactCell.self, forCellReuseIdentifier: ContactCell.identifier)
        tableView.rowHeight = 72
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        self.addSubview(tableView)
    }
    
    override func updateSubviewsFrame(_ size: CGSize) {
        let padding: CGFloat = 16
        
        var x = padding
        var y = padding
        var w = size.width - 2 * padding
        var h: CGFloat = 44
        searchBar.frame = CGRect(x: x, y: y, width: w, height: h)
        
        x = 0
        y = searchBar.maxY + padding
        w = size.width
        h = size.height - y
        self.tableView.frame = .init(x: x, y: y, width: w, height: h)
    }
    
    func setTableViewDataSourceAndDelegate(_ datasource: UITableViewDataSource & UITableViewDelegate) {
        tableView.dataSource = datasource
        tableView.delegate = datasource
    }
    
    func reloadTableViewData() {
        tableView.reloadData()
    }
}
