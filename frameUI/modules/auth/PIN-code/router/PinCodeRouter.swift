//
//  PinCodeRouter.swift
//  Tedr
//
//  Created by Kostya Lee on 09/05/25.
//

import Foundation
import UIKit
class PinCodeRouter: PresenterToRouterPinCodeProtocol {
    static func createModule() -> PinCodeController {
        let view = PinCodeController()
        let presenter = PinCodePresenter()
        let interactor = PinCodeInteractor()
        let router = PinCodeRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    func popToPrevious(navigationController: UINavigationController?) {
        navigationController?.popViewController(animated: true)
    }
}

