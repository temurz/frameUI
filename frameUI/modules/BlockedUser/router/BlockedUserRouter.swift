//
//  BlockedUserRouter.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 16/08/25.
//  
//

import Foundation
import UIKit

class BlockedUserRouter: PresenterToRouterBlockedUserProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = BlockedUserViewController()
        
        let presenter: ViewToPresenterBlockedUserProtocol & InteractorToPresenterBlockedUserProtocol = BlockedUserPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = BlockedUserRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = BlockedUserInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
}
