//
//  SplashPresenter.swift
//  Tedr
//
//  Created by GK on 11/03/25.
//

import Foundation
import UIKit
class SplashPresenter: ViewToPresenterSplashProtocol {
    weak var view: PresenterToViewSplashProtocol?
    
    var interactor: PresenterToInteractorSplashProtocol?
    
    var router: PresenterToRouterSplashProtocol?
    
    func getScreens() {
        interactor?.getScreens()
    }
    
    func signIn(navigationController: UINavigationController?) {
        router?.pushToSignIn(navigationController: navigationController)
    }
    
    func pushToMain(navigationController: UINavigationController?) {
        router?.pushToMain(navigationController: navigationController)
    }
}

extension SplashPresenter: InteractorToPresenterSplashProtocol {
    func show(values: [SplashEntity]) {
        view?.show(values: values)
    }
}
