//
//  CreateAccountProtocols.swift
//  Tedr
//
//  Created by Temur on 09/05/2025.
//  
//

import UIKit


// MARK: View Output (Presenter -> View)
protocol PresenterToViewCreateAccountProtocol {
   
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterCreateAccountProtocol {
    
    var view: PresenterToViewCreateAccountProtocol? { get set }
    var interactor: PresenterToInteractorCreateAccountProtocol? { get set }
    var router: PresenterToRouterCreateAccountProtocol? { get set }
    
    func backAction(navigationController: UINavigationController?)
    func continueAction(navigationController: UINavigationController?)
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorCreateAccountProtocol {
    
    var presenter: InteractorToPresenterCreateAccountProtocol? { get set }
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterCreateAccountProtocol {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterCreateAccountProtocol {
    func popViewController(navigationController: UINavigationController?) 
    func continueAction(navigationController: UINavigationController?) 
}
