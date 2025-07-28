//
//  CurrencySelectionRouter.swift
//  Tedr
//
//  Created by Kostya Lee on 17/05/25.
//

import Foundation
import UIKit

protocol CurrencySelectionDelegate: AnyObject {
    func currencySelected(_ asset: WalletAssetRow)
}

class CurrencySelectionRouter: PresenterToRouterCurrencySelectionProtocol {
    static func createModule(delegate: CurrencySelectionDelegate, with direction: CurrencySelectionController.TransferDirection) -> UIViewController {
        let view = CurrencySelectionController(direction: direction)
        let presenter: ViewToPresenterCurrencySelectionProtocol & InteractorToPresenterCurrencySelectionProtocol = CurrencySelectionPresenter()
        let interactor: PresenterToInteractorCurrencySelectionProtocol = CurrencySelectionInteractor()
        let router: PresenterToRouterCurrencySelectionProtocol = CurrencySelectionRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        presenter.selectionDelegate = delegate

        (presenter as? CurrencySelectionPresenter)?.attachClosures(to: view)
        
        return UINavigationController(rootViewController: view)
    }
    
    func pushWalletReceiveController(on vc: CurrencySelectionController, asset: WalletAssetRow) {
        let receiveVC = WalletReceiveRouter.createModule(asset: asset)
        vc.navigationController?.pushViewController(receiveVC, animated: true)
    }
}
