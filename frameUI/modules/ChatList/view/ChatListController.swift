//
//  ChatListController.swift
//  Tedr
//
//  Created by Kostya Lee on 03/06/25.
//

import Foundation
import UIKit
final class ChatListController: TemplateController {
    var presenter: ViewToPresenterChatListProtocol?
    private var mainView: ChatListView?

    private var previousScrollOffset: CGFloat = 0

    private let messageProvider = MessageProvider(items: [])
    
    var isReordering = false {
        didSet {
            setReorderingState(isReordering)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func initialize() {
        mainView = ChatListView()
        mainView?.tableView?.delegate = self
        mainView?.tableView?.dataSource = self
        mainView?.tableView?.register(ChatListCell.self, forCellReuseIdentifier: ChatListCell.reuseId)
        mainView?.tableView?.register(SearchResultCell.self, forCellReuseIdentifier: SearchResultCell.reuseId)
        
        mainView?.navigationView?.setCollectionDelegate(self)
        
        mainView?.stateHasChange = { [weak self] state in
            guard let self else { return }
            switch state {
            case .search:
                presenter?.didSearch(with: "")
            default:
                mainView?.tableView?.reloadData()
            }
        }
        
        mainView?.navigationView?.didSearchWithText = { [weak self] text in
            guard let self else { return }
            presenter?.didSearch(with: text)
        }
        
        mainView?.navigationView?.addButtonAction = { [weak self] in
            guard let self else { return }
            presenter?.showAddChat(controller: self)
        }
        
        mainView?.cancelReorderAction = { [weak self] in
            guard let self else { return }
            isReordering = false
        }
        
        mainView?.finishReorderAction = { [weak self] in
            guard let self else { return }
            isReordering = false
        }
        
        self.view.addSubview(mainView!)
    }

    override func updateSubviewsFrames(_ size: CGSize) {
        mainView?.frame = view.bounds
    }
}

extension ChatListController: PresenterToViewChatListProtocol {
    func showFocusedChat(_ messages: [ChatMessageRow]) {
        messageProvider.items = messages
        mainView?.showFocusedChat(with: messageProvider)
        
    }
    
    func showChats(_ chats: [Chat]) {
        mainView?.tableView?.reloadData()
    }
    
    func showSearchResult(_ result: [SearchResultSection : [ChatSearchResult]]) {
        mainView?.tableView?.reloadData()
    }

    func showStories(_ stories: [Story]) {
        
    }

    func showConfig(_ config: String) {}

    func showError(_ error: String) {}
    
    private func setReorderingState(_ bool: Bool) {
        mainView?.tableView?.dragInteractionEnabled = bool
        mainView?.tableView?.dropDelegate = bool ? self : nil
        mainView?.tableView?.dragDelegate = bool ? self : nil
        mainView?.tableView?.reloadData()
        mainView?.setReorderingState(bool)
    }
}

extension ChatListController: UITableViewDataSource, UITableViewDelegate {
    
    var availableSections: [SearchResultSection] {
        SearchResultSection.allCases.filter { !(presenter?.searchResult[$0]?.isEmpty ?? true) }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if (mainView?.isSearchResultHidden ?? true) {
            mainView?.emptyListLabel?.isHidden = !(presenter?.chats.isEmpty ?? true)
            return 1
        } else {
            let count = availableSections.count
            mainView?.emptyListLabel?.isHidden = count != 0
            return count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (mainView?.isSearchResultHidden ?? true) {
            return presenter?.chats.count ?? 0
        } else {
            let sectionType = availableSections[section]
            return presenter?.searchResult[sectionType]?.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter else {
            return UITableViewCell()
        }
        
        if (mainView?.isSearchResultHidden ?? true), let cell = tableView.dequeueReusableCell(withIdentifier: ChatListCell.reuseId, for: indexPath) as? ChatListCell {
            let chat = presenter.chats[indexPath.row]
            cell.configure(with: chat, isReordering: isReordering)
            if cell.gestureRecognizers?.contains(where: { $0 is UILongPressGestureRecognizer }) != true {
                cell.addLongPressGesture { [weak self] _ in
                    self?.handleLongGesture(chat)
                }
            }
            return cell
        }
        
        let sectionType = availableSections[indexPath.section]
        if !(mainView?.isSearchResultHidden ?? true),
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.reuseId, for: indexPath) as? SearchResultCell,
           let searchResult = presenter.searchResult[sectionType]?[indexPath.row] {
            cell.configure(searchResult)
            return cell
        }
        return .init()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionType = availableSections[section]
        
        let label = UILabel()
        label.text = sectionType.rawValue
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .lightGray

        let view = UIView()
        view.addSubview(label)
        var w = label.text?.width(label.font) ?? 100
        label.frame = CGRect(x: 16, y: 0, width: w, height: 28)
        
        if sectionType == .recent {
            let font = theme.onestFont(size: 13, weight: .regular)
            
            let clearButton = UIButton()
            clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
            clearButton.setTitle("Clear", for: .normal)
            clearButton.setTitleColor(theme.contentSecondary, for: .normal)
            
            clearButton.titleLabel?.font = font
            view.addSubview(clearButton)
            
            w = clearButton.titleLabel?.text?.width(font) ?? 100
            clearButton.frame = .init(x: self.view.size.width - w - 16, y: 0, width: w, height: 28)
        }
        
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if mainView?.isSearchResultHidden ?? true {
            return 0
        } else {
            return 28
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        ChatListCell.getHeight()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let navigationView = mainView?.navigationView else { return }
        
        let currentOffset = scrollView.contentOffset.y
        let isScrollingUp = currentOffset > previousScrollOffset
        let isScrollingDown = currentOffset < previousScrollOffset
        
        if navigationView.state != .search {
            if isScrollingUp && currentOffset > 20 {
                navigationView.setState(.collapsed)
            } else if isScrollingDown && currentOffset <= 0 {
                navigationView.setState(.expanded)
            }
        }
        
        previousScrollOffset = currentOffset
    }
    
    @objc private func clearButtonTapped() {
        showAlert(title: "", message: "Do you want to clear your search history?", primaryTitle: "Clear all", icon: "clear", isCentered: false, secondaryTitle: Strings.cancel)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.navigateToChat(from: self, index: indexPath.row)
    }
    
    private func handleLongGesture(_ chat: Chat) {
        presenter?.showPreviewChat(from: chat)
    }
}

// MARK: SwipeActions
extension ChatListController {
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let theme = Theme()
        
        let pin = UIContextualAction(style: .normal, title: nil) { _, _, completion in
            print("Pin tapped")
            completion(true)
        }
        pin.image = theme.pinIcon?.changeColor(theme.contentPink)
        pin.backgroundColor = theme.pinActionBackground

        let markRead = UIContextualAction(style: .normal, title: nil) { _, _, completion in
            print("Mark as read tapped")
            completion(true)
        }
        markRead.image = theme.readIcon?.changeColor(theme.contentBlue)
        markRead.backgroundColor = theme.readActionBackground

        let reorder = UIContextualAction(style: .normal, title: nil) { [weak self] _, _, completion in
            print("Reorder tapped")
            self?.isReordering = true
            completion(true)
        }
        reorder.image = theme.reorderIcon?.changeColor(theme.contentTurquoise)
        reorder.backgroundColor = theme.reorderActionBackground

        let config = UISwipeActionsConfiguration(actions: [pin, reorder, markRead])
        config.performsFirstActionWithFullSwipe = false
        return config
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: nil) { _, _, completion in
            print("Delete tapped")
            completion(true)
        }
        delete.image = theme.trashIcon?.changeColor(theme.contentRed)
        delete.backgroundColor = theme.trashActionBackground

        let mute = UIContextualAction(style: .normal, title: nil) { _, _, completion in
            print("Mute tapped")
            completion(true)
        }
        mute.image = theme.muteIcon?.changeColor(theme.contentYellow)
        mute.backgroundColor = theme.muteActionBackground

        let config = UISwipeActionsConfiguration(actions: [delete, mute])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
}

extension ChatListController: UITableViewDragDelegate, UITableViewDropDelegate {
    func tableView(_ tableView: UITableView,
                   itemsForBeginning session: UIDragSession,
                   at indexPath: IndexPath) -> [UIDragItem] {
        guard let presenter else { return [] }
        
        let chat = presenter.chats[indexPath.row]
        
        guard chat.isPinned else {
            return []
        }
        
        let itemProvider = NSItemProvider(object: NSString(string: chat.id)) // unique id or name
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = chat
        return [dragItem]
    }
    
    func tableView(_ tableView: UITableView,
                   performDropWith coordinator: UITableViewDropCoordinator) {
        guard let presenter else { return }
        guard coordinator.proposal.operation == .move,
              let item = coordinator.items.first,
              let sourceIndexPath = item.sourceIndexPath else { return }
        
        let destinationIndexPath = coordinator.destinationIndexPath ?? IndexPath(row: presenter.chats.count - 1, section: 0)
        
        let sourceChat = presenter.chats[sourceIndexPath.row]
        let destinationChat = presenter.chats[destinationIndexPath.row]
        
        guard sourceChat.isPinned && destinationChat.isPinned else {
            return
        }
        
        tableView.performBatchUpdates {
            let movedChat = presenter.chats.remove(at: sourceIndexPath.row)
            presenter.chats.insert(movedChat, at: destinationIndexPath.row)
            tableView.moveRow(at: sourceIndexPath, to: destinationIndexPath)
        }
        
        coordinator.drop(item.dragItem, toRowAt: destinationIndexPath)
    }
    
    func tableView(_ tableView: UITableView,
                   dropSessionDidUpdate session: UIDropSession,
                   withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        if presenter?.chats[destinationIndexPath?.row ?? 0].isPinned ?? false {
            return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UITableViewDropProposal(operation: .forbidden)
    }
}

extension ChatListController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.stories.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let presenter, let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatListStoryCell.reuseId, for: indexPath) as? ChatListStoryCell else {
            return UICollectionViewCell()
        }
        let item = presenter.stories[indexPath.item]
        cell.configure(item: item)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        ChatListStoryCell.getSize()
    }
}

extension ChatListController: CreateChatModalViewDelegate {
    func createChat() {
        print("Send create chat request")
    }
}
