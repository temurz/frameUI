//
//  OtpEmailView.swift
//  Tedr
//
//  Created by Kostya Lee on 09/05/25.
//

import Foundation
import UIKit

protocol OtpEmailViewDelegate: AnyObject {
    func verifyCode(code: String)
    func backButtonTapped()
    func resendCode()
}

class OtpEmailView: TemplateView {
    weak var delegate: OtpEmailViewDelegate?
    var backButton: UIButton?
    var titleLbl: UILabel?
    var subtitleLbl: UILabel?
    var emailLbl: UILabel?
    var spamLbl: UILabel?
    var otpEmailInputFields: [BackwardDetectingTextField] = []
    var otpEmailInputButton: UIButton? // Touch view
    var timerLbl: UILabel?
    var timer: Timer?
    var remainingSeconds: Int = 0
    
    override func initialize() {
        
        self.backgroundColor = Theme().purpleBackgroundColor
        let theme = Theme()
        
        backButton = UIButton.initStyled()
        backButton?.setImage(theme.arrowLeftLIcon, for: .normal)
        backButton?.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        self.addSubview(backButton!)
        
        titleLbl = UILabel.initStyled(LabelStyle(font: theme.getFont(size: 32, weight: .bold), textColor: theme.whiteColor, textAlignment: .center, numberOfLines: 1))
        self.addSubview(titleLbl!)
        
        subtitleLbl = UILabel.initStyled(LabelStyle(
            font: theme.getFont(size: 18, weight: .regular),
            textColor: theme.whiteColor.withAlphaComponent(0.5),
            textAlignment: .center,
            numberOfLines: 1)
        )
        self.addSubview(subtitleLbl!)
        
        emailLbl = UILabel.initStyled(LabelStyle(font: theme.getFont(size: 18, weight: .regular), textColor: theme.whiteColor, textAlignment: .center, numberOfLines: 1))
        self.addSubview(emailLbl!)
        
        spamLbl = UILabel.initStyled(LabelStyle(
            font: theme.getFont(size: 16, weight: .regular),
            textColor: theme.whiteColor.withAlphaComponent(0.5),
            textAlignment: .center,
            numberOfLines: 1)
        )
        self.addSubview(spamLbl!)
        
        // Create 6 OtpEmail input fields
        for i in 0..<6 {
            let textField = BackwardDetectingTextField.initBackwardStyled()
            textField.backgroundColor = theme.purpleBackgroundColor
            textField.textColor = theme.whiteColor
            textField.tintColor = theme.whiteColor
            textField.font = theme.getFont(size: 22, weight: .bold)
            textField.textAlignment = .center
            textField.keyboardType = .numberPad
            textField.keyboardAppearance = .dark
            textField.delegate = self
            textField.backspaceDelegate = self
            textField.tag = i
            textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            otpEmailInputFields.append(textField)
            self.addSubview(textField)
        }
        
        otpEmailInputButton = UIButton()
        otpEmailInputButton?.backgroundColor = .clear
        otpEmailInputButton?.addTarget(self, action: #selector(didSelectInput), for: .touchUpInside)
        self.addSubview(otpEmailInputButton)
        
        timerLbl = UILabel.initStyled(LabelStyle(font: Theme().getFont(size: 24, weight: .bold), textColor: theme.systemGreenColor, textAlignment: .center, numberOfLines: 1))
        
        self.addSubview(timerLbl!)
    }
    
    override func updateTheme() {
        let theme = Theme()
        
        titleLbl?.applyStyle(LabelStyle(font: theme.getFont(size: 32, weight: .bold), textColor: theme.whiteColor, textAlignment: .center, numberOfLines: 1))
        
        subtitleLbl?.applyStyle(LabelStyle(font: theme.getFont(size: 18, weight: .regular), textColor: theme.whiteColor.withAlphaComponent(0.5), textAlignment: .center, numberOfLines: 1))
        
        emailLbl?.applyStyle(LabelStyle(font: theme.getFont(size: 18, weight: .regular), textColor: theme.whiteColor, textAlignment: .center, numberOfLines: 1))
        
        spamLbl?.applyStyle(LabelStyle(font: theme.getFont(size: 16, weight: .regular), textColor: theme.whiteColor.withAlphaComponent(0.5), textAlignment: .center, numberOfLines: 1))
        
        backButton?.tintColor = theme.whiteColor
        
        for field in otpEmailInputFields {
            field.backgroundColor = UIColor.systemGray6.withAlphaComponent(0.3)
            field.textColor = theme.whiteColor
            field.font = theme.getFont(size: 22, weight: .bold)
        }
        
        timerLbl?.applyStyle(LabelStyle(font: theme.getFont(size: 24, weight: .bold), textColor: theme.systemGreenColor, textAlignment: .center, numberOfLines: 1))
    }
    
    override func updateSubviewsFrame(_ size: CGSize) {
        // Back button
        var x = CGFloat(16)
        var y = safeAreaInsets.top + 16
        var w = CGFloat(30)
        var h = CGFloat(30)
        backButton?.frame = .init(x: x, y: y, width: w, height: h)
        
        // Title label
        x = 16
        y = safeAreaInsets.top + 60
        w = size.width - 2*x
        h = CGFloat(45)
        titleLbl?.frame = .init(x: x, y: y, width: w, height: h)
        
        // Subtitle label
        y = (titleLbl?.frame.maxY ?? 0) + 20
        h = CGFloat(25)
        subtitleLbl?.frame = .init(x: x, y: y, width: w, height: h)
        
        // Email label
        y = (subtitleLbl?.frame.maxY ?? 0) + 5
        emailLbl?.frame = .init(x: x, y: y, width: w, height: h)
        
        // Spam message label
        y = (emailLbl?.frame.maxY ?? 0) + 20
        h = CGFloat(22)
        spamLbl?.frame = .init(x: x, y: y, width: w, height: h)
        
        // OtpEmail input fields
        let inputFieldSize = CGFloat(60)
        let spacing = (size.width - (inputFieldSize * 6)) / 7
        
        x = spacing
        y = (spamLbl?.frame.maxY ?? 0) + 40
        w = inputFieldSize
        h = inputFieldSize + 15
        
        for i in 0..<otpEmailInputFields.count {
            otpEmailInputFields[i].frame = .init(x: x + CGFloat(i) * (inputFieldSize + spacing), y: y, width: w, height: h)
            otpEmailInputFields[i].borderRadius = 16
        }
        
        x = spacing
        w = size.width - x*2
        otpEmailInputButton?.frame = .init(x: x, y: y, width: w * 6 + spacing * 5, height: h)
        
        // Timer label
        x = 16
        y = otpEmailInputFields[0].frame.maxY + 40
        w = size.width - 2*x
        h = CGFloat(30)
        timerLbl?.frame = .init(x: x, y: y, width: w, height: h)
    }
    
    func startTimer(duration: Int) {
        stopTimer()
        remainingSeconds = duration
        updateTimerLabel()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.remainingSeconds > 0 {
                self.remainingSeconds -= 1
                self.updateTimerLabel()
            } else {
                self.stopTimer()
                // Handle timer expiration if needed
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func updateTimerLabel() {
        let minutes = remainingSeconds / 60
        let seconds = remainingSeconds % 60
        timerLbl?.text = String(format: "%02d:%02d", minutes, seconds)
    }
    
    @objc private func backButtonPressed() {
        delegate?.backButtonTapped()
    }
    
    @objc private func didSelectInput() {
        // Найти первое незаполненное поле
        if let firstEmptyField = otpEmailInputFields.first(where: { $0.text?.isEmpty ?? true }) {
            firstEmptyField.becomeFirstResponder()
        } else {
            // Если все поля заполнены, отправить фокус в конец (последнее поле)
            otpEmailInputFields.last?.becomeFirstResponder()
        }
    }

    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else { return }
        
        // Move to next field if current field is filled
        if text.count >= 1 {
            textField.text = String(text.prefix(1))
            if textField.tag < otpEmailInputFields.count - 1 {
                otpEmailInputFields[textField.tag + 1].becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
                // Collect all OtpEmail digits
                let code = otpEmailInputFields.compactMap { $0.text }.joined()
                if code.count == 6 {
                    delegate?.verifyCode(code: code)
                }
            }
        }
    }
}

extension OtpEmailView: UITextFieldDelegate, BackspaceDetectingTextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Allow only numbers
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        let isNumber = allowedCharacters.isSuperset(of: characterSet)
        
        // Allow only one character per field
        let currentText = textField.text ?? ""
        let newLength = currentText.count + string.count - range.length
        return isNumber && newLength <= 1
    }
    
    func textFieldDidDeleteBackward(_ textField: UITextField) {
        guard let field = textField as? BackwardDetectingTextField else { return }
        let tag = field.tag

        if field.text?.isEmpty ?? true, tag > 0 {
            otpEmailInputFields[tag - 1].becomeFirstResponder()
            otpEmailInputFields[tag - 1].text = ""
        } else {
            field.text = ""
        }
    }
}


