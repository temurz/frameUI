//
//  CreateAccountView.swift
//  Tedr
//
//  Created by Temur on 09/05/2025.
//  
//

import UIKit

protocol CreateAccountViewDelegate: AnyObject {
    func backAction()
    func continueAction()
}

class CreateAccountView: TemplateView {

    let backButton = UIButton()
    let titleLabel = UILabel()
    let emailField = AuthTextField()
    let passwordField = AuthTextField()
    let repeatPasswordField = AuthTextField()
    let passwordRules = PasswordRulesStackView()
    let termsButton = UIButton(type: .custom)
    let termsLabel = UILabel()
    let continueButton = GradientSelectableButton(title: "Continue", style: .filled(UIColor(white: 1, alpha: 0.1)))
    
    var isCheckboxSelected: Bool = false
    
    weak var delegate: CreateAccountViewDelegate?
    
    let rules: [PasswordRequirementView] = [
        PasswordRequirementView(text: "From 8 to 64 characters"),
        PasswordRequirementView(text: "Uppercase letter (A–Z)"),
        PasswordRequirementView(text: "Lowercase letter (a–z)"),
        PasswordRequirementView(text: "Number (0–9)"),
        PasswordRequirementView(text: "Special symbol (!,?,&...)")
    ]

    override func initialize() {
        let theme = theme ?? Theme()

        backButton.setImage(theme.arrowLeftLIcon, for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        addSubview(backButton)

        titleLabel.text = "Create an account"
        titleLabel.font = theme.getFont(size: 20, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        addSubview(titleLabel)

        emailField.configure(title: "Email", placeholder: "Enter email", keyboardType: .emailAddress)
        emailField.textField.delegate = self
        addSubview(emailField)

        passwordField.configure(title: "Password", placeholder: "Enter password", showsEye: true, isSecure: true)
        passwordField.textField.delegate = self
        addSubview(passwordField)

        repeatPasswordField.configure(title: "Repeat password", placeholder: "Enter password", showsEye: true, isSecure: true)
        repeatPasswordField.textField.delegate = self
        addSubview(repeatPasswordField)

        rules.forEach { addSubview($0) }

        termsButton.setImage(theme.emptyCheckbox, for: .normal)
        termsButton.addTarget(self, action: #selector(selectCheckbox), for: .touchUpInside)
        addSubview(termsButton)

        termsLabel.text = "Terms & Conditions"
        termsLabel.font = theme.getFont(size: 14, weight: .regular)
        termsLabel.textColor = .systemBlue
        addSubview(termsLabel)

        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        addSubview(continueButton)

        // Bind textfield to validation updates
        passwordField.textField.addTarget(self, action: #selector(passwordChanged), for: .editingChanged)
    }

    @objc private func passwordChanged() {
        let text = passwordField.textField.text ?? ""
        updateValidationStates(for: text)
    }

    override func updateSubviewsFrame(_ size: CGSize) {
        let padding: CGFloat = 16
        let width = size.width
        let contentWidth = width - padding * 2
        let textFieldHeight: CGFloat = 74

        var x = padding
        var y = safeAreaInsets.top + 16
        var w = CGFloat(24)
        var h = w
        backButton.frame = CGRect(x: x, y: y, width: w, height: h)

        y = backButton.frame.maxY + 16
        w = contentWidth
        h = 28
        x = padding
        titleLabel.frame = CGRect(x: x, y: y, width: w, height: h)

        y = titleLabel.frame.maxY + 24
        h = textFieldHeight
        emailField.frame = CGRect(x: x, y: y, width: w, height: h)

        y = emailField.frame.maxY + 16
        passwordField.frame = CGRect(x: x, y: y, width: w, height: h)

        y = passwordField.frame.maxY + 16
        for i in rules.indices {
            rules[i].frame = .init(x: x, y: y, width: w, height: 24)
            y += 24
        }

        y = (rules.last?.frame.maxY ?? 100) + 16
        h = textFieldHeight
        repeatPasswordField.frame = CGRect(x: x, y: y, width: w, height: h)

        h = 56
        y = size.height - safeAreaInsets.bottom - padding - h
        continueButton.frame = CGRect(x: x, y: y, width: w, height: h)
        
        h = 24
        y = continueButton.minY - h - 16
        w = termsLabel.text?.width(termsLabel.font) ?? 100
        termsLabel.frame = CGRect(x: width/2 - w/2, y: y, width: 200, height: 24)
        
        w = 24
        x = termsLabel.minX - w - 10
        termsButton.frame = CGRect(x: x, y: y + 2, width: 20, height: 20)
    }
    
    func updateValidationStates(for password: String) {
        rules[0].isValid = password.count >= 8 && password.count <= 64
        rules[1].isValid = password.range(of: "[A-Z]", options: .regularExpression) != nil
        rules[2].isValid = password.range(of: "[a-z]", options: .regularExpression) != nil
        rules[3].isValid = password.range(of: "[0-9]", options: .regularExpression) != nil
        rules[4].isValid = password.range(of: "[!@#$%^&*(),.?:{}|<>]", options: .regularExpression) != nil
    }
    
    @objc private func selectCheckbox() {
        isCheckboxSelected.toggle()
        termsButton.setImage(isCheckboxSelected ? Theme().selectedCheckbox : Theme().emptyCheckbox, for: .normal)
    }
    
    @objc private func backButtonTapped() {
        delegate?.backAction()
    }
    
    @objc private func continueButtonTapped() {
        delegate?.continueAction()
    }
    
    private func validateTextFields() {
        guard
            isCheckboxSelected,
            rules.filter({ !$0.isValid }).count == 0,
            !(emailField.textField.text?.isEmpty ?? true),
            repeatPasswordField.textField.text == passwordField.textField.text
        else {
            
            return
        }
    }
}

extension CreateAccountView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        validateTextFields()
    }
}

import SwiftUI
@available(iOS 17.0, *)
#Preview("AuthView") {
    let vc = CreateAccountRouter.createModule()
    return vc
}
