//
//  WalletSendInteractor.swift
//  Tedr
//
//  Created by Kostya Lee on 29/05/25.
//

import Foundation
class WalletSendInteractor: PresenterToInteractorWalletSendProtocol {
    weak var presenter: InteractorToPresenterWalletSendProtocol?

    func processTransaction(amount: Double, to address: String) {
        if amount > 0 && !address.isEmpty {
            presenter?.transactionSucceeded()
        } else {
            presenter?.transactionFailed(error: Strings.Errors.invalidInput)
        }
    }
}
