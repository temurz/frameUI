//
//  OtpEmailInteractor.swift
//  Tedr
//
//  Created by Kostya Lee on 09/05/25.
//

import Foundation
import UIKit
class OtpEmailInteractor: PresenterToInteractorOtpEmailProtocol {
    var presenter: InteractorToPresenterOtpEmailProtocol?
    
    func getOtpEmailData() {
        let OtpEmailData = OtpEmailEntity(
            title: "Confirm email",
            subtitle: "6-digit code sent to your email",
            email: "de***@gmail.com",
            spamMessage: "Check your spam folder if you didn't receive it",
            timerDuration: 59
        )
        
        presenter?.show(values: OtpEmailData)
    }
    
    func verifyCode(code: String) {
        if code.count == 6 {
            presenter?.otpEmailVerificationSuccess()
        } else {
            presenter?.otpEmailVerificationFailed(error: Strings.Errors.invalidCode)
        }
    }
    
    func resendCode() {
        presenter?.otpEmailResendSuccess()
    }
}
