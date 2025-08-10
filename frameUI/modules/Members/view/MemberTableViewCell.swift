import UIKit

class MemberTableViewCell: UITableViewCell {

    private let theme = Theme()
    private let containerView = UIView()
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let accessoryLabel = UILabel()
    private let chevronImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none

        containerView.clipsToBounds = true
        contentView.addSubview(containerView)

        [iconImageView, titleLabel, subtitleLabel, accessoryLabel, chevronImageView]
            .forEach { containerView.addSubview($0) }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var currentCornerStyle: CornerStyle = .all
    private var isActionCell: Bool = false

    override func layoutSubviews() {
        super.layoutSubviews()

        var insets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        
        switch currentCornerStyle {
        case .top:
            insets.bottom = 0
        case .bottom:
            insets.top = 0
        case .none:
            insets.top = 0
            insets.bottom = 0
        case .all:
            break
        }
        
        containerView.frame = contentView.bounds.inset(by: insets)
        let bounds = containerView.bounds

        
        let iconSize: CGFloat = isActionCell ? 24 : 40
        iconImageView.frame = CGRect(x: 16, y: (bounds.height - iconSize) / 2, width: iconSize, height: iconSize)
        
        let textX = iconImageView.frame.maxX + 16
        let accessoryWidth: CGFloat = accessoryLabel.text?.isEmpty == false ? 50 : 0
        let chevronWidth: CGFloat = chevronImageView.isHidden ? 0 : 30

        titleLabel.frame = CGRect(x: textX, y: 16, width: bounds.width - textX - accessoryWidth - chevronWidth - 16, height: 20)
        
        if subtitleLabel.text?.isEmpty ?? true {
            titleLabel.frame = CGRect(x: textX, y: (bounds.height - 20) / 2, width: bounds.width - textX - chevronWidth - 16, height: 20)
        } else {
            subtitleLabel.frame = CGRect(x: textX, y: titleLabel.frame.maxY, width: bounds.width - textX - 16, height: 16)
        }
        
        accessoryLabel.frame = CGRect(x: bounds.width - accessoryWidth - chevronWidth - 8, y: 0, width: accessoryWidth, height: bounds.height)
        chevronImageView.frame = CGRect(x: bounds.width - 22 - 16, y: (bounds.height - 22) / 2, width: 22, height: 22)
    }

    enum CornerStyle {
        case all
        case top
        case bottom
        case none
    }
    
    func configureAsAction(icon: UIImage?, text: String, cornerStyle: CornerStyle = .all) {
        currentCornerStyle = cornerStyle
        isActionCell = true
        subtitleLabel.text = nil
        accessoryLabel.text = nil
        chevronImageView.isHidden = false

        iconImageView.image = icon
        titleLabel.text = text
        chevronImageView.image = theme.arrowRightIcon

        titleLabel.font = theme.onestFont(size: 17, weight: .semiBold)
        titleLabel.textColor = theme.contentWhite
        iconImageView.tintColor = theme.contentWhite
        chevronImageView.tintColor = theme.contentSecondary
        
        applyCornerStyle(cornerStyle)
        
        iconImageView.layer.cornerRadius = 0
        iconImageView.clipsToBounds = false
        
        setNeedsLayout()
    }

    func configureAsPerson(name: String, status: String, role: String?, cornerStyle: CornerStyle = .all) {
        currentCornerStyle = cornerStyle
        isActionCell = false
        chevronImageView.isHidden = true

        iconImageView.image = theme.useAvatarIcon
        titleLabel.text = name
        subtitleLabel.text = status
        accessoryLabel.text = role

        titleLabel.font = theme.onestFont(size: 16, weight: .semiBold)
        titleLabel.textColor = theme.contentWhite
        subtitleLabel.font = theme.onestFont(size: 13, weight: .regular)
        subtitleLabel.textColor = theme.contentSecondary
        accessoryLabel.font = theme.onestFont(size: 13, weight: .regular)
        accessoryLabel.textColor = theme.contentSecondary
        accessoryLabel.textAlignment = .right

        applyCornerStyle(cornerStyle)

        iconImageView.layer.cornerRadius = 20
        iconImageView.clipsToBounds = true
        
        setNeedsLayout()
    }
    
    private func applyCornerStyle(_ style: CornerStyle) {
        switch style {
        case .all:
            containerView.layer.cornerRadius = 16
            containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            containerView.backgroundColor = theme.bgWhiteTransparent10
        case .top:
            containerView.layer.cornerRadius = 16
            containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            containerView.backgroundColor = theme.bgWhiteTransparent10
        case .bottom:
            containerView.layer.cornerRadius = 16
            containerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            containerView.backgroundColor = theme.bgWhiteTransparent10
        case .none:
            containerView.layer.cornerRadius = 0
            containerView.layer.maskedCorners = []
            containerView.backgroundColor = theme.bgBlackTransparent20
        }
    }

    func setContainerBackgroundColor(_ color: UIColor) {
        containerView.backgroundColor = color
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        currentCornerStyle = .all
        isActionCell = false
        subtitleLabel.text = nil
        accessoryLabel.text = nil
        chevronImageView.isHidden = true
        iconImageView.image = nil
        containerView.backgroundColor = theme.bgWhiteTransparent10
        iconImageView.layer.cornerRadius = 0
        iconImageView.clipsToBounds = false
    }
}
