//
//  WelcomeViewController.swift
//  Tedr
//
//  Created by Temur on 09/05/2025.
//  
//

import UIKit

class WelcomeViewController: TemplateController {
    var mainView: WelcomeView?

    // MARK: - Lifecycle Methods
    override func initialize() {
        self.view.backgroundColor = Theme().backgroundPrimaryColor
        mainView = WelcomeView()
        mainView?.delegate = self
        self.view.addSubview(mainView)
    }
    
    override func updateSubviewsFrames(_ size: CGSize) {
        self.mainView?.frame = self.view.bounds
    }
    
    

    // MARK: - Properties
    var presenter: ViewToPresenterWelcomeProtocol?
    
}

extension WelcomeViewController: WelcomeViewDelegate {
    func backAction() {
        presenter?.backAction(navigationController: navigationController)
    }
    
    func signUp() {
        presenter?.signUp(navigationController: navigationController)
    }
    
    func signIn() {
        presenter?.signIn(navigationController: navigationController)
    }
}

extension WelcomeViewController: PresenterToViewWelcomeProtocol {
    
}
