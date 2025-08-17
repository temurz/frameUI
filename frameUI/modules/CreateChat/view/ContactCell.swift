//
//  ContactCell.swift
//  Tedr
//
//  Created by Temur on 11/07/2025.
//

import UIKit

class ContactCell: UITableViewCell {
    var avatarImageView: UIImageView? = UIImageView()
    private var titleLabel: UILabel? = UILabel()
    private var usernameLabel: UILabel? = UILabel()
    var checkboxButton: UIButton? = UIButton()
    
    var isCheckboxSelected = false
    var didSelectCheckMark: (() -> Void)?
    
    static let identifier = "ContactCell"
    
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
        
        avatarImageView?.contentMode = .scaleAspectFill
        avatarImageView?.backgroundColor = .lightGray
        contentView.addSubview(avatarImageView!)
        
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel?.textColor = theme.contentPrimary
        contentView.addSubview(titleLabel!)
        
        usernameLabel?.font = UIFont.systemFont(ofSize: 14)
        usernameLabel?.textColor = theme.contentSecondary
        contentView.addSubview(usernameLabel!)
        
        checkboxButton?.isHidden = true
        checkboxButton?.setImage(theme.emptyCheckbox, for: .normal)
        checkboxButton?.addTarget(self, action: #selector(didSelectCheckbox), for: .touchUpInside)
        contentView.addSubview(checkboxButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let avatarSize: CGFloat = 56
        let padding: CGFloat = 16
        let verticalSpacing: CGFloat = 2
        let maxWidth = contentView.width
        let maxHeight = contentView.height
        
        var x = padding
        var y = (maxHeight - avatarSize) / 2
        var w = avatarSize
        var h = w
        self.avatarImageView?.frame = CGRect(x: x, y: y, width: avatarSize, height: avatarSize)
        avatarImageView?.borderRadius = avatarSize/2
        
        let textWidth = maxWidth - (padding * 3) - avatarSize - 48
        
        h = titleLabel?.textHeight(textWidth) ?? 20
        x = (avatarImageView?.maxX ?? 0) + padding
        y = (avatarImageView?.centerY ?? 0) - h - verticalSpacing
        self.titleLabel?.frame = CGRect(x: x, y: y, width: textWidth, height: h)
        
        // Username label frame
        h = usernameLabel?.textHeight(textWidth) ?? 20
        y = (avatarImageView?.centerY ?? 0) + verticalSpacing
        usernameLabel?.frame = CGRect(x: x, y: y, width: textWidth, height: h)
        
        w = 24
        h = w
        x = maxWidth - (w * 2)
        y = (maxHeight - h) / 2
        self.checkboxButton?.frame = .init(x: x, y: y, width: w, height: h)
    }
    
    @objc private func didSelectCheckbox() {
        isCheckboxSelected.toggle()
        checkboxButton?.setImage(isCheckboxSelected ? Theme().selectedCheckbox : Theme().emptyCheckbox, for: .normal)
        backgroundColor = isCheckboxSelected ? Theme().bgWhiteTransparent10 : .clear
        didSelectCheckMark?()
    }
    
    func configureCell(model: Contact, isSelectable: Bool = false) {
        isCheckboxSelected = model.isSelected
        if let url = URL(string: model.imageURL) {
            ImageLoader().downloadImage(url: url, completion: { [weak self] uiImage in
                self?.avatarImageView?.image = uiImage
            })
        } else {
            avatarImageView?.image = UIImage(systemName: "person.circle")
        }
        titleLabel?.text = model.fullName
        usernameLabel?.text = model.username
        checkboxButton?.isHidden = !isSelectable
        checkboxButton?.setImage(model.isSelected ? Theme().selectedCheckbox : Theme().emptyCheckbox, for: .normal)
        
        backgroundColor = model.isSelected && isSelectable ? Theme().bgWhiteTransparent10 : .clear
    }
    
    deinit {
        avatarImageView = nil
        titleLabel = nil
        usernameLabel = nil
        checkboxButton = nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        isCheckboxSelected = false
        checkboxButton?.isHidden = true
    }
}
