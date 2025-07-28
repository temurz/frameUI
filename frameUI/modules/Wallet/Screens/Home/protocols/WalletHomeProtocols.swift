//
//  WalletHomeProtocols.swift
//  Tedr
//
//  Created by Kostya Lee on 13/05/25.
//

import Foundation
import UIKit

protocol ViewToPresenterWalletHomeProtocol: AnyObject {
    var view: PresenterToViewWalletHomeProtocol? { get set }
    var interactor: PresenterToInteractorWalletHomeProtocol? { get set }
    var router: PresenterToRouterWalletHomeProtocol? { get set }
    func loadWallet()
    func openCurrencySelection(for direction: CurrencySelectionController.TransferDirection)
    func openSearchController()
    func scan(_ navigationController: UINavigationController?)
    func openSendController(for asset: WalletAssetRow)
}

protocol PresenterToViewWalletHomeProtocol: AnyObject {
    func show(wallet: WalletRow)
}

protocol PresenterToInteractorWalletHomeProtocol: AnyObject {
    var presenter: InteractorToPresenterWalletHomeProtocol? { get set }
    func fetchWalletData()
}

protocol InteractorToPresenterWalletHomeProtocol: AnyObject {
    func walletFetched(wallet: WalletRow)
}

protocol PresenterToRouterWalletHomeProtocol: AnyObject {
    static func createModule() -> WalletHomeController
    func presentCurrencySelection(on vc: WalletHomeController, for direction: CurrencySelectionController.TransferDirection)
    func pushSearchController(on vc: WalletHomeController)
    func presentScanViewController(_ navigationController: UINavigationController?)
    func pushSendController(on vc: WalletHomeController, for asset: WalletAssetRow)
}
