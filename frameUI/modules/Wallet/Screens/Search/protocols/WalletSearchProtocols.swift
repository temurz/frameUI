//
//  WalletSearchProtocols.swift
//  Tedr
//
//  Created by Kostya Lee on 23/05/25.
//

import UIKit

protocol ViewToPresenterWalletSearchProtocol: AnyObject {
    var view: PresenterToViewWalletSearchProtocol? { get set }
    var interactor: PresenterToInteractorWalletSearchProtocol? { get set }
    var router: PresenterToRouterWalletSearchProtocol? { get set }

    func showFilter(_ navigationController: UINavigationController?, delegate: FilterOptionsSheetViewDelegate?)

    /// Load all available assets (from Interactor)
    func loadAssets()

    /// Update search input text
    func updateSearch(text: String)
    
    /// Hide zero balances
    func hideBalances(_ hide: Bool)
    
    /// Sort by options
    func sortBy(_ option: SortOptions)

    /// Change selected network filter index
    func updateNetworkFilter(index: Int)

    /// Number of filtered items to show
    func numberOfItems() -> Int

    /// Get filtered item at index
    func item(at index: Int) -> WalletAssetRow?

    /// Number of available filters
    func numberOfNetworkFilters() -> Int

    /// Title of filter at index
    func filterTitle(at index: Int) -> String?

    /// Check if given filter index is currently selected
    func isFilterSelected(index: Int) -> Bool

    func selectAsset(_ asset: WalletAssetRow)
}

protocol PresenterToViewWalletSearchProtocol: AnyObject {
    func show(assets: [WalletAssetRow])
}

protocol PresenterToInteractorWalletSearchProtocol: AnyObject {
    var presenter: InteractorToPresenterWalletSearchProtocol? { get set }
    func fetchAssets()
}

protocol InteractorToPresenterWalletSearchProtocol: AnyObject {
    func assetsFetched(assets: [WalletAssetRow])
}

protocol PresenterToRouterWalletSearchProtocol: AnyObject {
    static func createModule() -> WalletSearchController
    func showFilter(_ navigationController: UINavigationController?, delegate: FilterOptionsSheetViewDelegate?)
}
