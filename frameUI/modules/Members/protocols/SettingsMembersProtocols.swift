//
//  SettingsMembersProtocols.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 10/08/25.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewSettingsMembersProtocol {
   
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterSettingsMembersProtocol {
    
    var view: PresenterToViewSettingsMembersProtocol? { get set }
    var interactor: PresenterToInteractorSettingsMembersProtocol? { get set }
    var router: PresenterToRouterSettingsMembersProtocol? { get set }
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorSettingsMembersProtocol {
    
    var presenter: InteractorToPresenterSettingsMembersProtocol? { get set }
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterSettingsMembersProtocol {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterSettingsMembersProtocol {
    
}
