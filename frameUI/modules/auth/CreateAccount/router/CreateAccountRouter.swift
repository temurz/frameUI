//
//  CreateAccountRouter.swift
//  Tedr
//
//  Created by Temur on 09/05/2025.
//  
//

import Foundation
import UIKit

class CreateAccountRouter: PresenterToRouterCreateAccountProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = CreateAccountViewController()
        
        let presenter: ViewToPresenterCreateAccountProtocol & InteractorToPresenterCreateAccountProtocol = CreateAccountPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = CreateAccountRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = CreateAccountInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
    func popViewController(navigationController: UINavigationController?) {
        navigationController?.popViewController(animated: true)
    }
    
    func continueAction(navigationController: UINavigationController?) {
        let vc = OtpEmailRouter.createModule()
        navigationController?.pushViewController(vc, animated: true)
    }
}
