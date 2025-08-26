//
//  SettingsAdministratorsRouter.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 24/08/25.
//  
//

import Foundation
import UIKit

class SettingsAdministratorsRouter: PresenterToRouterSettingsAdministratorsProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = SettingsAdministratorsViewController()
        
        let presenter: ViewToPresenterSettingsAdministratorsProtocol & InteractorToPresenterSettingsAdministratorsProtocol = SettingsAdministratorsPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = SettingsAdministratorsRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = SettingsAdministratorsInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
}
