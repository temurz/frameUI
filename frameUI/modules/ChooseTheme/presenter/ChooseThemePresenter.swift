//
//  ChooseThemePresenter.swift
//  Tedr
//
//  Created by Temur on 26/07/2025.
//  
//

import Foundation

class ChooseThemePresenter: ViewToPresenterChooseThemeProtocol {

    // MARK: Properties
    var view: PresenterToViewChooseThemeProtocol?
    var interactor: PresenterToInteractorChooseThemeProtocol?
    var router: PresenterToRouterChooseThemeProtocol?
}

extension ChooseThemePresenter: InteractorToPresenterChooseThemeProtocol {
    
}
