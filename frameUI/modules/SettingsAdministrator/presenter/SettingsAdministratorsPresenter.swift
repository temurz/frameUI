//
//  SettingsAdministratorsPresenter.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 24/08/25.
//  
//

import Foundation

class SettingsAdministratorsPresenter: ViewToPresenterSettingsAdministratorsProtocol {

    // MARK: Properties
    var view: PresenterToViewSettingsAdministratorsProtocol?
    var interactor: PresenterToInteractorSettingsAdministratorsProtocol?
    var router: PresenterToRouterSettingsAdministratorsProtocol?
}

extension SettingsAdministratorsPresenter: InteractorToPresenterSettingsAdministratorsProtocol {
    
}
