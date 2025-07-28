//
//  WalletSearchController.swift
//  Tedr
//
//  Created by Kostya Lee on 23/05/25.
//

import Foundation
import UIKit
class WalletSearchController: TemplateController {
    var presenter: ViewToPresenterWalletSearchProtocol?
    var mainView: WalletSearchView?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainView?.showKeyboard()
    }

    override func initialize() {
        mainView = WalletSearchView()

        mainView?.didSelectBack = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        mainView?.didSelectFilter = { [weak self] in
            guard let self else { return }
            presenter?.showFilter(navigationController, delegate: self)
        }
        mainView?.didSelectCurrency = { [weak self] asset in
            self?.presenter?.selectAsset(asset)
        }
        mainView?.searchBar?.textDidChange = { [weak self] text in
            self?.presenter?.updateSearch(text: text)
        }

        mainView?.tableView?.delegate = self
        mainView?.tableView?.dataSource = self

        mainView?.filterCollectionView?.delegate = self
        mainView?.filterCollectionView?.dataSource = self

        view.addSubview(mainView!)
        presenter?.loadAssets()
    }

    override func updateSubviewsFrames(_ size: CGSize) {
        mainView?.frame = view.bounds
    }
}

extension WalletSearchController: PresenterToViewWalletSearchProtocol {
    func show(assets: [WalletAssetRow]) {
        mainView?.tableView?.reloadData()
    }
}

extension WalletSearchController: FilterOptionsSheetViewDelegate {
    func selectedOptions(_ option: SortOptions) {
        presenter?.sortBy(option)
    }
    
    func hideZeroBalance(_ hide: Bool) {
        presenter?.hideBalances(hide)
    }
}

extension WalletSearchController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfItems() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WalletAssetCell.id, for: indexPath) as? WalletAssetCell,
              let asset = presenter?.item(at: indexPath.row) else {
            return UITableViewCell()
        }
        cell.configure(asset: asset)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        WalletAssetCell.getHeight()
    }
}

extension WalletSearchController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfNetworkFilters() ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CurrencyFilterChipCell.id,
            for: indexPath
        ) as? CurrencyFilterChipCell,
        let title = presenter?.filterTitle(at: indexPath.item),
        let isSelected = presenter?.isFilterSelected(index: indexPath.item) else {
            return UICollectionViewCell()
        }

        cell.configure(with: title, selected: isSelected, disabled: !isSelected)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.updateNetworkFilter(index: indexPath.item)
        mainView?.filterCollectionView?.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let title = presenter?.filterTitle(at: indexPath.item) else {
            return .zero
        }
        let label = UILabel()
        label.text = title.uppercased()
        label.font = CurrencyFilterChipCell.getTextLabelFont()
        label.sizeToFit()
        return CGSize(width: label.getWidth() + 56, height: 45)
    }
}
