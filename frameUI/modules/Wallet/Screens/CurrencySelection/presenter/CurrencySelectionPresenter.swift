//
//  CurrencySelectionPresenter.swift
//  Tedr
//
//  Created by Kostya Lee on 17/05/25.
//

import Foundation

class CurrencySelectionPresenter: ViewToPresenterCurrencySelectionProtocol {
    weak var view: PresenterToViewCurrencySelectionProtocol?
    var interactor: PresenterToInteractorCurrencySelectionProtocol?
    var router: PresenterToRouterCurrencySelectionProtocol?

    let filterManager = AssetSearchFilterManager()
    
    weak var selectionDelegate: CurrencySelectionDelegate?
    
    func attachClosures(to view: CurrencySelectionController) {
        view.selectedCurrency = { [weak self] direction, index in
            guard let self, direction == .send else { return }
            let selectedAsset = self.filterManager.filteredItems[index]
            self.selectionDelegate?.currencySelected(selectedAsset)
            view.dismiss(animated: true)
        }
    }

    func loadAssets() {
        interactor?.fetchAssets()
    }

    func openReceiveController(index: Int) {
        if let view = view as? CurrencySelectionController {
            router?.pushWalletReceiveController(on: view, asset: filterManager.filteredItems[index])
        }
    }

    func updateSearch(text: String) {
        filterManager.updateSearch(text: text)
    }

    func updateNetworkFilter(index: Int) {
        filterManager.updateNetworkFilter(index: index)
    }

    func numberOfItems() -> Int {
        return filterManager.filteredItems.count
    }

    func item(at index: Int) -> WalletAssetRow? {
        guard index >= 0 && index < filterManager.filteredItems.count else { return nil }
        return filterManager.filteredItems[index]
    }

    func numberOfNetworkFilters() -> Int {
        return filterManager.networkFilters.count
    }

    func filterTitle(at index: Int) -> String? {
        guard index >= 0 && index < filterManager.networkFilters.count else { return nil }
        return filterManager.networkFilters[index]
    }

    func isFilterSelected(index: Int) -> Bool {
        return index == filterManager.currentFilterIndex
    }
}

extension CurrencySelectionPresenter: InteractorToPresenterCurrencySelectionProtocol {
    func assetsFetched(assets: [WalletAssetRow]) {
        let filters = NetworkType.allCases.map { $0.rawValue }
        filterManager.networkFilters = [Strings.allNetworks] + filters

        filterManager.onUpdate = { [weak self] filtered in
            self?.view?.show(assets: filtered)
        }
        filterManager.configure(items: assets, filters: filterManager.networkFilters)
    }
}
