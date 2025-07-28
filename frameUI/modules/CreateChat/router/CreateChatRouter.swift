//
//  CreateChatRouter.swift
//  Tedr
//
//  Created by Temur on 09/07/2025.
//  
//

import Foundation
import UIKit

class CreateChatRouter: PresenterToRouterCreateChatProtocol {
    
    // MARK: Static methods
    static func createModule(delegate: CreateChatModalViewDelegate) -> UIViewController {
        
        let viewController = CreateChatViewController()
        
        let presenter: ViewToPresenterCreateChatProtocol & InteractorToPresenterCreateChatProtocol = CreateChatPresenter()
        
        
        viewController.presenter = presenter
        viewController.presenter?.router = CreateChatRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = CreateChatInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        viewController.presenter?.delegate = delegate
        
        return viewController
    }
    
}
