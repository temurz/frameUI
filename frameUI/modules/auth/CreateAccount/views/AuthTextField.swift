
import UIKit

class AuthTextField: TemplateView {

    private let titleLabel = UILabel()
    private let containerView = UIView()
    let textField = UITextField()
    private let rightButton = UIButton()

    var showsEye: Bool = false {
        didSet { rightButton.isHidden = !showsEye }
    }
    
    var isSecure: Bool = false

    override func initialize() {
        backgroundColor = .clear

        titleLabel.font = theme?.getFont(size: 14, weight: .medium)
        titleLabel.textColor = .white

        containerView.backgroundColor = UIColor(white: 1, alpha: 0.08)
        containerView.layer.cornerRadius = 16
        containerView.clipsToBounds = true

        textField.textColor = .white
        textField.font = theme?.getFont(size: 16, weight: .regular)
        textField.borderStyle = .none
        textField.backgroundColor = .clear

        rightButton.setImage(Theme().eyeOffIcon, for: .normal)
        rightButton.tintColor = .white
        rightButton.addTarget(self, action: #selector(changeVisibility), for: .touchUpInside)

        addSubview(titleLabel)
        addSubview(containerView)
        containerView.addSubview(textField)
        containerView.addSubview(rightButton)
    }

    override func updateSubviewsFrame(_ size: CGSize) {
        let padding: CGFloat = 16
        let titleHeight: CGFloat = 20
        let containerHeight: CGFloat = 56
        let iconSize: CGFloat = 24

        titleLabel.frame = CGRect(x: padding, y: 0, width: size.width - 2 * padding, height: titleHeight)

        containerView.frame = CGRect(x: 0, y: titleLabel.frame.maxY + 4, width: size.width, height: containerHeight)

        textField.frame = CGRect(
            x: padding,
            y: 0,
            width: size.width - padding * 2 - (showsEye ? (iconSize + 8) : 0),
            height: containerHeight
        )

        if showsEye {
            rightButton.frame = CGRect(x: size.width - padding - iconSize, y: (containerHeight - iconSize) / 2, width: iconSize, height: iconSize)
        }
    }

    func configure(title: String, placeholder: String, showsEye: Bool = false, isSecure: Bool = false, keyboardType: UIKeyboardType = .default) {
        titleLabel.text = title
        textField.placeholder = placeholder
        textField.isSecureTextEntry = isSecure
        self.showsEye = showsEye
        self.isSecure = isSecure
        textField.keyboardType = keyboardType
    }
    
    @objc private func changeVisibility() {
        isSecure.toggle()
        rightButton.setImage(
            isSecure
            ? Theme().eyeOffIcon
            : Theme().eyeIcon,
            for: .normal)
        textField.isSecureTextEntry = isSecure
    }
}

