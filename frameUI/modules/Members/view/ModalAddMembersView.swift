//
//  AddMembersView.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 15/08/25.
//

import UIKit

class ModalAddMembersView: TemplateView {
    
    // MARK: - UI Components
    private let navBar = UIView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let searchBar = TemplateSearchBar()
    private let inviteButton = UIButton(type: .system)
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    // MARK: - Data
    private var sections: [(letter: String, contacts: [Contact])] = []
    
    // MARK: - Initialization
    override func initialize() {
        self.theme = self.theme ?? Theme()
        super.initialize()
        
        setupContactsData()
        setupNavBar()
        setupSearchBar()
        setupInviteButton()
        setupTableView()
    }
    
    private func setupContactsData() {
        let contacts = [
            Contact(imageURL: "", firstName: "Anthony", lastName: "Walker", username: "@anthony", isSelected: false),
            Contact(imageURL: "", firstName: "Alexandra", lastName: "Smith", username: "@alexandra", isSelected: false),
            Contact(imageURL: "", firstName: "Barry", lastName: "Wine", username: "@barry", isSelected: false),
            Contact(imageURL: "", firstName: "Bernard", lastName: "", username: "@bernard", isSelected: false),
            Contact(imageURL: "", firstName: "Black", lastName: "Sea", username: "@blacksea", isSelected: false),
            Contact(imageURL: "", firstName: "Chris", lastName: "Prett", username: "@prett", isSelected: false),
            Contact(imageURL: "", firstName: "Christina", lastName: "", username: "@christina", isSelected: false)
        ].sorted { $0.fullName < $1.fullName }
        
        let grouped = Dictionary(grouping: contacts) { contact -> String in
            return String(contact.fullName.prefix(1)).uppercased()
        }
        
        sections = grouped.map { (letter: $0.key, contacts: $0.value) }
            .sorted { $0.letter < $1.letter }
    }
    
    private func setupNavBar() {
        navBar.backgroundColor = .clear
        addSubview(navBar)
        
        // Title Label
        titleLabel.font = theme?.onestFont(size: 18, weight: .bold)
        titleLabel.text = "Add members"
        titleLabel.textAlignment = .center
        navBar.addSubview(titleLabel)
        
        // Subtitle Label
        subtitleLabel.font = theme?.onestFont(size: 13, weight: .regular)
        subtitleLabel.text = "\(sections.reduce(0) { $0 + $1.contacts.count }) members"
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = theme?.contentPrimary
        navBar.addSubview(subtitleLabel)
        
        
        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.titleLabel?.font = theme?.onestFont(size: 16, weight: .regular)
        cancelButton.setTitleColor(theme?.contentSecondary, for: .normal)
        cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        cancelButton.tag = 0
        navBar.addSubview(cancelButton)
        

        let doneButton = UIButton(type: .system)
        doneButton.setTitle("Done", for: .normal)
        doneButton.titleLabel?.font = theme?.onestFont(size: 16, weight: .semiBold)
        doneButton.setTitleColor(theme?.contentPink, for: .normal)
        doneButton.addTarget(self, action: #selector(didTapDone), for: .touchUpInside)
        doneButton.tag = 1
        navBar.addSubview(doneButton)
        
        
    }

    @objc private func didTapCancel() {
        
    }

    @objc private func didTapDone() {
        
    }
    
    private func setupSearchBar() {
        searchBar.placeholder = "Search"
        searchBar.backgroundColor = theme?.textFieldBackgroundColor
        searchBar.layer.cornerRadius = 10
        searchBar.layer.masksToBounds = true
        addSubview(searchBar)
    }
    
    private func setupInviteButton() {
        inviteButton.setTitle("Invite via link", for: .normal)
        inviteButton.titleLabel?.font = theme?.onestFont(size: 16, weight: .semiBold)
        inviteButton.setTitleColor(theme?.contentPrimary, for: .normal)
        inviteButton.contentHorizontalAlignment = .left
        inviteButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 0)
        
        let leftIcon = UIImageView(image: theme?.linkIcon)
        leftIcon.tintColor = theme?.contentPrimary
        leftIcon.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        inviteButton.addSubview(leftIcon)
        
        let rightIcon = UIImageView(image: theme?.arrowRightIcon)
        rightIcon.tintColor = theme?.contentSecondary
        rightIcon.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        inviteButton.addSubview(rightIcon)
        
        addSubview(inviteButton)
    }
    
    private func setupTableView() {
        tableView.register(ContactCell.self, forCellReuseIdentifier: ContactCell.identifier)
        tableView.register(SectionHeaderView.self, forHeaderFooterViewReuseIdentifier: SectionHeaderView.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.sectionHeaderHeight = 28
        tableView.rowHeight = 72
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
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

        // Layout buttons
        let cancelButtonWidth: CGFloat = 60
        let doneButtonWidth: CGFloat = 60
        let buttonHeight: CGFloat = 44

        if let cancelButton = navBar.viewWithTag(0) as? UIButton {
            cancelButton.frame = CGRect(
                x: padding,
                y: safeAreaTop + (navBarHeight - buttonHeight) / 2,
                width: cancelButtonWidth,
                height: buttonHeight
            )
        }

        if let doneButton = navBar.viewWithTag(1) as? UIButton {
            doneButton.frame = CGRect(
                x: size.width - padding - doneButtonWidth,
                y: safeAreaTop + (navBarHeight - buttonHeight) / 2,
                width: doneButtonWidth,
                height: buttonHeight
            )
        }
        
        // Title Label
        let titleWidth = size.width - (2 * padding) - cancelButtonWidth - doneButtonWidth - (2 * padding)
        titleLabel.frame = CGRect(
            x: (size.width - titleWidth)/2,
            y: safeAreaTop + 12,
            width: titleWidth,
            height: 24
        )
        

        subtitleLabel.frame = CGRect(
            x: (size.width - titleWidth)/2,
            y: titleLabel.frame.maxY + 2,
            width: titleWidth,
            height: 20
        )
        
        searchBar.frame = CGRect(
            x: padding,
            y: navBar.frame.maxY + elementSpacing,
            width: size.width - (2 * padding),
            height: 40
        )
        
        
        inviteButton.frame = CGRect(
            x: padding,
            y: searchBar.frame.maxY + 16,
            width: size.width - (2 * padding),
            height: 44
        )

        if let leftIcon = inviteButton.subviews.first(where: { $0 is UIImageView }) {
            leftIcon.frame = CGRect(
                x: 0,
                y: (inviteButton.frame.height - 24)/2,
                width: 24,
                height: 24
            )
        }

        
        if let rightIcon = inviteButton.subviews.last(where: { $0 is UIImageView }) {
            rightIcon.frame = CGRect(
                x: inviteButton.frame.width - 24,
                y: (inviteButton.frame.height - 24)/2,
                width: 24,
                height: 24
            )
        }


        inviteButton.titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: 16 + 24,
            bottom: 0,
            right: 24 + 12
        )
        
            let tableY = inviteButton.frame.maxY
            tableView.frame = CGRect(
                x: 0,
                y: tableY,
                width: size.width,
                height: size.height - tableY
            )
        

    }

    
    // MARK: - Theming
    override func updateTheme() {
        super.updateTheme()
        
        backgroundColor = theme?.modalBlueDefaultBg
        titleLabel.textColor = theme?.contentPrimary
        subtitleLabel.textColor = theme?.contentSecondary
        inviteButton.setTitleColor(theme?.contentPrimary, for: .normal)
        tableView.backgroundColor = theme?.modalBlueDefaultBg
    }
}

// MARK: - UITableView DataSource & Delegate
extension ModalAddMembersView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.identifier, for: indexPath) as? ContactCell else {
            return UITableViewCell()
        }
        
        let contact = sections[indexPath.section].contacts[indexPath.row]
        cell.configureCell(model: contact)
        cell.avatarImageView?.image = theme?.useAvatarIcon
        
        cell.checkboxButton?.isHidden = false
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeaderView.identifier) as? SectionHeaderView else {
            return nil
        }
        
        header.configure(with: sections[section].letter)
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        sections[indexPath.section].contacts[indexPath.row].isSelected.toggle()
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}

// MARK: - Section Header View
class SectionHeaderView: UITableViewHeaderFooterView {
    static let identifier = "SectionHeaderView"
    
    private let titleLabel = UILabel()
    private let background = UIView()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        let theme = Theme()
        
        background.backgroundColor = theme.modalBlueDefaultBg
        contentView.addSubview(background)
        
        titleLabel.font = theme.onestFont(size: 13, weight: .regular)
        titleLabel.textColor = theme.contentSecondary
        contentView.addSubview(titleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        background.frame = contentView.bounds
        

        titleLabel.frame = CGRect(
            x: 16,
            y: (contentView.bounds.height - 20) / 2,
            width: contentView.bounds.width - 32,
            height: 20
        )
    }
    
    func configure(with letter: String) {
        titleLabel.text = letter
    }
}
