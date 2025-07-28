//
//  WalletReceiveRouter.swift
//  Tedr
//
//  Created by Kostya Lee on 24/05/25.
//

import Foundation
class WalletReceiveRouter: PresenterToRouterWalletReceiveProtocol {
    static func createModule(asset: WalletAssetRow) -> WalletReceiveController {
        let view = WalletReceiveController(asset: asset)
        let presenter: ViewToPresenterWalletReceiveProtocol & InteractorToPresenterWalletReceiveProtocol = WalletReceivePresenter()
        let interactor: PresenterToInteractorWalletReceiveProtocol = WalletReceiveInteractor()
        let router: PresenterToRouterWalletReceiveProtocol = WalletReceiveRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter

        return view
    }
}
