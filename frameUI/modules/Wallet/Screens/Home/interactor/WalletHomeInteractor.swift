//
//  WalletHomeInteractor.swift
//  Tedr
//
//  Created by Kostya Lee on 13/05/25.
//

import Foundation

class WalletHomeInteractor: PresenterToInteractorWalletHomeProtocol {
    weak var presenter: InteractorToPresenterWalletHomeProtocol?

    func fetchWalletData() {
        let assets: [WalletAssetRow] = []
        let wallet = WalletRow(balance: "10,720.00 USD", growth: "$26,80", growthPercentage: "+3,25%", assets: assets)
        presenter?.walletFetched(wallet: wallet)
    }
}
