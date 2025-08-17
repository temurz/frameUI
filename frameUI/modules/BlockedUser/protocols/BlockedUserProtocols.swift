//
//  BlockedUserProtocols.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 16/08/25.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewBlockedUserProtocol {
   
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterBlockedUserProtocol {
    
    var view: PresenterToViewBlockedUserProtocol? { get set }
    var interactor: PresenterToInteractorBlockedUserProtocol? { get set }
    var router: PresenterToRouterBlockedUserProtocol? { get set }
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorBlockedUserProtocol {
    
    var presenter: InteractorToPresenterBlockedUserProtocol? { get set }
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterBlockedUserProtocol {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterBlockedUserProtocol {
    
}
