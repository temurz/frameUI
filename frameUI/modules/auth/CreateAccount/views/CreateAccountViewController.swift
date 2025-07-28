//
//  CreateAccountViewController.swift
//  Tedr
//
//  Created by Temur on 09/05/2025.
//  
//

import UIKit

class CreateAccountViewController: TemplateController {
    var mainView: CreateAccountView?

    // MARK: - Lifecycle Methods
    override func initialize() {
        self.view.backgroundColor = Theme().backgroundPrimaryColor
        mainView = CreateAccountView()
        mainView?.delegate = self
        self.view.addSubview(mainView)
    }
    
    override func updateSubviewsFrames(_ size: CGSize) {
        self.mainView?.frame = self.view.bounds
    }
    
    

    // MARK: - Properties
    var presenter: ViewToPresenterCreateAccountProtocol?
    
}

extension CreateAccountViewController: PresenterToViewCreateAccountProtocol {
    // TODO: Implement View Output Methods
}

extension CreateAccountViewController: CreateAccountViewDelegate {
    func backAction() {
        presenter?.backAction(navigationController: navigationController)
    }
    
    func continueAction() {
        presenter?.continueAction(navigationController: navigationController)
    }
}
