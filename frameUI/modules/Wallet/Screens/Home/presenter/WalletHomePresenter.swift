//
//  WalletHomePresenter.swift
//  Tedr
//
//  Created by Kostya Lee on 13/05/25.
//

import UIKit

class WalletHomePresenter: ViewToPresenterWalletHomeProtocol {
    weak var view: PresenterToViewWalletHomeProtocol?
    var interactor: PresenterToInteractorWalletHomeProtocol?
    var router: PresenterToRouterWalletHomeProtocol?

    func loadWallet() {
        interactor?.fetchWalletData()
    }
    
    func openCurrencySelection(for direction: CurrencySelectionController.TransferDirection) {
        if let view = view as? WalletHomeController {
            router?.presentCurrencySelection(on: view, for: direction)
        }
    }
    
    func openSearchController() {
        if let view = view as? WalletHomeController {
            router?.pushSearchController(on: view)
        }
    }
    
    func scan(_ navigationController: UINavigationController?) {
        router?.presentScanViewController(navigationController)
    }

    func openSendController(for asset: WalletAssetRow) {
        if let view = view as? WalletHomeController {
            router?.pushSendController(on: view, for: asset)
        }
    }
}

extension WalletHomePresenter: InteractorToPresenterWalletHomeProtocol {
    func walletFetched(wallet: WalletRow) {
        view?.show(wallet: wallet)
    }
}
