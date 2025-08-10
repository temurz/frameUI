//
//  AddMembersPresenter.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 11/08/25.
//  
//

import Foundation

class AddMembersPresenter: ViewToPresenterAddMembersProtocol {

    // MARK: Properties
    var view: PresenterToViewAddMembersProtocol?
    var interactor: PresenterToInteractorAddMembersProtocol?
    var router: PresenterToRouterAddMembersProtocol?
}

extension AddMembersPresenter: InteractorToPresenterAddMembersProtocol {
    
}
