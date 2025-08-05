//
//  SettingsAdminProtocols.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 30/07/25.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewSettingsAdminProtocol {
   
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterSettingsAdminProtocol {
    
    var view: PresenterToViewSettingsAdminProtocol? { get set }
    var interactor: PresenterToInteractorSettingsAdminProtocol? { get set }
    var router: PresenterToRouterSettingsAdminProtocol? { get set }
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorSettingsAdminProtocol {
    
    var presenter: InteractorToPresenterSettingsAdminProtocol? { get set }
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterSettingsAdminProtocol {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterSettingsAdminProtocol {
    
}
