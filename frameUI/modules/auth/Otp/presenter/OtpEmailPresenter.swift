//
//  OtpEmailPresenter.swift
//  Tedr
//
//  Created by Kostya Lee on 09/05/25.
//

import Foundation
import UIKit
class OtpEmailPresenter: ViewToPresenterOtpEmailProtocol {
    weak var view: PresenterToViewOtpEmailProtocol?
    var interactor: PresenterToInteractorOtpEmailProtocol?
    var router: PresenterToRouterOtpEmailProtocol?
    
    func getOtpEmailData() {
        interactor?.getOtpEmailData()
    }
    
    func verifyCode(code: String) {
        interactor?.verifyCode(code: code)
    }
    
    func resendCode() {
        interactor?.resendCode()
    }
}

extension OtpEmailPresenter: InteractorToPresenterOtpEmailProtocol {
    func show(values: OtpEmailEntity) {
        view?.show(values: values)
    }
    
    func otpEmailVerificationSuccess() {
        // Handle successful verification
    }
    
    func otpEmailVerificationFailed(error: String) {
        // Handle failed verification
    }
    
    func otpEmailResendSuccess() {
        // Handle successful resend
    }
}
