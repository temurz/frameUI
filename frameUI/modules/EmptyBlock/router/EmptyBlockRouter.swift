//
//  EmptyBlockRouter.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 16/08/25.
//  
//

import Foundation
import UIKit

class EmptyBlockRouter: PresenterToRouterEmptyBlockProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = EmptyBlockViewController()
        
        let presenter: ViewToPresenterEmptyBlockProtocol & InteractorToPresenterEmptyBlockProtocol = EmptyBlockPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = EmptyBlockRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = EmptyBlockInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
}
