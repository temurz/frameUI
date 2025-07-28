//
//  RegistrationTypeViewController.swift
//  Tedr
//
//  Created by Temur on 09/05/2025.
//

import UIKit

class RegistrationTypeViewController: TemplateController, RegistrationTypeViewControllerProtocol {
    var presenter: RegistrationTypeViewToPresenterProtocol?
    var mainView: RegistrationTypeView?
    
    override func initialize() {
        self.view.backgroundColor = Theme().backgroundPrimaryColor
        
        mainView = RegistrationTypeView()
        mainView?.delegate = self
        self.view.addSubview(mainView)
    }
    
    override func updateSubviewsFrames(_ size: CGSize) {
        self.mainView?.frame = self.view.bounds
    }
    
    override func reloadContent() {
        mainView?.theme = theme
    }
}

extension RegistrationTypeViewController: RegistrationTypeViewDelegate {
    func backAction() {
        presenter?.backAction(navigationController: navigationController)
    }
    
    func signIn() {
        
    }
    
    func individualUser() {
        presenter?.individualUserAction(navigationController: navigationController)
    }
    
    func businessUser() {
        presenter?.businessUserAction(navigationController: navigationController)
    }
}
