//
//  WalletSearchInteractor.swift
//  Tedr
//
//  Created by Kostya Lee on 23/05/25.
//

import Foundation

class WalletSearchInteractor: PresenterToInteractorWalletSearchProtocol {
    weak var presenter: InteractorToPresenterWalletSearchProtocol?

    func fetchAssets() {
        presenter?.assetsFetched(assets: allCurrencies)
    }
}
