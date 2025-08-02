//
//  SettingsAdminRouter.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 30/07/25.
//  
//

import Foundation
import UIKit

class SettingsAdminRouter: PresenterToRouterSettingsAdminProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = SettingsAdminViewController()
        
        let presenter: ViewToPresenterSettingsAdminProtocol & InteractorToPresenterSettingsAdminProtocol = SettingsAdminPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = SettingsAdminRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = SettingsAdminInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
}
