//
//  EmptyBlockProtocols.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 16/08/25.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewEmptyBlockProtocol {
   
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterEmptyBlockProtocol {
    
    var view: PresenterToViewEmptyBlockProtocol? { get set }
    var interactor: PresenterToInteractorEmptyBlockProtocol? { get set }
    var router: PresenterToRouterEmptyBlockProtocol? { get set }
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorEmptyBlockProtocol {
    
    var presenter: InteractorToPresenterEmptyBlockProtocol? { get set }
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterEmptyBlockProtocol {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterEmptyBlockProtocol {
    
}
