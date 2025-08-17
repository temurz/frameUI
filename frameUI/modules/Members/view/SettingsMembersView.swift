//
//  SettingsMembersView.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 10/08/25.
//  
//

import UIKit

class SettingsMembersView: TemplateView {
    
    // MARK: - Properties
    var onBackButtonTapped: (() -> Void)?
    var onAddMembersTapped: (() -> Void)?
    
    private let navBar = UIView()
    private let backButton = UIButton(type: .system)
    private let titleLabel = UILabel()
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    private var admins: [(name: String, status: String, role: String?)] = []
    private var members: [(name: String, status: String, role: String?)] = []
    
    // MARK: - Initialization
    override func initialize() {
        self.theme = self.theme ?? Theme()
        super.initialize()
        setupData()
        setupSubviews()
        updateTheme()
    }
    
    // MARK: - Layout
    override func updateSubviewsFrame(_ size: CGSize) {
        super.updateSubviewsFrame(size)
        
        let safeAreaTop = safeAreaInsets.top
        navBar.frame = CGRect(x: 0, y: 0, width: size.width, height: safeAreaTop + 56)
        backButton.frame = CGRect(x: 16, y: safeAreaTop, width: 44, height: 56)
        titleLabel.frame = CGRect(x: 60, y: safeAreaTop, width: size.width - 120, height: 56)
        
        let tableY = navBar.frame.maxY + 16
        tableView.frame = CGRect(x: 0, y: tableY, width: size.width, height: size.height - tableY)
    }
    
    // MARK: - Theming
    override func updateTheme() {
        super.updateTheme()
        
        backgroundColor = theme?.backgroundPrimaryColor
        titleLabel.font = theme?.onestFont(size: 18, weight: .bold)
        titleLabel.textColor = theme?.contentWhite
        titleLabel.textAlignment = .center
        
        backButton.setImage(theme?.arrowLeftLIcon, for: .normal)
        backButton.tintColor = theme?.contentWhite
    }
    
    // MARK: - Setup
    private func setupData() {
        titleLabel.text = "4 Members"
        admins = [
            ("Anthony Walker", "Online", "Admin")
        ]
        members = [
            ("Paul Anderson", "Last seen 15 min ago", nil),
            ("Jane Smith", "Last seen recently", nil),
            ("Samantha Fox", "Last seen recently", nil)
        ]
    }
    
    private func setupSubviews() {
        addSubview(navBar)
        navBar.addSubview(backButton)
        navBar.addSubview(titleLabel)
        backButton.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MemberTableViewCell.self, forCellReuseIdentifier: "MemberCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        addSubview(tableView)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        tableView.addGestureRecognizer(longPressGesture)
    }
    
    // MARK: - Actions
    @objc private func handleBackButton() {
        onBackButtonTapped?()
    }
    
    @objc private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        guard gesture.state == .began else { return }
        
        let location = gesture.location(in: tableView)
        if let indexPath = tableView.indexPathForRow(at: location) {
            showActionMenu(for: indexPath)
        }
    }
    
    private func showActionMenu(for indexPath: IndexPath) {
        let person: (name: String, status: String, role: String?)
        var actions: [AlertAction]
        
        if indexPath.section == 1 {
            person = admins[indexPath.row]
            actions = [
                AlertAction(title: "Promote to admin", isCancel: false) {
                    print("\(person.name) is now admin")
                },
                AlertAction(title: "Block", isCancel: false) {
                    print("Blocked \(person.name)")
                },
                AlertAction(title: "Delete", isCancel: false) {},
                AlertAction(title: "Cancel", isCancel: true, handler: nil)
            ]
        } else {
            person = members[indexPath.row]
            actions = [
                AlertAction(title: "Dismiss", isCancel: false) {
                    print("Dismissed \(person.name)")
                },
                AlertAction(title: "Delete", isCancel: false) {},
                AlertAction(title: "Cancel", isCancel: true, handler: nil)
            ]
        }
        
        parentViewController?.showMultiActionAlert(
            title: "What do you want to do with \(person.name)?",
            message: "",
            actions: actions
        )
    }
    
    // MARK: - Full Screen Presentation
    private func presentAddMembersFloating() {
        guard let parentVC = parentViewController else { return }
        
        let modalVC = UIViewController()
        let modalView = ModalAddMembersView()
        modalView.theme = self.theme
        
        modalVC.view.addSubview(modalView)
        modalView.frame = modalVC.view.bounds
        modalView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        modalVC.modalPresentationStyle = .pageSheet
        
        if let sheet = modalVC.sheetPresentationController {
            sheet.selectedDetentIdentifier = .large
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 24
        }
        
        parentVC.present(modalVC, animated: true)
    }

}

// MARK: - UITableView DataSource & Delegate
extension SettingsMembersView: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return admins.count
        case 2: return members.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCell", for: indexPath) as? MemberTableViewCell else {
            return UITableViewCell()
        }
        
        switch indexPath.section {
        case 0:
            cell.configureAsAction(icon: theme?.addMemberIcon, text: "Add members", cornerStyle: .all)
        case 1:
            let admin = admins[indexPath.row]
            cell.configureAsPerson(name: admin.name, status: admin.status, role: admin.role, cornerStyle: .all)
        case 2:
            let member = members[indexPath.row]
            let memberCount = members.count
            
            var cornerStyle: MemberTableViewCell.CornerStyle
            if memberCount == 1 {
                cornerStyle = .all
            } else if indexPath.row == 0 {
                cornerStyle = .top
            } else if indexPath.row == memberCount - 1 {
                cornerStyle = .bottom
            } else {
                cornerStyle = .none
            }
            
            cell.configureAsPerson(name: member.name, status: member.status, role: member.role, cornerStyle: cornerStyle)
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section > 0 else { return nil }
        
        let headerView = UIView()
        let label = UILabel(frame: CGRect(x: 16, y: 0, width: tableView.bounds.width - 32, height: 40))
        label.font = theme?.onestFont(size: 13, weight: .regular)
        label.textColor = theme?.contentSecondary
        label.text = section == 1 ? "ADMINS" : "MEMBERS"
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section > 0 ? 40 : 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            presentAddMembersFloating()
        }
    }
}
