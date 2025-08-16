//
//  BlockedUserView.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 16/08/25.
//  
//

import UIKit

class BlockedUserView: TemplateView {
    
    // MARK: - UI Components
    private let navBar = UIView()
    private let backButton = UIButton()
    private let titleLabel = UILabel()
    private let doneButton = UIButton()
    
    private let searchBar = TemplateSearchBar()
    private let infoLabel = UILabel()
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    // MARK: - Data
    private var blockedUsers: [Contact] = [
        Contact(imageURL: "", firstName: "Johnny", lastName: "Smith", username: "@johnny", isSelected: false),
        Contact(imageURL: "", firstName: "Paul", lastName: "Anderson", username: "@paul", isSelected: false)
    ]
    
    // MARK: - Initialization
    override func initialize() {
        self.theme = self.theme ?? Theme()
        super.initialize()
        
        setupNavBar()
        setupSearchBar()
        setupInfoLabel()
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
        titleLabel.text = "Blocked users"
        titleLabel.textAlignment = .center
        titleLabel.textColor = theme?.contentPrimary
        navBar.addSubview(titleLabel)
        
        // Done button
        doneButton.setImage(theme?.plusIcon, for: .normal)
        doneButton.tintColor = theme?.contentPrimary
        doneButton.addTarget(self, action: #selector(didTapDone), for: .touchUpInside)
        navBar.addSubview(doneButton)
    }
    
    @objc private func didTapBack() {
        // Handle back action
    }
    
    @objc private func didTapDone() {
        // Handle done action
    }
    
    private func setupSearchBar() {
        searchBar.placeholder = "Search"
        searchBar.backgroundColor = theme?.textFieldBackgroundColor
        searchBar.layer.cornerRadius = 10
        searchBar.layer.masksToBounds = true
        addSubview(searchBar)
    }
    
    private func setupInfoLabel() {
        infoLabel.text = "Users blocked from the group by admins can't rejoin via invite link"
        infoLabel.font = theme?.onestFont(size: 14, weight: .medium)
        infoLabel.textColor = theme?.contentSecondary
        infoLabel.textAlignment = .center
        infoLabel.numberOfLines = 0
        addSubview(infoLabel)
    }
    
    private func setupTableView() {
        tableView.register(ContactCell.self, forCellReuseIdentifier: ContactCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 72
        tableView.backgroundColor = theme?.backgroundPrimaryColor
        addSubview(tableView)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        tableView.addGestureRecognizer(longPressGesture)
    }
    
    @objc private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        guard gesture.state == .began else { return }
        
        let location = gesture.location(in: tableView)
        if let indexPath = tableView.indexPathForRow(at: location) {
            showActionMenu(for: indexPath)
        }
    }
    
    private func showActionMenu(for indexPath: IndexPath) {
        let person = blockedUsers[indexPath.row]
        
        var actions: [AlertAction] = [
                AlertAction(title: "View profile", isCancel: false) {
                },
                AlertAction(title: "Unblock", isCancel: false) {
                    
                },
                AlertAction(title: "Cancel", isCancel: true, handler: nil)
            ]
        
        parentViewController?.showMultiActionAlert(
                title: "What do you want to do with user \(person.firstName) \(person.lastName)?",
                message: "",
                actions: actions
            )
    }
    
    // MARK: - Layout
    override func updateSubviewsFrame(_ size: CGSize) {
        let horizontalPadding: CGFloat = 16
        let elementSpacing: CGFloat = 16
        let safeAreaTop = safeAreaInsets.top
        
        // Nav bar
        let navBarHeight: CGFloat = 56
        navBar.frame = CGRect(x: 0, y: 0, width: size.width, height: safeAreaTop + navBarHeight)
        
        backButton.frame = CGRect(x: horizontalPadding, y: safeAreaTop, width: 44, height: navBarHeight)
        doneButton.frame = CGRect(x: size.width - 44 - horizontalPadding, y: safeAreaTop, width: 44, height: navBarHeight)
        titleLabel.frame = CGRect(x: 60, y: safeAreaTop, width: size.width - 120, height: navBarHeight)
        
        // Search bar
        searchBar.frame = CGRect(
            x: horizontalPadding,
            y: navBar.frame.maxY + elementSpacing,
            width: size.width - (2 * horizontalPadding),
            height: 40
        )
        
        // Info label
        let infoLabelHeight = infoLabel.sizeThatFits(
            CGSize(width: size.width - (2 * horizontalPadding), height: .greatestFiniteMagnitude)
        ).height
        infoLabel.frame = CGRect(
            x: horizontalPadding,
            y: searchBar.frame.maxY + elementSpacing,
            width: size.width - (2 * horizontalPadding),
            height: infoLabelHeight
        )
        
        // Table view
        tableView.frame = CGRect(
            x: 0,
            y: infoLabel.frame.maxY + elementSpacing,
            width: size.width,
            height: size.height - infoLabel.frame.maxY - elementSpacing
        )
    }
    
    // MARK: - Theme Update
    override func updateTheme() {
        super.updateTheme()
        
        backgroundColor = theme?.backgroundPrimaryColor
        titleLabel.textColor = theme?.contentPrimary
        backButton.tintColor = theme?.contentPrimary
        doneButton.tintColor = theme?.contentPrimary
        infoLabel.textColor = theme?.contentSecondary
        tableView.backgroundColor = theme?.backgroundPrimaryColor
    }
}

// MARK: - UITableView DataSource & Delegate
extension BlockedUserView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blockedUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.identifier, for: indexPath) as? ContactCell else {
            return UITableViewCell()
        }
        
        let contact = blockedUsers[indexPath.row]
        cell.configureCell(model: contact)
        cell.avatarImageView?.image = theme?.useAvatarIcon
        cell.checkboxButton?.isHidden = true
        
        
        if indexPath.row == 0 {
            cell.backgroundColor = theme?.bgSecondaryTransparent20
        } else {
            cell.backgroundColor = theme?.backgroundPrimaryColor
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
       
    }
}
