//
//  CurrencySelectionProtocols.swift
//  Tedr
//
//  Created by Kostya Lee on 17/05/25.
//

import Foundation
import UIKit

protocol ViewToPresenterCurrencySelectionProtocol: AnyObject {
    var view: PresenterToViewCurrencySelectionProtocol? { get set }
    var interactor: PresenterToInteractorCurrencySelectionProtocol? { get set }
    var router: PresenterToRouterCurrencySelectionProtocol? { get set }

    var selectionDelegate: CurrencySelectionDelegate? { get set }
    
    /// Load all available assets (from Interactor)
    func loadAssets()

    /// Navigate to receive screen with selected asset
    func openReceiveController(index: Int)

    /// Update search input text
    func updateSearch(text: String)

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
}

/// Protocol to communicate from Presenter to View
protocol PresenterToViewCurrencySelectionProtocol: AnyObject {
    /// Display filtered list of assets
    func show(assets: [WalletAssetRow])
}

protocol PresenterToInteractorCurrencySelectionProtocol: AnyObject {
    var presenter: InteractorToPresenterCurrencySelectionProtocol? { get set }
    func fetchAssets()
}

protocol InteractorToPresenterCurrencySelectionProtocol: AnyObject {
    func assetsFetched(assets: [WalletAssetRow])
}

protocol PresenterToRouterCurrencySelectionProtocol: AnyObject {
    static func createModule(delegate: CurrencySelectionDelegate, with direction: CurrencySelectionController.TransferDirection) -> UIViewController
    func pushWalletReceiveController(on vc: CurrencySelectionController, asset: WalletAssetRow)
}
