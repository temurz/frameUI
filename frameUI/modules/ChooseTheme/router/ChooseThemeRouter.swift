//
//  ChooseThemeRouter.swift
//  Tedr
//
//  Created by Temur on 26/07/2025.
//  
//

import Foundation
import UIKit

class ChooseThemeRouter: PresenterToRouterChooseThemeProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = ChooseThemeViewController()
        
        let presenter: ViewToPresenterChooseThemeProtocol & InteractorToPresenterChooseThemeProtocol = ChooseThemePresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = ChooseThemeRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = ChooseThemeInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
}
