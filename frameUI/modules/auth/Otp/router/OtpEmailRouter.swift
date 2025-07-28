//
//  OtpEmailRouter.swift
//  Tedr
//
//  Created by Kostya Lee on 09/05/25.
//

import Foundation
import UIKit
class OtpEmailRouter: PresenterToRouterOtpEmailProtocol {
    static func createModule() -> OtpEmailController {
        let view = OtpEmailController()
        let presenter: ViewToPresenterOtpEmailProtocol & InteractorToPresenterOtpEmailProtocol = OtpEmailPresenter()
        let interactor: PresenterToInteractorOtpEmailProtocol = OtpEmailInteractor()
        let router: PresenterToRouterOtpEmailProtocol = OtpEmailRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    func popViewController(navigationController: UINavigationController?) {
        navigationController?.popViewController(animated: true)
    }
    
    func navigateToNextScreen(navigationController: UINavigationController?) {
    }
}
