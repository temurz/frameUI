//
//  InviteRouter.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 04/08/25.
//  
//

import Foundation
import UIKit

class InviteRouter: PresenterToRouterInviteProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = InviteViewController()
        
        let presenter: ViewToPresenterInviteProtocol & InteractorToPresenterInviteProtocol = InvitePresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = InviteRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = InviteInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
}
