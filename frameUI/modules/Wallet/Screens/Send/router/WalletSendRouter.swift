//
//  WalletSendRouter.swift
//  Tedr
//
//  Created by Kostya Lee on 29/05/25.
//

import Foundation
import UIKit
class WalletSendRouter: PresenterToRouterWalletSendProtocol {
    static func createModule(defaultAsset: WalletAssetRow) -> WalletSendController {
        let view = WalletSendController(asset: defaultAsset)
        let presenter: ViewToPresenterWalletSendProtocol & InteractorToPresenterWalletSendProtocol = WalletSendPresenter(asset: defaultAsset)
        let interactor: PresenterToInteractorWalletSendProtocol = WalletSendInteractor()
        let router: PresenterToRouterWalletSendProtocol = WalletSendRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter

        return view
    }

    func navigateBack(navigationController: UINavigationController?) {
        navigationController?.popViewController(animated: true)
    }
    
    func presentCurrencySelection(_ vc: WalletSendController) {
        let currencyVC = CurrencySelectionRouter.createModule(delegate: vc, with: .send)
        currencyVC.modalPresentationStyle = .pageSheet
        vc.present(currencyVC, animated: true, completion: nil)
    }
    
    func presentScanViewController(_ vc: WalletSendController) {
        let scannerVC = QRScannerRouter.createModule()
        scannerVC.modalPresentationStyle = .fullScreen
        vc.present(scannerVC, animated: true)
    }
    
    func presentTransactionDetails(_ vc: WalletSendController, transaction: TransactionDetails) {
        let transactionDetailsVC = TransactionDetailsRouter.createModule(
            title: Strings.transactionDetails,
            details: transaction,
            completion: {}
        )
        transactionDetailsVC.modalPresentationStyle = .formSheet
        vc.present(transactionDetailsVC, animated: true)
    }
}
