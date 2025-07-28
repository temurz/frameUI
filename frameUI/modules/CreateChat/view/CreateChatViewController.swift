//
//  CreateChatViewController.swift
//  Tedr
//
//  Created by Temur on 09/07/2025.
//  
//

import UIKit

enum CreateChatStep: Int {
    case newMessage
    case addMembers
    case createGroup
}

class CreateChatViewController: TemplateController {
    var navigationBar: CreateChatNavigationBar?
    var mainView: NewMessageView?
    var addMembersView: AddMembersView?
    var createGroupNameView: CreateGroupNameView?
    
    private var currentStep: CreateChatStep = .newMessage
    private var contactSections = [ContactSection]()

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func initialize() {
        self.view.backgroundColor = theme.backgroundTertiaryColor
        
        mainView = NewMessageView()
        mainView?.setTableViewDataSourceAndDelegate(self)
        mainView?.newGroupAction = { [weak self] in
            guard let self else { return }
            transition(to: .addMembers, direction: .forward)
            addMembersView?.reloadTableViewData()
        }
        self.view.addSubview(mainView)
        
        navigationBar = CreateChatNavigationBar()
        navigationBar?.didSelectBackButton = { [weak self] in
            guard let self else { return }
            switch currentStep {
            case .newMessage:
                self.dismiss(animated: true)
            case .addMembers:
                transition(to: .newMessage, direction: .backward)
            case .createGroup:
                transition(to: .addMembers, direction: .backward)
            }
        }
        navigationBar?.didSelectNextButton = { [weak self] in
            guard let self else { return }
            switch currentStep {
            case .newMessage:
                break
            case .addMembers:
                transition(to: .createGroup, direction: .forward)
                let selectedMembers = contactSections.flatMap { $0.contacts.filter { $0.isSelected } }
                createGroupNameView?.setMembers(selectedMembers)
            case .createGroup:
                dismiss(animated: true) { [weak self] in
                    self?.presenter?.startChat()
                }
                
            }
        }
        self.view.addSubview(navigationBar)

        addMembersView = AddMembersView()
        addMembersView?.setTableViewDataSourceAndDelegate(self)
        addMembersView?.isHidden = true
        self.view.addSubview(addMembersView)
        
        createGroupNameView = CreateGroupNameView()
        createGroupNameView?.isHidden = true
        self.view.addSubview(createGroupNameView)
    }
    
    override func updateSubviewsFrames(_ size: CGSize) {
        
        navigationBar?.frame = .init(x: 0, y: 16, width: size.width, height: 64)
        
        let y = navigationBar?.frame.maxY ?? 60
        let h = size.height - y
        
        let views = [mainView, addMembersView, createGroupNameView]
        for v in views {
            v?.frame = .init(x: 0, y: y, width: size.width, height: h)
        }
    }
    
    func transition(to step: CreateChatStep, direction: TransitionDirection) {
        guard currentStep != step else { return }
        
        let fromView = viewForStep(currentStep)
        let toView = viewForStep(step)
        
        let width = view.bounds.width
        let y = navigationBar?.frame.maxY ?? 60
        let h = view.bounds.height - y
        
        // Set starting frame for incoming view
        let offset = direction == .forward ? width : -width
        toView?.frame = CGRect(x: offset, y: y, width: width, height: h)
        toView?.isHidden = false
        
        UIView.animate(withDuration: 0.3, animations: {
            fromView?.frame = fromView?.frame.offsetBy(dx: -offset, dy: 0) ?? .zero
            toView?.frame = CGRect(x: 0, y: y, width: width, height: h)
        }, completion: { [weak self] _ in
            guard let self else { return }
            fromView?.isHidden = true
            currentStep = step
            navigationBar?.updateNavBar(step: step)
            switch currentStep {
            case .newMessage:
                mainView?.reloadTableViewData()
            case .addMembers:
                addMembersView?.reloadTableViewData()
            case .createGroup:
                createGroupNameView?.setMembers(contactSections.flatMap({ $0.contacts.filter { $0.isSelected } }))
            }
        })
        
        
    }
    
    private func viewForStep(_ step: CreateChatStep) -> UIView? {
        switch step {
        case .newMessage:
            return mainView
        case .addMembers:
            return addMembersView
        case .createGroup:
            return createGroupNameView
        }
    }
    
    enum TransitionDirection {
        case forward  // right-to-left (Next)
        case backward // left-to-right (Back)
    }

    // MARK: - Properties
    var presenter: ViewToPresenterCreateChatProtocol?
    
}

extension CreateChatViewController: PresenterToViewCreateChatProtocol {
    func showContacts(_ sections: [ContactSection]) {
        self.contactSections = sections
        mainView?.reloadTableViewData()
    }
}

extension CreateChatViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let label = UILabel()
        label.text = contactSections[section].title
        label.textColor = theme.contentSecondary
        
        let w = label.getWidth()
        label.frame = .init(x: 16, y: 0, width: w, height: label.textHeight(w))
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return contactSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactSections[section].contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.identifier, for: indexPath) as? ContactCell {
            let section = contactSections[indexPath.section]
            let item = section.contacts[indexPath.row]
            cell.configureCell(model: item, isSelectable: currentStep == .addMembers)
            cell.didSelectCheckMark = {
                item.isSelected = !item.isSelected
                print(section)
            }
            return cell
        }
        return .init()
    }
}
