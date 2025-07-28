//
//  RegistrationTypeRouter.swift
//  Tedr
//
//  Created by Temur on 09/05/2025.
//

import Foundation
import UIKit
class RegistrationTypeRouter: RegistrationTypeRouterProtocol {
    static func createModule() -> RegistrationTypeViewController {
        let view = RegistrationTypeViewController()
        
        let presenter: RegistrationTypeViewToPresenterProtocol & RegistrationTypeInteractorToPresenterProtocol = RegistrationTypePresenter()
        let interactor: RegistrationTypePresenterToInteractorProtocol = RegistrationTypeInteractor()
        let router: RegistrationTypeRouterProtocol = RegistrationTypeRouter()
        
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
    
    func individualUserAction(navigationController: UINavigationController?) {
        let vc = WelcomeRouter.createModule()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func businessUserAction(navigationController: UINavigationController?) {
        let vc = WelcomeRouter.createModule()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func signIn(navigationController: UINavigationController?) {
        
    }
}
