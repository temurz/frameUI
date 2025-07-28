//
//  WalletSearchRouter.swift
//  Tedr
//
//  Created by Kostya Lee on 23/05/25.
//

import UIKit

class WalletSearchRouter: PresenterToRouterWalletSearchProtocol {
    static func createModule() -> WalletSearchController {
        let view = WalletSearchController()
        let presenter: ViewToPresenterWalletSearchProtocol & InteractorToPresenterWalletSearchProtocol = WalletSearchPresenter()
        let interactor: PresenterToInteractorWalletSearchProtocol = WalletSearchInteractor()
        let router: PresenterToRouterWalletSearchProtocol = WalletSearchRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter

        return view
    }
    
    func showFilter(_ navigationController: UINavigationController?, delegate: FilterOptionsSheetViewDelegate?) {
        let view = OptionsSheetView()
        view.delegate = delegate
        let vc = BottomSheetRouter.makeSheet(with: view, title: "Options")
        navigationController?.present(vc, animated: true)
    }
}
