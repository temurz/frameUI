//
//  WalletSearchPresenter.swift
//  Tedr
//
//  Created by Kostya Lee on 23/05/25.
//

import UIKit
class WalletSearchPresenter: ViewToPresenterWalletSearchProtocol {
    weak var view: PresenterToViewWalletSearchProtocol?
    var interactor: PresenterToInteractorWalletSearchProtocol?
    var router: PresenterToRouterWalletSearchProtocol?

    private let filterManager = AssetSearchFilterManager()

    func loadAssets() {
        interactor?.fetchAssets()
    }

    func updateSearch(text: String) {
        filterManager.updateSearch(text: text)
    }
    
    func hideBalances(_ hide: Bool) {
        filterManager.hideZeroBalances(hide)
    }
    
    func sortBy(_ option: SortOptions) {
        filterManager.sortBy(option)
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

    func selectAsset(_ asset: WalletAssetRow) {
        // logic for selecting asset
    }

    func showFilter(_ navigationController: UINavigationController?, delegate: FilterOptionsSheetViewDelegate?) {
        router?.showFilter(navigationController, delegate: delegate)
    }
}

extension WalletSearchPresenter: InteractorToPresenterWalletSearchProtocol {
    func assetsFetched(assets: [WalletAssetRow]) {
        let filters = NetworkType.allCases.map { $0.rawValue }
        filterManager.networkFilters = [Strings.allNetworks] + filters

        filterManager.onUpdate = { [weak self] filtered in
            self?.view?.show(assets: filtered)
        }
        filterManager.configure(items: assets, filters: filterManager.networkFilters)
    }
}
