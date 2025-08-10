//
//  SettingsMembersPresenter.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 10/08/25.
//  
//

import Foundation

class SettingsMembersPresenter: ViewToPresenterSettingsMembersProtocol {

    // MARK: Properties
    var view: PresenterToViewSettingsMembersProtocol?
    var interactor: PresenterToInteractorSettingsMembersProtocol?
    var router: PresenterToRouterSettingsMembersProtocol?
}

extension SettingsMembersPresenter: InteractorToPresenterSettingsMembersProtocol {
    
}
