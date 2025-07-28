//
//  WalletSendProtocols.swift
//  Tedr
//
//  Created by Kostya Lee on 29/05/25.
//

import Foundation
import UIKit

protocol ViewToPresenterWalletSendProtocol: AnyObject {
    var view: PresenterToViewWalletSendProtocol? { get set }
    var interactor: PresenterToInteractorWalletSendProtocol? { get set }
    var router: PresenterToRouterWalletSendProtocol? { get set }
    
    var asset: WalletAssetRow { get set }
    
    var didShowCurrencySelection: Bool { get set }

    func sendTransaction(amount: Double, to address: String)
    func goBack(navigationController: UINavigationController?)
    func showCurrencySelection()
    func handleCallback(_ action: WalletSendController.Action)
}

protocol PresenterToViewWalletSendProtocol: AnyObject {
    func show(asset: WalletAssetRow)
}

protocol PresenterToRouterWalletSendProtocol: AnyObject {
    static func createModule(defaultAsset: WalletAssetRow) -> WalletSendController
    func navigateBack(navigationController: UINavigationController?)
    func presentCurrencySelection(_ vc: WalletSendController)
    func presentScanViewController(_ vc: WalletSendController)
    func presentTransactionDetails(_ vc: WalletSendController, transaction: TransactionDetails)
}

protocol PresenterToInteractorWalletSendProtocol: AnyObject {
    var presenter: InteractorToPresenterWalletSendProtocol? { get set }
    func processTransaction(amount: Double, to address: String)
}

protocol InteractorToPresenterWalletSendProtocol: AnyObject {
    func transactionSucceeded()
    func transactionFailed(error: String)
}
