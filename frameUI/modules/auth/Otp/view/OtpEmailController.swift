//
//  OtpEmailController.swift
//  Tedr
//
//  Created by Kostya Lee on 09/05/25.
//

import Foundation
import UIKit
class OtpEmailController: TemplateController {
    var presenter: ViewToPresenterOtpEmailProtocol?
    var mainView: OtpEmailView?
    
    override func initialize() {
        self.view.backgroundColor = Theme().backgroundColor
        
        mainView = OtpEmailView()
        mainView?.delegate = self
        self.view.addSubview(mainView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        presenter?.getOtpEmailData()
        
        let OtpEmailData = OtpEmailEntity(
            title: "Confirm email",
            subtitle: "6-digit code sent to your email",
            email: "de***@gmail.com",
            spamMessage: "Check your spam folder if you didn't receive it",
            timerDuration: 59
        )
        
        self.show(values: OtpEmailData)
    }
    
    override func updateSubviewsFrames(_ size: CGSize) {
        self.mainView?.frame = self.view.bounds
    }
    
    override func reloadContent() {
        mainView?.theme = theme
    }
}

extension OtpEmailController: PresenterToViewOtpEmailProtocol, OtpEmailViewDelegate {
    func show(values: OtpEmailEntity) {
        mainView?.titleLbl?.text = values.title
        mainView?.subtitleLbl?.text = values.subtitle
        mainView?.emailLbl?.text = values.email
        mainView?.spamLbl?.text = values.spamMessage
        mainView?.startTimer(duration: values.timerDuration)
    }
    
    func verifyCode(code: String) {
        presenter?.verifyCode(code: code)
    }
    
    func backButtonTapped() {
        presenter?.router?.popViewController(navigationController: navigationController)
    }
    
    func resendCode() {
        presenter?.resendCode()
    }
}
