//
//  ModalBlockMemberView.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 16/08/25.
//

import UIKit

class ModalBlockMemberView: TemplateView {
    
    // MARK: - UI Components
    private let navBar = UIView()
    private let titleLabel = UILabel()
    private let searchBar = TemplateSearchBar()
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    // MARK: - Data
    private var contacts: [Contact] = [
        Contact(imageURL: "", firstName: "Johnny", lastName: "Smith", username: "@johnny", isSelected: false),
        Contact(imageURL: "", firstName: "Paul", lastName: "Anderson", username: "@paul", isSelected: false),
        Contact(imageURL: "", firstName: "Jane", lastName: "Smith", username: "@jane", isSelected: false),
        Contact(imageURL: "", firstName: "Samantha", lastName: "Fox", username: "@fox", isSelected: false)
    ]
    
    // MARK: - Initialization
    override func initialize() {
        self.theme = self.theme ?? Theme()
        super.initialize()
        
        setupNavBar()
        setupSearchBar()
        setupTableView()
    }
    
    private func setupNavBar() {
        navBar.backgroundColor = .clear
        addSubview(navBar)
        
        // Title Label
        titleLabel.font = theme?.onestFont(size: 18, weight: .bold)
        titleLabel.text = "Members"
        titleLabel.textAlignment = .center
        titleLabel.textColor = theme?.contentPrimary
        navBar.addSubview(titleLabel)
        
        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.titleLabel?.font = theme?.onestFont(size: 16, weight: .regular)
        cancelButton.setTitleColor(theme?.contentSecondary, for: .normal)
        cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        navBar.addSubview(cancelButton)
    }

    @objc private func didTapCancel() {
        
    }
    
    private func setupSearchBar() {
        searchBar.placeholder = "Search"
        searchBar.backgroundColor = theme?.textFieldBackgroundColor
        searchBar.layer.cornerRadius = 10
        searchBar.layer.masksToBounds = true
        addSubview(searchBar)
    }
    
    private func setupTableView() {
        tableView.register(ContactCell.self, forCellReuseIdentifier: ContactCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 72
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        tableView.backgroundColor = .clear
        addSubview(tableView)
    }
    
    // MARK: - Layout
    override func updateSubviewsFrame(_ size: CGSize) {
        super.updateSubviewsFrame(size)
        
        let padding: CGFloat = 16
        let elementSpacing: CGFloat = 16
        let safeAreaTop = safeAreaInsets.top
        
        // NavBar Layout
        let navBarHeight: CGFloat = 56
        navBar.frame = CGRect(x: 0, y: 0, width: size.width, height: safeAreaTop + navBarHeight)

        // Cancel Button
        if let cancelButton = navBar.subviews.first(where: { $0 is UIButton }) as? UIButton {
            cancelButton.frame = CGRect(
                x: padding,
                y: safeAreaTop + (navBarHeight - 44) / 2,
                width: 60,
                height: 44
            )
        }
        
        // Title Label
        titleLabel.frame = CGRect(
            x: 60,
            y: safeAreaTop,
            width: size.width - 120,
            height: navBarHeight
        )
        
        // Search Bar
        searchBar.frame = CGRect(
            x: padding,
            y: navBar.frame.maxY + elementSpacing,
            width: size.width - (2 * padding),
            height: 40
        )
        
        // Table View
        tableView.frame = CGRect(
            x: 0,
            y: searchBar.frame.maxY + elementSpacing,
            width: size.width,
            height: size.height - searchBar.frame.maxY - elementSpacing
        )
    }
    
    // MARK: - Theming
    override func updateTheme() {
        super.updateTheme()
        
        backgroundColor = theme?.modalBlueDefaultBg
        titleLabel.textColor = theme?.contentPrimary
        tableView.backgroundColor = .clear
    }
}

// MARK: - UITableView DataSource & Delegate
extension ModalBlockMemberView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.identifier, for: indexPath) as? ContactCell else {
            return UITableViewCell()
        }
        
        let contact = contacts[indexPath.row]
        cell.configureCell(model: contact)
        cell.avatarImageView?.image = theme?.useAvatarIcon
        cell.checkboxButton?.isHidden = true
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
