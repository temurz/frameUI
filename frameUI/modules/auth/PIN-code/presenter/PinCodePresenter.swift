//
//  PinCodePresenter.swift
//  Tedr
//
//  Created by Kostya Lee on 09/05/25.
//

import Foundation
import UIKit
class PinCodePresenter: ViewToPresenterPinCodeProtocol {
    weak var view: PresenterToViewPinCodeProtocol?
    var router: PresenterToRouterPinCodeProtocol?
    var interactor: PresenterToInteractorPinCodeProtocol?
    
    func submitPin(_ pin: String) {
        interactor?.validatePin(pin)
    }
    
    func goBack(navigationController: UINavigationController?) {
        router?.popToPrevious(navigationController: navigationController)
    }
}

extension PinCodePresenter: InteractorToPresenterPinCodeProtocol {
    func didValidatePin(success: Bool) {
        print("PIN is \(success ? "valid" : "invalid")")
    }
}
