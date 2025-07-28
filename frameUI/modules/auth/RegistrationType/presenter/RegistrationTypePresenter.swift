//
//  RegistrationTypePresenter.swift
//  Tedr
//
//  Created by Temur on 09/05/2025.
//
import UIKit

class RegistrationTypePresenter: RegistrationTypeViewToPresenterProtocol, RegistrationTypeInteractorToPresenterProtocol {
    weak var view: RegistrationTypeViewControllerProtocol?
    
    var interactor: RegistrationTypePresenterToInteractorProtocol?
    
    var router: RegistrationTypeRouterProtocol?
    
    func backAction(navigationController: UINavigationController?) {
        router?.popViewController(navigationController: navigationController)
    }
    
    func individualUserAction(navigationController: UINavigationController?) {
        router?.individualUserAction(navigationController: navigationController)
    }
    
    func businessUserAction(navigationController: UINavigationController?) {
        router?.businessUserAction(navigationController: navigationController)
    }
    
    func signIn(navigationController: UINavigationController?) {
        
    }
}
