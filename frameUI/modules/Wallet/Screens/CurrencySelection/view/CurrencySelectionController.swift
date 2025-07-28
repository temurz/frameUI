//
//  CurrencySelectionController.swift
//  Tedr
//
//  Created by Kostya Lee on 17/05/25.
//

import Foundation
import UIKit
class CurrencySelectionController: TemplateController {
    enum TransferDirection {
        case send, receive
    }

    var presenter: ViewToPresenterCurrencySelectionProtocol?
    var mainView: CurrencySelectionView?
    let direction: TransferDirection
    
    var selectedCurrency: ((TransferDirection, Int) -> Void)?

    init(direction: TransferDirection) {
        self.direction = direction
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func initialize() {
        mainView = CurrencySelectionView()
        mainView?.configure(direction: self.direction)

        mainView?.tableView?.delegate = self
        mainView?.tableView?.dataSource = self

        mainView?.filterCollectionView?.delegate = self
        mainView?.filterCollectionView?.dataSource = self

        mainView?.searchBar?.textDidChange = { [weak self] text in
            self?.presenter?.updateSearch(text: text)
        }

        view.addSubview(mainView!)
        presenter?.loadAssets()
    }

    override func updateSubviewsFrames(_ size: CGSize) {
        mainView?.frame = view.bounds
    }
}

extension CurrencySelectionController: PresenterToViewCurrencySelectionProtocol {
    func show(assets: [WalletAssetRow]) {
        mainView?.configure(direction: direction)
        mainView?.tableView?.reloadData()
    }
}

extension CurrencySelectionController: UITableViewDelegate, UITableViewDataSource {
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCurrency?(direction, indexPath.row)
        if direction == .receive {
            presenter?.openReceiveController(index: indexPath.row)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        WalletAssetCell.getHeight()
    }
}

extension CurrencySelectionController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
