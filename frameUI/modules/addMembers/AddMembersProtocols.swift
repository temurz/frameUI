//
//  AddMembersProtocols.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 11/08/25.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewAddMembersProtocol {
   
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterAddMembersProtocol {
    
    var view: PresenterToViewAddMembersProtocol? { get set }
    var interactor: PresenterToInteractorAddMembersProtocol? { get set }
    var router: PresenterToRouterAddMembersProtocol? { get set }
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorAddMembersProtocol {
    
    var presenter: InteractorToPresenterAddMembersProtocol? { get set }
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterAddMembersProtocol {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterAddMembersProtocol {
    
}
