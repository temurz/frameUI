//
//  OtpEmailProtocols.swift
//  Tedr
//
//  Created by Kostya Lee on 09/05/25.
//

import Foundation
import UIKit
protocol ViewToPresenterOtpEmailProtocol: AnyObject {
    var view: PresenterToViewOtpEmailProtocol? {get set}
    var interactor: PresenterToInteractorOtpEmailProtocol? {get set}
    var router: PresenterToRouterOtpEmailProtocol? {get set}
    
    func getOtpEmailData()
    func verifyCode(code: String)
    func resendCode()
}

protocol PresenterToViewOtpEmailProtocol: AnyObject {
    func show(values: OtpEmailEntity)
}

protocol PresenterToRouterOtpEmailProtocol: AnyObject {
    static func createModule() -> OtpEmailController
    func popViewController(navigationController: UINavigationController?)
    func navigateToNextScreen(navigationController: UINavigationController?)
}

protocol PresenterToInteractorOtpEmailProtocol: AnyObject {
    var presenter: InteractorToPresenterOtpEmailProtocol? {get set}
    
    func getOtpEmailData()
    func verifyCode(code: String)
    func resendCode()
}

protocol InteractorToPresenterOtpEmailProtocol: AnyObject {
    func show(values: OtpEmailEntity)
    func otpEmailVerificationSuccess()
    func otpEmailVerificationFailed(error: String)
    func otpEmailResendSuccess()
}
