//
//  WelcomeRouter.swift
//  Tedr
//
//  Created by Temur on 09/05/2025.
//  
//

import Foundation
import UIKit

class WelcomeRouter: PresenterToRouterWelcomeProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = WelcomeViewController()
        
        let presenter: ViewToPresenterWelcomeProtocol & InteractorToPresenterWelcomeProtocol = WelcomePresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = WelcomeRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = WelcomeInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
    func backAction(navigationControler: UINavigationController?) {
        navigationControler?.popViewController(animated: true)
    }
    
    func signUp(navigationControler: UINavigationController?) {
        let vc = CreateAccountRouter.createModule()
        navigationControler?.pushViewController(vc, animated: true)
    }
    
    func signIn(navigationControler: UINavigationController?) {
        
    }
}
