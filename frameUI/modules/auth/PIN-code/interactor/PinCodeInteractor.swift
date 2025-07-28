//
//  PinCodeInteractor.swift
//  Tedr
//
//  Created by Kostya Lee on 09/05/25.
//

import Foundation
import UIKit
class PinCodeInteractor: PresenterToInteractorPinCodeProtocol {
    weak var presenter: InteractorToPresenterPinCodeProtocol?
    
    func validatePin(_ pin: String) {
        let isValid = (pin == "12345")
        presenter?.didValidatePin(success: isValid)
    }
}

