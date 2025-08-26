//
//  SettingsAdministratorsProtocols.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 24/08/25.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewSettingsAdministratorsProtocol {
   
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterSettingsAdministratorsProtocol {
    
    var view: PresenterToViewSettingsAdministratorsProtocol? { get set }
    var interactor: PresenterToInteractorSettingsAdministratorsProtocol? { get set }
    var router: PresenterToRouterSettingsAdministratorsProtocol? { get set }
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorSettingsAdministratorsProtocol {
    
    var presenter: InteractorToPresenterSettingsAdministratorsProtocol? { get set }
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterSettingsAdministratorsProtocol {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterSettingsAdministratorsProtocol {
    
}
