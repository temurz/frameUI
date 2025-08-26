//
//  SettingsAdministratorsView.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 24/08/25.
//  
//

import UIKit

class SettingsAdministratorsView: TemplateView {
    
    // MARK: - UI Components
    private let navBar = UIView()
    private let backButton = UIButton()
    private let titleLabel = UILabel()
    private let editButton = UIButton()
    private let trashButton = UIButton()
    
    private let addAdminsButton = UIButton()
    private let addAdminsTitleLabel = UILabel()
    private let membersTitleLabel = UILabel()
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    // MARK: - State
    private var isEditMode = false
    private var selectedAdmins: [Bool] = [false, false]
    
    // MARK: - Initialization
    override func initialize() {
        self.theme = self.theme ?? Theme()
        super.initialize()
        
        setupNavBar()
        setupAddAdminsButton()
        setupMembersSection()
        setupTableView()
    }
    
    private func setupNavBar() {
        navBar.backgroundColor = .clear
        addSubview(navBar)
        
        // Back button
        backButton.setImage(theme?.arrowLeftIcon, for: .normal)
        backButton.tintColor = theme?.contentPrimary
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        navBar.addSubview(backButton)
        
        // Title Label
        titleLabel.font = theme?.onestFont(size: 18, weight: .bold)
        titleLabel.text = "Admins"
        titleLabel.textAlignment = .center
        titleLabel.textColor = theme?.contentPrimary
        navBar.addSubview(titleLabel)
        
        // Edit button
        editButton.setImage(theme?.editIcon, for: .normal)
        editButton.tintColor = theme?.contentPrimary
        editButton.addTarget(self, action: #selector(didTapEdit), for: .touchUpInside)
        navBar.addSubview(editButton)
        
        // Trash button (hidden initially)
        trashButton.setImage(theme?.trashIcon, for: .normal)
        trashButton.tintColor = theme?.contentPrimary
        trashButton.isHidden = true
        trashButton.addTarget(self, action: #selector(didTapTrash), for: .touchUpInside)
        navBar.addSubview(trashButton)
    }
    
    @objc private func didTapBack() {
        if isEditMode {
            exitEditMode()
        } else {
            parentViewController?.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc private func didTapEdit() {
        enterEditMode()
    }
    
    @objc private func didTapTrash() {

    }
    
    private func enterEditMode() {
        isEditMode = true
        
        // Update navbar buttons
        backButton.setTitle("Cancel", for: .normal)
        backButton.setImage(nil, for: .normal)
        backButton.setTitleColor(theme?.contentSecondary, for: .normal)
        
        editButton.isHidden = true
        trashButton.isHidden = false
        
        tableView.reloadData()
    }
    
    private func exitEditMode() {
        isEditMode = false
        
        // Reset navbar buttons
        backButton.setImage(theme?.arrowLeftIcon, for: .normal)
        backButton.setTitle(nil, for: .normal)
        
        editButton.isHidden = false
        trashButton.isHidden = true
        
        selectedAdmins = [false, false]
        
        tableView.reloadData()
    }
    
    private func setupAddAdminsButton() {

        addAdminsButton.backgroundColor = theme?.bgWhiteTransparent10
        addAdminsButton.layer.cornerRadius = 16
        addAdminsButton.addTarget(self, action: #selector(didTapAddAdmins), for: .touchUpInside)
        

        let leftIcon = UIImageView(image: theme?.addMemberIcon)
        leftIcon.tintColor = theme?.contentPrimary
        leftIcon.frame = CGRect(x: 16, y: 16, width: 24, height: 24)
        addAdminsButton.addSubview(leftIcon)
        

        let rightIcon = UIImageView(image: theme?.arrowRightIcon)
        rightIcon.tintColor = theme?.contentSecondary
        rightIcon.frame = CGRect(x: 0, y: 16, width: 24, height: 24)
        addAdminsButton.addSubview(rightIcon)
        

        addAdminsTitleLabel.text = "Add admins"
        addAdminsTitleLabel.font = theme?.onestFont(size: 17, weight: .semiBold)
        addAdminsTitleLabel.textColor = theme?.contentPrimary
        addAdminsButton.addSubview(addAdminsTitleLabel)
        
        addSubview(addAdminsButton)
    }
    
    @objc private func didTapAddAdmins() {
        presentAddAdminsFloating()
    }
    
    private func presentAddAdminsFloating() {
          guard let parentVC = parentViewController else { return }
          
          let modalVC = UIViewController()
          let modalView = ModalAddAdminsView()
          modalView.theme = self.theme
          
          modalVC.view.addSubview(modalView)
          modalView.frame = modalVC.view.bounds
          modalView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
          
          modalVC.modalPresentationStyle = .pageSheet
          
          if let sheet = modalVC.sheetPresentationController {
              sheet.detents = [.large()]
              sheet.prefersGrabberVisible = true
              sheet.preferredCornerRadius = 24
              sheet.largestUndimmedDetentIdentifier = .large
          }
          
          parentVC.present(modalVC, animated: true)
      }
    
    private func setupMembersSection() {
        membersTitleLabel.font = theme?.onestFont(size: 13, weight: .regular)
        membersTitleLabel.text = "MEMBERS"
        membersTitleLabel.textColor = theme?.contentSecondary
        addSubview(membersTitleLabel)
    }
    
    private func setupTableView() {
        tableView.register(ContactAdminCell.self, forCellReuseIdentifier: ContactAdminCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 72
        tableView.isScrollEnabled = false
        tableView.backgroundColor = theme?.bgWhiteTransparent10
        tableView.layer.cornerRadius = 16
        tableView.clipsToBounds = true
        addSubview(tableView)
    }
    
    // MARK: - Layout
    override func updateSubviewsFrame(_ size: CGSize) {
        let horizontalPadding: CGFloat = 16
        let elementSpacing: CGFloat = 16
        let sectionSpacing: CGFloat = 24
        let safeAreaTop = safeAreaInsets.top
        

        let navBarHeight: CGFloat = 56
        navBar.frame = CGRect(x: 0, y: 0, width: size.width, height: safeAreaTop + navBarHeight)
        
        backButton.frame = CGRect(x: horizontalPadding, y: safeAreaTop, width: navBarHeight, height: navBarHeight)
        editButton.frame = CGRect(x: size.width - 44 - horizontalPadding, y: safeAreaTop, width: 44, height: navBarHeight)
        trashButton.frame = CGRect(x: size.width - 44 - horizontalPadding, y: safeAreaTop, width: 44, height: navBarHeight)
        titleLabel.frame = CGRect(x: 60, y: safeAreaTop, width: size.width - 120, height: navBarHeight)
        

        addAdminsButton.frame = CGRect(
            x: horizontalPadding,
            y: navBar.frame.maxY + elementSpacing,
            width: size.width - (horizontalPadding * 2),
            height: 56
        )
        

        if let leftIcon = addAdminsButton.subviews.first(where: { $0 is UIImageView }) {
            leftIcon.frame = CGRect(x: 16, y: 16, width: 24, height: 24)
        }
        
        if let rightIcon = addAdminsButton.subviews.last(where: { $0 is UIImageView }) {
            rightIcon.frame = CGRect(
                x: addAdminsButton.frame.width - 24 - 16,
                y: 16,
                width: 24,
                height: 24
            )
        }
        

        let titleX: CGFloat = 16 + 24 + 16
        addAdminsTitleLabel.frame = CGRect(
            x: titleX,
            y: 0,
            width: addAdminsButton.frame.width - titleX - 24 - 16,
            height: 56
        )
        
        // Members title
        membersTitleLabel.frame = CGRect(
            x: horizontalPadding + 16 ,
            y: addAdminsButton.frame.maxY + sectionSpacing,
            width: size.width - (horizontalPadding * 2),
            height: 16
        )
        
        // Table view (for admins)
        let tableHeight = CGFloat(2) * 72
        tableView.frame = CGRect(
            x: horizontalPadding,
            y: membersTitleLabel.frame.maxY + elementSpacing,
            width: size.width - (horizontalPadding * 2),
            height: tableHeight
        )
    }
    
    // MARK: - Theme Update
    override func updateTheme() {
        super.updateTheme()
        
        backgroundColor = theme?.backgroundPrimaryColor
        titleLabel.textColor = theme?.contentPrimary
        backButton.tintColor = theme?.contentPrimary
        editButton.tintColor = theme?.contentPrimary
        trashButton.tintColor = theme?.contentPrimary
        addAdminsButton.backgroundColor = theme?.bgWhiteTransparent10
        addAdminsTitleLabel.textColor = theme?.contentPrimary
        addAdminsTitleLabel.font = theme?.onestFont(size: 17, weight: .semiBold)
        membersTitleLabel.textColor = theme?.contentSecondary
        tableView.backgroundColor = theme?.bgWhiteTransparent10
        
        // Update button icons
        if let leftIcon = addAdminsButton.subviews.first(where: { $0 is UIImageView }) as? UIImageView {
            leftIcon.image = theme?.addMemberIcon
            leftIcon.tintColor = theme?.contentPrimary
        }
        
        if let rightIcon = addAdminsButton.subviews.last(where: { $0 is UIImageView }) as? UIImageView {
            rightIcon.image = theme?.arrowRightIcon
            rightIcon.tintColor = theme?.contentSecondary
        }
    }
}

// MARK: - UITableView DataSource & Delegate
extension SettingsAdministratorsView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactAdminCell.identifier, for: indexPath) as? ContactAdminCell else {
            return UITableViewCell()
        }
        
        if isEditMode {
            let isSelected = selectedAdmins[indexPath.row]
            
            let contact: Contact
            let subtitle: String
            if indexPath.row == 0 {
                contact = Contact(
                    imageURL: "",
                    firstName: "Johnny",
                    lastName: "Smith",
                    username: "Owner",
                    isSelected: isSelected
                )
                subtitle = "Online"
            } else {
                contact = Contact(
                    imageURL: "",
                    firstName: "Paul",
                    lastName: "Anderson",
                    username: "Admin",
                    isSelected: isSelected
                )
                subtitle = "Last seen 15 min ago"
            }
            
            let role = indexPath.row == 0 ? "Owner" : "Admin"
            cell.configureSelectableCell(model: contact, isSelectable: true, role: role, subtitle: subtitle)
        } else {
            // Normal display mode
            if indexPath.row == 0 {
                cell.configureAdminCell(
                    name: "Johnny Smith",
                    status: "Online",
                    role: "Owner",
                    avatarURL: nil
                )
            } else {
                cell.configureAdminCell(
                    name: "Paul Anderson",
                    status: "Last seen 15 min ago",
                    role: "Admin",
                    avatarURL: nil
                )
            }
        }
        
        cell.didSelectCheckMark = { [weak self] in
            if indexPath.row != 0 { 
                self?.selectedAdmins[indexPath.row].toggle()
                tableView.reloadRows(at: [indexPath], with: .none)
            }
        }
        
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        
        return cell
    }
}
