//
//  WelcomeProtocols.swift
//  Tedr
//
//  Created by Temur on 09/05/2025.
//  
//

import UIKit


// MARK: View Output (Presenter -> View)
protocol PresenterToViewWelcomeProtocol {
   
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterWelcomeProtocol {
    
    var view: PresenterToViewWelcomeProtocol? { get set }
    var interactor: PresenterToInteractorWelcomeProtocol? { get set }
    var router: PresenterToRouterWelcomeProtocol? { get set }
    
    func backAction(navigationController: UINavigationController?)
    func signUp(navigationController: UINavigationController?)
    func signIn(navigationController: UINavigationController?)
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorWelcomeProtocol {
    
    var presenter: InteractorToPresenterWelcomeProtocol? { get set }
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterWelcomeProtocol {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterWelcomeProtocol {
    func backAction(navigationControler: UINavigationController?)
    func signUp(navigationControler: UINavigationController?)
    func signIn(navigationControler: UINavigationController?)
}
