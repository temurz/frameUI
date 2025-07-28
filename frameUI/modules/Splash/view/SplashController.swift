//
//  SplashController.swift
//  Tedr
//
//  Created by GK on 11/03/25.
//

import Foundation
import UIKit
class SplashController: TemplateController {
    var presenter: ViewToPresenterSplashProtocol?
    var mainView: SplashView?
    
    override func initialize() {
        self.view.backgroundColor = Theme().backgroundColor
        
        mainView = SplashView()
        mainView?.delegate = self
        self.view.addSubview(mainView)
     
        presenter?.getScreens()
    }
    
    override func updateSubviewsFrames(_ size: CGSize) {
        self.mainView?.frame = self.view.bounds
    }
    
    override func reloadContent() {
        mainView?.theme = theme
    }
}

extension SplashController: PresenterToViewSplashProtocol, SplashViewDelegate {
    func show(values: [SplashEntity]) {
        mainView?.titleLbl?.text = values.first?.title
        mainView?.imgView?.image = values.first?.image
    }
    
    func signIn() {
        presenter?.router?.pushToSignIn(navigationController: navigationController)
    }
    
    func skipRegistration() {
        presenter?.router?.pushToMain(navigationController: navigationController)
    }
}
