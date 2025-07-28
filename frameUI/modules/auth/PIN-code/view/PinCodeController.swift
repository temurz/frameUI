//
//  PinCodeController.swift
//  Tedr
//
//  Created by Kostya Lee on 09/05/25.
//

import Foundation
import UIKit
class PinCodeController: TemplateController {
    var presenter: ViewToPresenterPinCodeProtocol?
    var mainView: PinCodeView?
    
    override func initialize() {
        self.view.backgroundColor = Theme().backgroundColor
        
        mainView = PinCodeView()
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

extension PinCodeController: PresenterToViewPinCodeProtocol, PinCodeViewDelegate {
    func didEnterPin(_ pin: String) {
        presenter?.submitPin(pin)
    }
    
    func didTapBack() {
        presenter?.goBack(navigationController: navigationController)
    }
}
