//
//  WelcomePresenter.swift
//  Tedr
//
//  Created by Temur on 09/05/2025.
//  
//

import UIKit

class WelcomePresenter: ViewToPresenterWelcomeProtocol {

    // MARK: Properties
    var view: PresenterToViewWelcomeProtocol?
    var interactor: PresenterToInteractorWelcomeProtocol?
    var router: PresenterToRouterWelcomeProtocol?
    
    func backAction(navigationController: UINavigationController?) {
        router?.backAction(navigationControler: navigationController)
    }
    
    func signUp(navigationController: UINavigationController?) {
        router?.signUp(navigationControler: navigationController)
    }
    
    func signIn(navigationController: UINavigationController?) {
        router?.signIn(navigationControler: navigationController)
    }
}

extension WelcomePresenter: InteractorToPresenterWelcomeProtocol {
    
}
