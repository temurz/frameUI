//
//  InviteProtocols.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 04/08/25.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewInviteProtocol {
   
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterInviteProtocol {
    
    var view: PresenterToViewInviteProtocol? { get set }
    var interactor: PresenterToInteractorInviteProtocol? { get set }
    var router: PresenterToRouterInviteProtocol? { get set }
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorInviteProtocol {
    
    var presenter: InteractorToPresenterInviteProtocol? { get set }
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterInviteProtocol {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterInviteProtocol {
    
}
