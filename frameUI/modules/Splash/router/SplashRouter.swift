//
//  SplashRouter.swift
//  Tedr
//
//  Created by GK on 11/03/25.
//
import Foundation
import UIKit
class SplashRouter: PresenterToRouterSplashProtocol {
    static func createModule() -> SplashController {
        let view = SplashController()
        let presenter: ViewToPresenterSplashProtocol & InteractorToPresenterSplashProtocol = SplashPresenter()
        let interactor: PresenterToInteractorSplashProtocol = SplashInteractor()
        let router: PresenterToRouterSplashProtocol = SplashRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    func pushToMain(navigationController: UINavigationController?) {
        let vc = RegistrationTypeRouter.createModule()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushToSignIn(navigationController: UINavigationController?) {
        
    }
}
