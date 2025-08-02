//
//  SettingsAdminPresenter.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 30/07/25.
//  
//

import Foundation

class SettingsAdminPresenter: ViewToPresenterSettingsAdminProtocol {

    // MARK: Properties
    var view: PresenterToViewSettingsAdminProtocol?
    var interactor: PresenterToInteractorSettingsAdminProtocol?
    var router: PresenterToRouterSettingsAdminProtocol?
}

extension SettingsAdminPresenter: InteractorToPresenterSettingsAdminProtocol {
    
}
