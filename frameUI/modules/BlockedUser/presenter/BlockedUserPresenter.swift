//
//  BlockedUserPresenter.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 16/08/25.
//  
//

import Foundation

class BlockedUserPresenter: ViewToPresenterBlockedUserProtocol {

    // MARK: Properties
    var view: PresenterToViewBlockedUserProtocol?
    var interactor: PresenterToInteractorBlockedUserProtocol?
    var router: PresenterToRouterBlockedUserProtocol?
}

extension BlockedUserPresenter: InteractorToPresenterBlockedUserProtocol {
    
}
