//
//  Splash.swift
//  Tedr
//
//  Created by GK on 11/03/25.
//

import Foundation
class SplashInteractor: PresenterToInteractorSplashProtocol {
    weak var presenter: InteractorToPresenterSplashProtocol?
    
    func getScreens() {
        presenter?.show(values: [SplashEntity(image: Theme().splashImage, title: translate("Buy & sell goods with Tedr"))])
    }
}
