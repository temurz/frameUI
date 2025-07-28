//
//  WalletHomeView.swift
//  Tedr
//
//  Created by Kostya Lee on 13/05/25.
//

import Foundation
import UIKit

class WalletHomeView: TemplateView {
    
    private var headerView: WalletHomeHeaderView?
    private var tableView: UITableView?
    private var tableHeaderView: WalletHomeTableHeaderView?
    
    var receiveCallback: (() -> Void)?
    var sendCallback: (() -> Void)?
    var headerSwapCallback: (() -> Void)?
    var headerScanCallback: (() -> Void)?
    var headerSearchCallback: (() -> Void)?
    
    override func initialize() {
        
        self.backgroundColor = Theme().backgroundPrimaryColor
        
        tableView = UITableView()
        tableView?.backgroundColor = .clear
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(WalletAssetCell.self, forCellReuseIdentifier: WalletAssetCell.id)
        
        tableHeaderView = WalletHomeTableHeaderView()
        tableHeaderView?.frame = CGRect(x: 0, y: 0, width: self.size.width, height: 400)
        tableView?.tableHeaderView = tableHeaderView
        self.addSubview(tableView)
        
        tableHeaderView?.receiveCallback = { [weak self] in
            self?.receiveCallback?()
        }
        
        tableHeaderView?.sendCallback = { [weak self] in
            self?.sendCallback?()
        }
        
        headerView = WalletHomeHeaderView()
        headerView?.headerSwapCallback = { [weak self] in
            self?.headerSwapCallback?()
        }
        headerView?.headerScanCallback = { [weak self] in
            self?.headerScanCallback?()
        }
        headerView?.headerSearchCallback = { [weak self] in
            self?.headerSearchCallback?()
        }
        self.addSubview(headerView)
    }

    override func updateSubviewsFrame(_ size: CGSize) {
        let x = CGFloat(0)
        var y = CGFloat(0)
        let w = CGFloat(size.width)
        let h = CGFloat(headerView!.getHeight())
        self.headerView?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        y = (headerView?.getHeight() ?? 0) + 16
        self.tableView?.frame = self.bounds
        
        let topInset = 50.0
        tableView?.contentInset = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
        tableView?.contentOffset = CGPoint(x: 0, y: -100)
    }

    func configure(with wallet: WalletRow) {
        tableHeaderView?.configure(with: wallet)
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return true
    }

}

extension WalletHomeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCurrencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: WalletAssetCell.id, for: indexPath) as? WalletAssetCell {
            cell.configure(asset: allCurrencies[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        WalletAssetCell.getHeight()
    }
}
