//
//  CreateAccountPresenter.swift
//  Tedr
//
//  Created by Temur on 09/05/2025.
//  
//

import UIKit

class CreateAccountPresenter: ViewToPresenterCreateAccountProtocol {

    // MARK: Properties
    var view: PresenterToViewCreateAccountProtocol?
    var interactor: PresenterToInteractorCreateAccountProtocol?
    var router: PresenterToRouterCreateAccountProtocol?
    
    func backAction(navigationController: UINavigationController?) {
        router?.popViewController(navigationController: navigationController)
    }
    
    func continueAction(navigationController: UINavigationController?) {
        router?.continueAction(navigationController: navigationController)
    }
}

extension CreateAccountPresenter: InteractorToPresenterCreateAccountProtocol {
    
}
