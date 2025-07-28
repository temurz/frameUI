//
//  WalletHomeRouter.swift
//  Tedr
//
//  Created by Kostya Lee on 13/05/25.
//

import UIKit
class WalletHomeRouter: PresenterToRouterWalletHomeProtocol {
    static func createModule() -> WalletHomeController {
        let view = WalletHomeController()
        let presenter: ViewToPresenterWalletHomeProtocol & InteractorToPresenterWalletHomeProtocol = WalletHomePresenter()
        let interactor: PresenterToInteractorWalletHomeProtocol = WalletHomeInteractor()
        let router: PresenterToRouterWalletHomeProtocol = WalletHomeRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter

        return view
    }
    
    func presentCurrencySelection(on vc: WalletHomeController, for direction: CurrencySelectionController.TransferDirection) {
        let currencyVC = CurrencySelectionRouter.createModule(delegate: vc, with: direction)
        currencyVC.modalPresentationStyle = .pageSheet

        vc.present(currencyVC, animated: true, completion: nil)
    }

    func pushSearchController(on vc: WalletHomeController) {
        let searchVC = WalletSearchRouter.createModule()
        vc.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    func presentScanViewController(_ navigationController: UINavigationController?) {
        let vc = QRScannerRouter.createModule()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.present(vc, animated: true)
    }
    
    func pushSendController(on vc: WalletHomeController, for asset: WalletAssetRow) {
        let sendVC = WalletSendRouter.createModule(defaultAsset: asset)
        vc.navigationController?.pushViewController(sendVC, animated: true)
    }
}
