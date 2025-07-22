//
//  ViewController.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 10/07/25.
//

import UIKit

final class CreateAccountViewController: UIViewController {
    
    // MARK: - UI Elements
    private let backButton = UIButton(type: .system)
    private let titleLabel = UILabel()
    
    private let emailLabel = UILabel()
    private let emailTextField = UITextField()
    
    private let passwordLabel = UILabel()
    private let passwordTextField = UITextField()
    private let togglePasswordButton = UIButton(type: .system)
    
    private let requirementViews: [(UIImageView, UILabel)] = (0..<5).map { _ in (UIImageView(), UILabel()) }
    private let requirements = ["From 8 to 64 characters", "Uppercase letter (A-Z)", "Lowercase letter (a-z)", "Number (0-9)", "Special symbol (!,?,&...)"]
    
    private let repeatPasswordLabel = UILabel()
    private let repeatPasswordTextField = UITextField()
    private let repeatPasswordHelperLabel = UILabel()
    private let toggleRepeatButton = UIButton(type: .system)
    
    private let termsCheckbox = UIButton(type: .system)
    private let termsLabel = UILabel()
    private let continueButton = UIButton(type: .system)
    
    private var areTermsAccepted = false
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#3F135C")
        setupUI()
        setupTargets()
        updateContinueButtonState()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        setupNavigation()
        setupEmailSection()
        setupPasswordSection()
        setupRequirements()
        setupRepeatPasswordSection()
        setupTermsSection()
        setupContinueButton()
    }
    
    private func setupNavigation() {
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .white
        view.addSubview(backButton)
        
        titleLabel.text = "Create an account"
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
    }
    
    private func setupEmailSection() {
        setupLabel(emailLabel, "Email")
        setupTextField(emailTextField, "Enter email", .emailAddress)
    }
    
    private func setupPasswordSection() {
        setupLabel(passwordLabel, "Password")
        setupTextField(passwordTextField, "Enter password", .default, isSecure: true)
        setupToggleButton(togglePasswordButton, for: passwordTextField)
    }
    
    private func setupRequirements() {
        zip(requirementViews, requirements).forEach { view, text in
            setupRequirement(view, text)
        }
    }
    
    private func setupRepeatPasswordSection() {
        setupLabel(repeatPasswordLabel, "Repeat password")
        setupTextField(repeatPasswordTextField, "Enter password", .default, isSecure: true)
        setupHelper(repeatPasswordHelperLabel)
        setupToggleButton(toggleRepeatButton, for: repeatPasswordTextField)
    }
    
    private func setupTermsSection() {
        termsCheckbox.setImage(UIImage(systemName: "square"), for: .normal)
        termsCheckbox.tintColor = .lightGray
        view.addSubview(termsCheckbox)

        termsLabel.text = "Terms & Conditions"
        termsLabel.font = .systemFont(ofSize: 20)
        termsLabel.textColor = UIColor(hex: "#3B72F2")
        view.addSubview(termsLabel)
    }
    
    private func setupContinueButton() {
        continueButton.setTitle("Continue", for: .normal)
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        continueButton.layer.cornerRadius = 12
        view.addSubview(continueButton)
    }
    
    // MARK: - Layout
    private func layoutUI() {
        let padding: CGFloat = 20
        let fieldH: CGFloat = 50
        let labelH: CGFloat = 20
        let helperH: CGFloat = 16
        let spacing: CGFloat = 10
        let width = view.bounds.width - (padding * 2)
        
        var y: CGFloat = view.safeAreaInsets.top + 10
        
        backButton.frame = CGRect(x: padding, y: y, width: 44, height: 44)
        titleLabel.frame = CGRect(x: padding, y: y, width: width, height: 44)
        y += 54
        
        let elements: [(UIView, CGFloat)] = [
            (emailLabel, labelH), (emailTextField, fieldH),
            (passwordLabel, labelH), (passwordTextField, fieldH)
        ]
        
        elements.forEach { element, height in
            element.frame = CGRect(x: padding, y: y, width: width, height: height)
            y += height + spacing
        }
        
        requirementViews.forEach { icon, label in
            icon.frame = CGRect(x: padding, y: y, width: 20, height: 20)
            label.frame = CGRect(x: padding + 28, y: y, width: width - 28, height: 20)
            y += 28
        }
        
        [(repeatPasswordLabel, labelH), (repeatPasswordTextField, fieldH), (repeatPasswordHelperLabel, helperH)].forEach { element, height in
            element.frame = CGRect(x: padding, y: y, width: width, height: height)
            y += height + spacing
        }
        
        continueButton.frame = CGRect(
            x: padding,
            y: view.bounds.height - view.safeAreaInsets.bottom - fieldH - padding,
            width: width,
            height: fieldH
        )

        
        termsLabel.sizeToFit()
        let checkboxSize: CGFloat = termsLabel.frame.height
        let spacingAboveContinue: CGFloat = 12
        let totalWidth = checkboxSize + 6 + termsLabel.frame.width
        let xStart = (view.bounds.width - totalWidth) / 2
        let termsY = continueButton.frame.minY - spacingAboveContinue - checkboxSize

        termsCheckbox.frame = CGRect(x: xStart, y: termsY, width: checkboxSize, height: checkboxSize)
        termsLabel.frame = CGRect(x: termsCheckbox.frame.maxX + 6, y: termsY, width: termsLabel.frame.width, height: checkboxSize)

    }
    
    // MARK: - Setup Helpers
    private func setupLabel(_ label: UILabel, _ text: String) {
        label.text = text
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .medium)
        view.addSubview(label)
    }
    
    private func setupTextField(_ field: UITextField, _ placeholder: String, _ keyboardType: UIKeyboardType = .default, isSecure: Bool = false) {
        field.isSecureTextEntry = isSecure
        field.keyboardType = keyboardType
        field.textColor = .white
        field.autocapitalizationType = .none
        field.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        field.layer.cornerRadius = 10
        field.font = .systemFont(ofSize: 16)
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        field.leftViewMode = .always
        field.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor.lightGray]
        )
        view.addSubview(field)
    }
    
    private func setupHelper(_ label: UILabel) {
        label.text = ""
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        label.isHidden = true
        view.addSubview(label)
    }
    
    private func setupRequirement(_ req: (UIImageView, UILabel), _ text: String) {
        req.0.image = UIImage(systemName: "checkmark")
        req.0.tintColor = .white
        view.addSubview(req.0)
        
        req.1.text = text
        req.1.font = .systemFont(ofSize: 14)
        req.1.textColor = .white
        view.addSubview(req.1)
    }
    
    private func setupToggleButton(_ button: UIButton, for field: UITextField) {
        button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        button.tintColor = .white
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.addTarget(self, action: #selector(togglePasswordVisibility(_:)), for: .touchUpInside)
        field.rightView = button
        field.rightViewMode = .always
    }
    
    // MARK: - Event Handling
    private func setupTargets() {
        passwordTextField.addTarget(self, action: #selector(passwordDidChange), for: .editingChanged)
        repeatPasswordTextField.addTarget(self, action: #selector(passwordDidChange), for: .editingChanged)
        termsCheckbox.addTarget(self, action: #selector(termsCheckboxTapped), for: .touchUpInside)
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }
    
    
    @objc private func togglePasswordVisibility(_ sender: UIButton) {
        let field = (sender == togglePasswordButton) ? passwordTextField : repeatPasswordTextField
        field.isSecureTextEntry.toggle()
        let icon = field.isSecureTextEntry ? "eye.slash.fill" : "eye.fill"
        sender.setImage(UIImage(systemName: icon), for: .normal)
    }
    
    @objc private func passwordDidChange() {
        validatePassword()
        updateContinueButtonState()
    }
    
    @objc private func termsCheckboxTapped() {
        areTermsAccepted.toggle()
        let icon = areTermsAccepted ? "checkmark.square.fill" : "square"
        termsCheckbox.setImage(UIImage(systemName: icon), for: .normal)
        termsCheckbox.tintColor = areTermsAccepted ? UIColor(hex: "#3B72F2") : .lightGray
        updateContinueButtonState()
    }
    
    @objc private func continueButtonTapped() {
        print("Continue tapped")
    }
    
    // MARK: - Validation
    private func validatePassword() {
        guard let password = passwordTextField.text else { return }
        
        let validations: [Bool] = [
            password.count >= 8 && password.count <= 64,
            password.rangeOfCharacter(from: .uppercaseLetters) != nil,
            password.rangeOfCharacter(from: .lowercaseLetters) != nil,
            password.rangeOfCharacter(from: .decimalDigits) != nil,
            NSPredicate(format: "SELF MATCHES %@", ".*[!@#$%^&*(),.?\":{}|<>].*").evaluate(with: password)
        ]
        
        zip(validations, requirementViews).forEach { isValid, view in
            updateRequirement(view, isValid)
        }
        
        let match = password == repeatPasswordTextField.text
        repeatPasswordHelperLabel.text = match ? "" : "Passwords do not match."
        repeatPasswordHelperLabel.isHidden = match
    }
    
    private func updateRequirement(_ req: (UIImageView, UILabel), _ valid: Bool) {
        let color = valid ? UIColor(hex: "#A962F7") : .white
        let icon = valid ? "checkmark.circle.fill" : "checkmark"
        req.0.image = UIImage(systemName: icon)
        req.0.tintColor = color
        req.1.textColor = color
    }
    
    private func updateContinueButtonState() {
        let pw = passwordTextField.text ?? ""
        let repeatPw = repeatPasswordTextField.text ?? ""
        let emailValid = !(emailTextField.text ?? "").isEmpty
        
        let conditionsMet = [
            pw.count >= 8 && pw.count <= 64,
            pw.rangeOfCharacter(from: .uppercaseLetters) != nil,
            pw.rangeOfCharacter(from: .lowercaseLetters) != nil,
            pw.rangeOfCharacter(from: .decimalDigits) != nil,
            NSPredicate(format: "SELF MATCHES %@", ".*[!@#$%^&*(),.?\":{}|<>].*").evaluate(with: pw),
            pw == repeatPw,
            emailValid,
            areTermsAccepted
        ]
        
        let enabled = conditionsMet.allSatisfy { $0 }
        continueButton.isEnabled = enabled
        continueButton.backgroundColor = enabled ? UIColor(hex: "#3B72F2") : .gray
    }
}
