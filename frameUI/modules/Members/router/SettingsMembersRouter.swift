//
//  SettingsMembersRouter.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 10/08/25.
//  
//

import Foundation
import UIKit

class SettingsMembersRouter: PresenterToRouterSettingsMembersProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = SettingsMembersViewController()
        
        let presenter: ViewToPresenterSettingsMembersProtocol & InteractorToPresenterSettingsMembersProtocol = SettingsMembersPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = SettingsMembersRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = SettingsMembersInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
}
