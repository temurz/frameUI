//
//  CreateGroupNameView.swift
//  Tedr
//
//  Created by Temur on 09/07/2025.
//

import UIKit

class CreateGroupNameView: TemplateView {
    private let avatarButton = UIButton()
    private let cameraImageView = UIImageView()
    private let groupNameTextField = UITextField()
    private let descriptionLabel = UILabel()
    private let descriptionTextField = UITextField()
    private let descriptionBgView = UIView()
    private let membersCountLabel = UILabel()
    private let tableView = UITableView()
    
    private var items = [Contact]()
    
    override func initialize() {
        let theme = theme ?? Theme()
        
        avatarButton.backgroundColor = UIColor(hex: "#8D5FF0")
        self.addSubview(avatarButton)
        
        cameraImageView.image = theme.photoIcon
        avatarButton.addSubview(cameraImageView)
        
        groupNameTextField.attributedPlaceholder = NSAttributedString(string: "Group name", attributes: [
            .font : UIFont.onest(.semiBold, size: 24),
            .foregroundColor: theme.contentPrimary.withAlphaComponent(0.6)
        ])
        groupNameTextField.textAlignment = .center
        groupNameTextField.font = .onest(.semiBold, size: 24)
        groupNameTextField.textColor = theme.contentPrimary
        self.addSubview(groupNameTextField)
        
        descriptionLabel.text = "Description"
        descriptionLabel.font = .onest(size: 14)
        descriptionLabel.textColor = theme.contentPrimary
        self.addSubview(descriptionLabel)
        
        self.addSubview(descriptionBgView)
        
        descriptionTextField.setLeftPaddingPoints(16)
        descriptionTextField.setRightPaddingPoints(16)
        
        descriptionTextField.attributedPlaceholder = NSAttributedString(
            string: "Enter group description",
            attributes: [ .foregroundColor: theme.contentSecondary ]
        )
        descriptionTextField.textColor = theme.contentPrimary
        descriptionTextField.font = .onest(size: 14)
        self.addSubview(descriptionTextField)
        
        membersCountLabel.text = "4 MEMBERS"
        membersCountLabel.textColor = theme.contentSecondary
        membersCountLabel.font = .onest(size: 13)
        self.addSubview(membersCountLabel)
        
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.rowHeight = 72
        tableView.register(ContactCell.self, forCellReuseIdentifier: ContactCell.identifier)
        self.addSubview(tableView)
    }
    
    override func updateSubviewsFrame(_ size: CGSize) {
        let padding = CGFloat(16)
        let avatarHeight: CGFloat = 80
        var w = avatarHeight
        var h = w
        var y = padding
        var x = (size.width - w) / 2
        self.avatarButton.frame = .init(x: x, y: y, width: w, height: h)
        avatarButton.borderRadius = h/2
        
        w = 32
        h = 32
        x = (avatarHeight - w) / 2
        y = x
        self.cameraImageView.frame = .init(x: x, y: y, width: w, height: h)
        
        w = size.width - (padding * 4)
        h = 32
        x = (size.width - w) / 2
        y = avatarButton.maxY + padding
        self.groupNameTextField.frame = .init(x: x, y: y, width: w, height: h)
        
        x = padding
        y = groupNameTextField.maxY + padding
        w = descriptionLabel.getWidth()
        h = descriptionLabel.textHeight(w)
        self.descriptionLabel.frame = .init(x: x, y: y, width: w, height: h)
        
        y = descriptionLabel.maxY + padding
        w = size.width - (padding*2)
        h = 52
        self.descriptionTextField.frame = .init(x: x, y: y, width: w, height: h)
        descriptionTextField.borderRadius = 16
        
        self.descriptionBgView.frame = .init(x: x, y: y, width: w, height: h)
        descriptionBgView.applyBlur()
        descriptionBgView.borderRadius = 16
        
        x = padding
        y = descriptionTextField.maxY + padding
        w = size.width - (padding*2)
        h = membersCountLabel.textHeight(w)
        self.membersCountLabel.frame = .init(x: x, y: y, width: w, height: h)
        
        w = size.width
        h = size.height - membersCountLabel.maxY
        y = membersCountLabel.maxY + padding
        x = 0
        self.tableView.frame = .init(x: x, y: y, width: w, height: h)
    }
    
    func setMembers(_ contacts: [Contact]) {
        self.items = contacts
        membersCountLabel.text = "\(contacts.count) MEMBERS"
        tableView.reloadData()
    }
}

extension CreateGroupNameView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.identifier) as? ContactCell {
            let model = items[indexPath.row]
            cell.configureCell(model: model)
            return cell
        }
        return .init()
    }
}
