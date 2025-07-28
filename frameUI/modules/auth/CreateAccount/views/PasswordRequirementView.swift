import UIKit

class PasswordRequirementView: TemplateView {

    private let icon = UIImageView()
    private let label = UILabel()

    var isValid: Bool = false {
        didSet {
            let color = isValid ? theme?.systemGreenColor ?? .systemGreen : UIColor.white.withAlphaComponent(0.6)
            icon.tintColor = color
            label.textColor = color
            icon.image = isValid ? Theme().checkIcon?.withTintColor(.systemGreen) : Theme().checkIcon
        }
    }

    init(text: String) {
        super.init(frame: .zero)
        label.text = text
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func initialize() {
        icon.tintColor = .white.withAlphaComponent(0.6)
        icon.image = Theme().checkIcon

        label.textColor = .white.withAlphaComponent(0.6)
        label.font = theme?.getFont(size: 14, weight: .regular)

        addSubview(icon)
        addSubview(label)
    }

    override func updateSubviewsFrame(_ size: CGSize) {
        icon.frame = CGRect(x: 0, y: 2, width: 20, height: 20)
        label.frame = CGRect(x: 28, y: 0, width: size.width - 28, height: 24)
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 24)
    }
}
