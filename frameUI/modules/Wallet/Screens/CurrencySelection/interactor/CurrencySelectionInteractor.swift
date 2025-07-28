//
//  CurrencySelectionInteractor.swift
//  Tedr
//
//  Created by Kostya Lee on 17/05/25.
//

import Foundation

class CurrencySelectionInteractor: PresenterToInteractorCurrencySelectionProtocol {
    weak var presenter: InteractorToPresenterCurrencySelectionProtocol?

    func fetchAssets() {
        presenter?.assetsFetched(assets: allCurrencies)
    }
}
