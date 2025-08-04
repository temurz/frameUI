//
//  InvitePresenter.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 04/08/25.
//  
//

import Foundation

class InvitePresenter: ViewToPresenterInviteProtocol {

    // MARK: Properties
    var view: PresenterToViewInviteProtocol?
    var interactor: PresenterToInteractorInviteProtocol?
    var router: PresenterToRouterInviteProtocol?
}

extension InvitePresenter: InteractorToPresenterInviteProtocol {
    
}
