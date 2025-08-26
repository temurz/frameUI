//
//  ContactCell.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 25/08/25.
//

import UIKit

class ContactAdminCell: UITableViewCell {
    var avatarImageView: UIImageView = UIImageView()
    private var titleLabel: UILabel = UILabel()
    private var subtitleLabel: UILabel = UILabel()
    private var roleLabel: UILabel = UILabel()
    var checkboxButton: UIButton = UIButton()
    
    var isCheckboxSelected = false
    var didSelectCheckMark: (() -> Void)?
    
    static let identifier = "ContactAdminCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        let theme = Theme()
        backgroundColor = .clear
        selectionStyle = .none
        
        // Avatar Image View
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.backgroundColor = theme.bgSecondaryTransparent20
        avatarImageView.layer.cornerRadius = 20
        avatarImageView.clipsToBounds = true
        contentView.addSubview(avatarImageView)
        
        // Title Label
        titleLabel.font = theme.onestFont(size: 16, weight: .semiBold)
        titleLabel.textColor = theme.contentPrimary
        contentView.addSubview(titleLabel)
        
        // Subtitle Label
        subtitleLabel.font = theme.onestFont(size: 13, weight: .regular)
        subtitleLabel.textColor = theme.contentSecondary
        contentView.addSubview(subtitleLabel)
        
        // Role Label
        roleLabel.font = theme.onestFont(size: 13, weight: .regular)
        roleLabel.textColor = theme.contentSecondary
        roleLabel.textAlignment = .right
        contentView.addSubview(roleLabel)
        
        // Checkbox Button
        checkboxButton.isHidden = true
        checkboxButton.setImage(theme.emptyCheckbox, for: .normal)
        checkboxButton.setImage(theme.selectedCheckbox, for: .selected)
        checkboxButton.addTarget(self, action: #selector(didSelectCheckbox), for: .touchUpInside)
        contentView.addSubview(checkboxButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let avatarSize: CGFloat = 40
        let padding: CGFloat = 16
        let verticalSpacing: CGFloat = 4
        let maxWidth = contentView.bounds.width
        let maxHeight = contentView.bounds.height
        
        // Avatar
        avatarImageView.frame = CGRect(
            x: padding,
            y: (maxHeight - avatarSize) / 2,
            width: avatarSize,
            height: avatarSize
        )
        
        
        let checkboxSize: CGFloat = 24
        checkboxButton.frame = CGRect(
            x: maxWidth - checkboxSize - padding,
            y: (maxHeight - checkboxSize) / 2,
            width: checkboxSize,
            height: checkboxSize
        )
        

        let roleLabelWidth: CGFloat = 80
        let roleLabelX: CGFloat
        if !checkboxButton.isHidden {
            roleLabelX = maxWidth - roleLabelWidth - checkboxSize - padding - 16
        } else {
            roleLabelX = maxWidth - roleLabelWidth - padding
        }
        roleLabel.frame = CGRect(
            x: roleLabelX,
            y: (maxHeight - 20) / 2,
            width: roleLabelWidth,
            height: 20
        )
        

        let availableWidth: CGFloat
        if !checkboxButton.isHidden {
            availableWidth = roleLabelX - avatarImageView.frame.maxX - padding - 16
        } else {
            availableWidth = roleLabelX - avatarImageView.frame.maxX - padding
        }
        
        // Title Label
        titleLabel.frame = CGRect(
            x: avatarImageView.frame.maxX + padding,
            y: (maxHeight / 2) - 20,
            width: availableWidth,
            height: 20
        )
        
        // Subtitle Label
        subtitleLabel.frame = CGRect(
            x: avatarImageView.frame.maxX + padding,
            y: titleLabel.frame.maxY + verticalSpacing,
            width: availableWidth,
            height: 18
        )
    }
    
    @objc private func didSelectCheckbox() {
        isCheckboxSelected.toggle()
        checkboxButton.isSelected = isCheckboxSelected
        let theme = Theme()
        backgroundColor = isCheckboxSelected ? theme.bgWhiteTransparent10 : .clear
        didSelectCheckMark?()
    }
    
    // MARK: - Configuration Methods
    
    func configureAdminCell(name: String, status: String, role: String? = nil, avatarURL: String? = nil) {
        titleLabel.text = name
        subtitleLabel.text = status
        
        if let role = role {
            roleLabel.text = role
            roleLabel.isHidden = false
        } else {
            roleLabel.isHidden = true
        }
        
        checkboxButton.isHidden = true
        configureAvatar(with: avatarURL)
        setNeedsLayout()
    }
    

    func configureSelectableCell(model: Contact, isSelectable: Bool = true, role: String? = nil, subtitle: String? = nil) {
        titleLabel.text = model.fullName
        
        if let subtitle = subtitle {
            subtitleLabel.text = subtitle
        } else {
            subtitleLabel.text = model.username
        }
        
        let isOwner = role == "Owner"
        checkboxButton.isHidden = !isSelectable || isOwner
        
        // Always show role label
        if let role = role {
            roleLabel.text = role
            roleLabel.isHidden = false
        } else {
            roleLabel.isHidden = true
        }
        
        checkboxButton.isSelected = model.isSelected
        isCheckboxSelected = model.isSelected
        let theme = Theme()
        backgroundColor = model.isSelected && isSelectable && !isOwner ? theme.bgWhiteTransparent10 : .clear
        
        configureAvatar(with: model.imageURL)
        setNeedsLayout()
    }
    
    private func configureAvatar(with urlString: String?) {
        if let urlString = urlString, let url = URL(string: urlString) {
            ImageLoader().downloadImage(url: url) { [weak self] image in
                self?.avatarImageView.image = image
            }
        } else {
            avatarImageView.image = Theme().useAvatarIcon
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        titleLabel.text = nil
        subtitleLabel.text = nil
        roleLabel.text = nil
        roleLabel.isHidden = false
        checkboxButton.isHidden = true
        checkboxButton.isSelected = false
        isCheckboxSelected = false
        backgroundColor = .clear
    }
}
