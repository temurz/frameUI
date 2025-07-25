//
//  PermissionsViewController.swift
//  frameUI
//
//  Created by Nuriddinov Subkhiddin on 22/07/25.
//

import UIKit

class PermissionsViewController: UIViewController {
    
    private let theme = PurpleTheme()

    private let backButton = UIButton(type: .system)
    private let titleLabel = UILabel()
    
    private let groupPermissionsTitleLabel = UILabel()
    private let groupPermissionsBackgroundView = UIView()
    private let sendMessagesLabel = UILabel()
    private let sendMessagesSwitch = UISwitch()
    private let addMembersLabel = UILabel()
    private let addMembersSwitch = UISwitch()
    private let pinMessagesLabel = UILabel()
    private let pinMessagesSwitch = UISwitch()
    private let changeGroupInfoLabel = UILabel()
    private let changeGroupInfoSwitch = UISwitch()

    private let chatHistoryTitleLabel = UILabel()
    private let chatHistoryBackgroundView = UIView()
    private let showHistoryLabel = UILabel()
    private let showHistorySwitch = UISwitch()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = theme.backgroundPrimaryColor
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let sidePadding: CGFloat = 16.0
        let extraTitleInset: CGFloat = 16.0
        let rowHeight: CGFloat = 56.0
        let contentWidth = view.bounds.width - (sidePadding * 2)
        let safeY = view.safeAreaInsets.top
        var currentY: CGFloat = safeY + 10
        
        titleLabel.frame = CGRect(x: 0, y: currentY, width: view.bounds.width, height: 22)
        backButton.frame = CGRect(x: sidePadding, y: currentY, width: 22, height: 22)
        currentY += 22 + 28
        
        groupPermissionsTitleLabel.frame = CGRect(
            x: sidePadding + extraTitleInset,
            y: currentY,
            width: contentWidth - extraTitleInset,
            height: 16
        )
        currentY += 16 + 12
        
        groupPermissionsBackgroundView.frame = CGRect(
            x: sidePadding,
            y: currentY,
            width: contentWidth,
            height: rowHeight * 4
        )

        var internalY: CGFloat = 0
        layoutRow(in: groupPermissionsBackgroundView, y: &internalY, height: rowHeight, label: sendMessagesLabel, aSwitch: sendMessagesSwitch)
        layoutRow(in: groupPermissionsBackgroundView, y: &internalY, height: rowHeight, label: addMembersLabel, aSwitch: addMembersSwitch)
        layoutRow(in: groupPermissionsBackgroundView, y: &internalY, height: rowHeight, label: pinMessagesLabel, aSwitch: pinMessagesSwitch)
        layoutRow(in: groupPermissionsBackgroundView, y: &internalY, height: rowHeight, label: changeGroupInfoLabel, aSwitch: changeGroupInfoSwitch)

        currentY = groupPermissionsBackgroundView.frame.maxY + 30

        chatHistoryTitleLabel.frame = CGRect(
            x: sidePadding + extraTitleInset,
            y: currentY,
            width: contentWidth - extraTitleInset,
            height: 16
        )
        currentY += 16 + 12

        chatHistoryBackgroundView.frame = CGRect(
            x: sidePadding,
            y: currentY,
            width: contentWidth,
            height: rowHeight
        )

        internalY = 0
        layoutRow(in: chatHistoryBackgroundView, y: &internalY, height: rowHeight, label: showHistoryLabel, aSwitch: showHistorySwitch)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func setupUI() {
        let backImage = UIImage(systemName: "chevron.left")?.withConfiguration(UIImage.SymbolConfiguration(weight: .semibold))
        backButton.setImage(backImage, for: .normal)
        backButton.tintColor = .white

        titleLabel.text = "Permissions"
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textAlignment = .center
        
        setupSectionTitle(groupPermissionsTitleLabel, text: "WHAT EVERYONE IN THE GROUP CAN DO")
        setupBackgroundView(groupPermissionsBackgroundView)
        setupRow(label: sendMessagesLabel, text: "Send messages", aSwitch: sendMessagesSwitch, isOn: true)
        setupRow(label: addMembersLabel, text: "Add members", aSwitch: addMembersSwitch, isOn: true)
        setupRow(label: pinMessagesLabel, text: "Pin messages", aSwitch: pinMessagesSwitch, isOn: true)
        setupRow(label: changeGroupInfoLabel, text: "Change group info", aSwitch: changeGroupInfoSwitch, isOn: false)
        
        setupSectionTitle(chatHistoryTitleLabel, text: "CHAT HISTORY")
        setupBackgroundView(chatHistoryBackgroundView)
        setupRow(label: showHistoryLabel, text: "Show to new members", aSwitch: showHistorySwitch, isOn: true)
        
        [backButton, titleLabel,
         groupPermissionsTitleLabel, groupPermissionsBackgroundView,
         chatHistoryTitleLabel, chatHistoryBackgroundView
        ].forEach { view.addSubview($0) }

        [sendMessagesLabel, sendMessagesSwitch,
         addMembersLabel, addMembersSwitch,
         pinMessagesLabel, pinMessagesSwitch,
         changeGroupInfoLabel, changeGroupInfoSwitch
        ].forEach { groupPermissionsBackgroundView.addSubview($0) }

        [showHistoryLabel, showHistorySwitch].forEach { chatHistoryBackgroundView.addSubview($0) }
    }

    private func setupBackgroundView(_ backgroundView: UIView) {
        backgroundView.backgroundColor = theme.backgroundThirdColor
        backgroundView.layer.cornerRadius = 16
        backgroundView.clipsToBounds = true
    }

    private func setupSectionTitle(_ label: UILabel, text: String) {
        label.text = text
        label.textColor = theme.contentSecondary
        label.font = .systemFont(ofSize: 13, weight: .regular)
    }

    private func setupRow(label: UILabel, text: String, aSwitch: UISwitch, isOn: Bool) {
        label.text = text
        label.textColor = .white
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        aSwitch.isOn = isOn
        aSwitch.onTintColor = UIColor(hex: "#4D78DE")
    }

    private func layoutRow(in container: UIView, y: inout CGFloat, height: CGFloat, label: UILabel, aSwitch: UISwitch) {
        let padding: CGFloat = 20
        let switchSize = aSwitch.sizeThatFits(.zero)
        let width = container.bounds.width
        let labelWidth = width - padding * 2 - switchSize.width - 8

        label.frame = CGRect(x: padding, y: y, width: labelWidth, height: height)
        let switchX = width - switchSize.width - padding
        let switchY = y + (height - switchSize.height) / 2
        aSwitch.frame = CGRect(x: switchX, y: switchY, width: switchSize.width, height: switchSize.height)
        y += height
    }
}
