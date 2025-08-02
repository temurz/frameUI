//
//  SettingsAdminView.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 30/07/25.
//
//

import UIKit

class SettingsAdminView: TemplateView {
    // MARK: - Callbacks
    var onCancelTapped: (() -> Void)?
    var onSaveTapped: (() -> Void)?
    
    // MARK: - UI Components
    private let purpleTheme = PurpleTheme()
    
    private let navBar = UIView()
    private let navTitleLabel = UILabel()
    private let cancelButton = UIButton(type: .system)
    private let saveButton = UIButton(type: .system)
    
    private let profileImageContainer = UIView()
    private let profileImageView = UIImageView()
    private let setNewPhotoButton = UIButton(type: .system)
    private let nameLabel = UILabel()
    private let nameTextFieldContainer = UIView()
    private let nameTextField = UITextField()
    private let descriptionLabel = UILabel()
    private let descriptionTextFieldContainer = UIView()
    private let descriptionTextField = UITextField()
    private let settingsContainerView = UIView()
    private var settingRows: [UIView] = []
    private let deleteGroupButton = UIButton(type: .system)
    
    // MARK: - Initialization
    override func initialize() {
        super.initialize()
        
        setupNavigationBar()
        setupProfileSection()
        setupInputFields()
        setupSettingsList()
        setupDeleteButton()
        
        updateTheme()
    }
    
    // MARK: - Frame Layout
    override func updateSubviewsFrame(_ size: CGSize) {
        super.updateSubviewsFrame(size)
        
        let topInset: CGFloat = safeAreaInsets.top
        let bottomInset: CGFloat = safeAreaInsets.bottom
        let horizontalPadding: CGFloat = 16
        let contentWidth = size.width - (horizontalPadding * 2)
        let totalHeight = size.height - topInset - bottomInset
        
        navBar.frame = CGRect(x: 0, y: 0, width: size.width, height: topInset + 56)
        navTitleLabel.frame = CGRect(x: 80, y: topInset, width: size.width - 160, height: 56)
        cancelButton.frame = CGRect(x: 16, y: topInset, width: 60, height: 56)
        saveButton.frame = CGRect(x: size.width - 76, y: topInset, width: 60, height: 56)
        
        var currentY: CGFloat = navBar.frame.maxY + 16
        
        profileImageContainer.frame = CGRect(x: (size.width - 100) / 2, y: currentY, width: 100, height: 100)
        profileImageView.frame = profileImageContainer.bounds.insetBy(dx: 10, dy: 10)
        currentY += 100 + 12
        
        setNewPhotoButton.frame = CGRect(x: (size.width - 136) / 2, y: currentY, width: 136, height: 32)
        currentY += 40 + 16
        
        
        nameLabel.frame = CGRect(x: horizontalPadding + 16, y: currentY, width: contentWidth, height: 18)
        currentY += 18 + 4
        nameTextFieldContainer.frame = CGRect(x: horizontalPadding, y: currentY, width: contentWidth, height: 48)
        nameTextField.frame = nameTextFieldContainer.bounds.insetBy(dx: 12, dy: 0)
        currentY += 48 + 16
        
        descriptionLabel.frame = CGRect(x: horizontalPadding + 16, y: currentY, width: contentWidth, height: 18)
        currentY += 18 + 4
        descriptionTextFieldContainer.frame = CGRect(x: horizontalPadding, y: currentY, width: contentWidth, height: 48)
        descriptionTextField.frame = descriptionTextFieldContainer.bounds.insetBy(dx: 12, dy: 0)
        currentY += 48 + 32
        

        let rowHeight: CGFloat = 48
        let settingsCount = settingRows.count
        let settingsHeight = CGFloat(settingsCount) * rowHeight
        settingsContainerView.frame = CGRect(x: horizontalPadding, y: currentY, width: contentWidth, height: settingsHeight)
        for (i, row) in settingRows.enumerated() {
            row.frame = CGRect(x: 0, y: CGFloat(i) * rowHeight, width: contentWidth, height: rowHeight)
        }
        currentY += settingsHeight + 16

        
        let deleteButtonHeight: CGFloat = 48
        let maxY = size.height - bottomInset - deleteButtonHeight - 12
        deleteGroupButton.frame = CGRect(x: horizontalPadding, y: min(currentY, maxY), width: contentWidth, height: deleteButtonHeight)
    }

    
    // MARK: - Theme & Style Setup
    override func updateTheme() {
        super.updateTheme()
        backgroundColor = purpleTheme.backgroundPrimaryColor
        
        profileImageContainer.backgroundColor = purpleTheme.bgWhiteTransparent10
        profileImageView.image = purpleTheme.avatar
        profileImageView.contentMode = .scaleAspectFill

        setNewPhotoButton.setTitle("Set new photo", for: .normal)
        setNewPhotoButton.titleLabel?.font = purpleTheme.onestFont(size: 16, weight: .regular)
        setNewPhotoButton.setTitleColor(purpleTheme.contentWhite, for: .normal)
        setNewPhotoButton.backgroundColor = purpleTheme.buttonQuaternaryTransparentDefaultBg
        
        nameLabel.text = "Name"
        nameLabel.font = purpleTheme.onestFont(size: 14, weight: .regular)
        nameLabel.textColor = purpleTheme.contentWhite
        
        nameTextFieldContainer.backgroundColor = purpleTheme.textFieldBackgroundColor
        nameTextField.font = purpleTheme.onestFont(size: 16, weight: .regular)
        nameTextField.textColor = purpleTheme.contentWhite
        nameTextField.text = "Designers team"
        
        descriptionLabel.text = "Description"
        descriptionLabel.font = purpleTheme.onestFont(size: 14, weight: .regular)
        descriptionLabel.textColor = purpleTheme.contentWhite
        
        descriptionTextFieldContainer.backgroundColor = purpleTheme.textFieldBackgroundColor
        descriptionTextField.font = purpleTheme.onestFont(size: 16, weight: .regular)
        descriptionTextField.textColor = purpleTheme.contentWhite
        descriptionTextField.text = "A group of designers who draw pictures"
        
        settingsContainerView.backgroundColor = purpleTheme.bgWhiteTransparent10
        
        deleteGroupButton.setTitle("Delete group", for: .normal)
        deleteGroupButton.titleLabel?.font = purpleTheme.onestFont(size: 16, weight: .bold)
        deleteGroupButton.setTitleColor(purpleTheme.contentWhite, for: .normal)
        deleteGroupButton.backgroundColor = purpleTheme.buttonQuaternaryTransparentDefaultBg
    }
    
    // MARK: - Private Setup Helpers
    private func setupNavigationBar() {
        addSubview(navBar)
        navBar.backgroundColor = purpleTheme.backgroundPrimaryColor
        
        navTitleLabel.text = "Group settings"
        navTitleLabel.textColor = purpleTheme.contentWhite
        navTitleLabel.font = purpleTheme.onestFont(size: 18, weight: .bold)
        navTitleLabel.textAlignment = .center
        navBar.addSubview(navTitleLabel)
        
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(purpleTheme.contentSecondary, for: .normal)
        cancelButton.titleLabel?.font = purpleTheme.onestFont(size: 16, weight: .regular)
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        navBar.addSubview(cancelButton)
        
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(purpleTheme.contentPink, for: .normal)
        saveButton.titleLabel?.font = purpleTheme.onestFont(size: 16, weight: .semiBold)
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        navBar.addSubview(saveButton)
    }
    
    @objc private func cancelTapped() { onCancelTapped?() }
    @objc private func saveTapped() { onSaveTapped?() }

    private func setupProfileSection() {
        addSubview(profileImageContainer)
        profileImageContainer.layer.cornerRadius = 50
        
        profileImageContainer.addSubview(profileImageView)
        profileImageView.layer.cornerRadius = 40
        profileImageView.clipsToBounds = true
        
        addSubview(setNewPhotoButton)
        setNewPhotoButton.layer.cornerRadius = 16
    }
    
    private func setupInputFields() {
        addSubview(nameLabel)
        addSubview(nameTextFieldContainer)
        nameTextFieldContainer.layer.cornerRadius = 16
        nameTextFieldContainer.addSubview(nameTextField)
        
        addSubview(descriptionLabel)
        addSubview(descriptionTextFieldContainer)
        descriptionTextFieldContainer.layer.cornerRadius = 16
        descriptionTextFieldContainer.addSubview(descriptionTextField)
    }
    
    private func setupSettingsList() {
        addSubview(settingsContainerView)
        settingsContainerView.layer.cornerRadius = 16
        settingsContainerView.clipsToBounds = true
        
        let settingsData: [(icon: UIImage?, text: String)] = [
            (purpleTheme.groupIcon, "Members"),
            (purpleTheme.linkIcon, "Invite link"),
            (purpleTheme.keyPermissionIcon, "Permissions"),
            (purpleTheme.adminIcon, "Administrators"),
            (purpleTheme.blockIcon, "Blocked users")
        ]
        
        for item in settingsData {
            let row = SettingsRowView(purpleTheme: purpleTheme, icon: item.icon, text: item.text)
            settingsContainerView.addSubview(row)
            settingRows.append(row)
        }
    }
    
    private func setupDeleteButton() {
        addSubview(deleteGroupButton)
        deleteGroupButton.layer.cornerRadius = 20
        deleteGroupButton.clipsToBounds = true
    }
}

/// A private custom view for a single row in the settings list to encapsulate its layout.
private class SettingsRowView: UIView {
    init(purpleTheme: PurpleTheme, icon: UIImage?, text: String) {
        super.init(frame: .zero)
        
        let iconImageView = UIImageView(image: icon?.withRenderingMode(.alwaysTemplate))
        iconImageView.tintColor = purpleTheme.contentWhite
        iconImageView.contentMode = .scaleAspectFit
        
        let label = UILabel()
        label.text = text
        label.font = purpleTheme.onestFont(size: 17, weight: .semiBold)
        label.textColor = purpleTheme.contentWhite
        
        let chevronImageView = UIImageView(image: purpleTheme.arrowRightIcon?.withRenderingMode(.alwaysTemplate))
        chevronImageView.tintColor = purpleTheme.contentPrimary
        chevronImageView.contentMode = .scaleAspectFit
        
        [iconImageView, label, chevronImageView].forEach { addSubview($0) }
        
        self.iconImageView = iconImageView
        self.textLabel = label
        self.chevronImageView = chevronImageView
    }
    
    private var iconImageView: UIImageView!
    private var textLabel: UILabel!
    private var chevronImageView: UIImageView!
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let iconSize: CGFloat = 24
        let horizontalPadding: CGFloat = 16
        
        iconImageView.frame = CGRect(x: horizontalPadding, y: (bounds.height - iconSize) / 2, width: iconSize, height: iconSize)
        
        let chevronSize: CGFloat = 16
        chevronImageView.frame = CGRect(x: bounds.width - horizontalPadding - chevronSize, y: (bounds.height - chevronSize) / 2, width: chevronSize, height: chevronSize)
        
        let labelX = iconImageView.frame.maxX + 16
        let labelWidth = chevronImageView.frame.minX - labelX - 8
        textLabel.frame = CGRect(x: labelX, y: 0, width: labelWidth, height: bounds.height)
    }
}
