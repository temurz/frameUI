//
//  EmptyBlockPresenter.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 16/08/25.
//  
//

import Foundation

class EmptyBlockPresenter: ViewToPresenterEmptyBlockProtocol {

    // MARK: Properties
    var view: PresenterToViewEmptyBlockProtocol?
    var interactor: PresenterToInteractorEmptyBlockProtocol?
    var router: PresenterToRouterEmptyBlockProtocol?
}

extension EmptyBlockPresenter: InteractorToPresenterEmptyBlockProtocol {
    
}
