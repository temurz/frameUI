//
//  ChooseThemeProtocols.swift
//  Tedr
//
//  Created by Temur on 26/07/2025.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewChooseThemeProtocol {
   
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterChooseThemeProtocol {
    
    var view: PresenterToViewChooseThemeProtocol? { get set }
    var interactor: PresenterToInteractorChooseThemeProtocol? { get set }
    var router: PresenterToRouterChooseThemeProtocol? { get set }
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorChooseThemeProtocol {
    
    var presenter: InteractorToPresenterChooseThemeProtocol? { get set }
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterChooseThemeProtocol {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterChooseThemeProtocol {
    
}
