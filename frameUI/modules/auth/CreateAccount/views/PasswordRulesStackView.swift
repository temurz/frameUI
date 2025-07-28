import UIKit

class PasswordRulesStackView: TemplateView {

    private let stack = UIStackView()
    let rules: [PasswordRequirementView] = [
        PasswordRequirementView(text: "From 8 to 64 characters"),
        PasswordRequirementView(text: "Uppercase letter (A–Z)"),
        PasswordRequirementView(text: "Lowercase letter (a–z)"),
        PasswordRequirementView(text: "Number (0–9)"),
        PasswordRequirementView(text: "Special symbol (!,?,&...)")
    ]

    override func initialize() {
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fillEqually
        addSubview(stack)
        rules.forEach { stack.addArrangedSubview($0) }
    }

    override func updateSubviewsFrame(_ size: CGSize) {
        stack.frame = bounds
    }

    func updateValidationStates(for password: String) {
        rules[0].isValid = password.count >= 8 && password.count <= 64
        rules[1].isValid = password.range(of: "[A-Z]", options: .regularExpression) != nil
        rules[2].isValid = password.range(of: "[a-z]", options: .regularExpression) != nil
        rules[3].isValid = password.range(of: "[0-9]", options: .regularExpression) != nil
        rules[4].isValid = password.range(of: "[!@#$%^&*(),.?:{}|<>]", options: .regularExpression) != nil
    }
}
