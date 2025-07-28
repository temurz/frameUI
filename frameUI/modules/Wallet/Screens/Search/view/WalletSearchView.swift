//
//  WalletSearchView.swift
//  Tedr
//
//  Created by Kostya Lee on 23/05/25.
//

import Foundation
import UIKit

class WalletSearchView: TemplateView, UISearchBarDelegate {

    private var backButton: UIButton?
    private var titleLabel: UILabel?
    private var filterButton: UIButton?
    
    var searchBar: TemplateSearchBar?
    var filterCollectionView: UICollectionView?
    var tableView: UITableView?
    
    var didSelectBack: (() -> Void)?
    var didSelectFilter: (() -> Void)?
    var didSelectCurrency: ((WalletAssetRow) -> Void)?

    override func initialize() {
        let theme = Theme()
        
        backgroundColor = theme.backgroundPrimaryColor
        
        backButton = UIButton()
        backButton?.setImage(theme.arrowLeftLIcon, for: .normal)
        backButton?.tag = 0
        backButton?.addTarget(self, action: #selector(navigationButtonTapped(_:)), for: .touchUpInside)
        self.addSubview(backButton)
        
        titleLabel = UILabel()
        titleLabel?.text = translate("Search")
        titleLabel?.font = theme.getFont(size: 18, weight: .bold)
        titleLabel?.textColor = theme.darkTextColor
        self.addSubview(titleLabel)

        filterButton = UIButton()
        filterButton?.setImage(theme.filterIcon, for: .normal)
        filterButton?.tag = 1
        filterButton?.addTarget(self, action: #selector(navigationButtonTapped(_:)), for: .touchUpInside)
        self.addSubview(filterButton)
        
        searchBar = TemplateSearchBar()
        searchBar?.placeholder = translate("Search tokens")
        searchBar?.textDidChange = { [weak self] _ in
            
        }
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
        let topSafe = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
        
        w = titleLabel?.getWidth() ?? 0
        h = 20
        x = (size.width - w) / 2
        y = padding + topSafe
        self.titleLabel?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        h = 24
        w = h
        x = padding
        y = titleLabel!.centerY - h / 2
        self.backButton?.frame = CGRect(x: x, y: y, width: w, height: h)
        
        x = size.width - w - padding
        self.filterButton?.frame = CGRect(x: x, y: y, width: w, height: h)
        
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

    func showKeyboard() {
        searchBar?.textFieldBecomeFirstResponder()
    }
    
    @objc private func navigationButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            didSelectBack?()
        case 1:
            didSelectFilter?()
        default:
            break
        }
    }
}
