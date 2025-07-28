//
//  CurrencySelectionView.swift
//  Tedr
//
//  Created by Kostya Lee on 17/05/25.
//

import Foundation
import UIKit
class CurrencySelectionView: TemplateView, UISearchBarDelegate {

    private var homeIndicator: UIView?
    private var titleLabel: UILabel?
    var searchBar: TemplateSearchBar?
    var filterCollectionView: UICollectionView?
    var tableView: UITableView?

    override func initialize() {
        
        backgroundColor = Theme().backgroundTertiaryColor
        
        homeIndicator = UIView()
        homeIndicator?.backgroundColor = Theme().contentSecondary
        self.addSubview(homeIndicator)

        titleLabel = UILabel()
        titleLabel?.text = Strings.send
        titleLabel?.font = Theme().getFont(size: 18, weight: .bold)
        titleLabel?.textColor = Theme().darkTextColor
        self.addSubview(titleLabel)
        
        searchBar = TemplateSearchBar()
        searchBar?.placeholder = Strings.searchTokensAndWallets
        self.addSubview(searchBar)

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12

        filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        filterCollectionView?.register(CurrencyFilterChipCell.self, forCellWithReuseIdentifier: CurrencyFilterChipCell.id)
        filterCollectionView?.backgroundColor = .clear
        filterCollectionView?.showsHorizontalScrollIndicator = false
        self.addSubview(filterCollectionView)

        tableView = UITableView()
        tableView?.register(WalletAssetCell.self, forCellReuseIdentifier: WalletAssetCell.id)
        tableView?.separatorStyle = .none
        tableView?.backgroundColor = .clear
        self.addSubview(tableView)
    }

    override func updateSubviewsFrame(_ size: CGSize) {
        var x = CGFloat(0)
        var y = CGFloat(0)
        var w = CGFloat(0)
        var h = CGFloat(0)
        let padding: CGFloat = 16
        
        w = 40
        h = 5
        x = size.width/2 - w/2
        y = 5
        self.homeIndicator?.frame = CGRect(x: x, y: y, width: w, height: h)
        homeIndicator?.layer.cornerRadius = h/2

        w = titleLabel?.getWidth() ?? 0
        h = 20
        x = (size.width - w) / 2
        y = padding*2 + 5
        self.titleLabel?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        x = padding
        y += h + padding*2
        w = size.width - padding * 2
        h = searchBar?.getHeight() ?? 0
        self.searchBar?.frame = CGRect(x: x, y: y, width: w, height: h)

        x = 0
        w = size.width
        y += h + padding
        h = 45
        self.filterCollectionView?.frame = CGRect(x: x, y: y, width: w, height: h)
        filterCollectionView?.contentInset = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)

        y += h + 10
        h = size.height - y
        self.tableView?.frame = CGRect(x: x, y: y, width: w, height: h)
    }

    func configure(direction: CurrencySelectionController.TransferDirection) {
        switch direction {
        case .receive:
            titleLabel?.text = Strings.receive
        case .send:
            titleLabel?.text = Strings.send
        }
    }
    
    func showKeyboard() {
        searchBar?.textFieldBecomeFirstResponder()
    }
}
