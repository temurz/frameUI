//
//  AddMembersRouter.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 11/08/25.
//  
//

import Foundation
import UIKit

class AddMembersRouter: PresenterToRouterAddMembersProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = AddMembersViewController()
        
        let presenter: ViewToPresenterAddMembersProtocol & InteractorToPresenterAddMembersProtocol = AddMembersPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = AddMembersRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = AddMembersInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
}
