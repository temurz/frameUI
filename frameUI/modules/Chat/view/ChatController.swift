//
//  ChatController.swift
//  Tedr
//
//  Created by Kostya Lee on 11/06/25.
//

import Foundation
import UIKit
final class ChatController: TemplateController {
    var presenter: ViewToPresenterChatProtocol?
    private var mainView: ChatView?
    private var displayedMessages: [ChatMessageRow] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }

    override func initialize() {
        mainView = ChatView()
        mainView?.tableView?.delegate = self
        mainView?.tableView?.dataSource = self
//        mainView?.inputPanel?.setInputDelegate(self)
        mainView?.tableView?.register(ChatCell.self, forCellReuseIdentifier: ChatCell.reuseId)
        view.addSubview(mainView!)
        
        mainView?.navigationView?.backAction = { [weak self] in
            guard let self else { return }
            presenter?.popViewController(navigationController: navigationController)
        }
        
        mainView?.navigationView?.didSearchWithText = { [weak self] text in
            guard let self else { return }
            presenter?.didSearchText(text)
        }
        
        mainView?.navigationView?.callAction = { [weak self] in
            guard let self else { return }
            presenter?.didTapCall(controller: self)
        }
        
        mainView?.navigationView?.profileAction = { [weak self] in
            
        }
    }

    override func updateSubviewsFrames(_ size: CGSize) {
        mainView?.frame = view.bounds
    }
}

extension ChatController: PresenterToViewChatProtocol {
    func showMessages(_ messages: [ChatMessageRow]) {
        self.displayedMessages = messages
        mainView?.tableView?.reloadData()
    }
    
    func updateSearchResultText(text: String) {
        mainView?.updateSearchResultLabel(text)
    }
}

extension ChatController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        displayedMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatCell.reuseId, for: indexPath) as? ChatCell else {
            return UITableViewCell()
        }
        cell.configure(with: displayedMessages[indexPath.row])
        cell.transform = CGAffineTransform(scaleX: 1, y: -1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        getCellHeight(index: indexPath.row)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        mainView?.endEditing(true)
    }
    
    private func getCellHeight(index: Int) -> CGFloat {
        let message = displayedMessages[index]
        
        switch message.content {
        case .text(let text):
            let horizontalPadding: CGFloat = 12
            let verticalPadding: CGFloat = 6
            let timeHeight: CGFloat = 16

            guard let maxWidth = mainView?.tableView?.bounds.width else { return 44 }
            let maxBubbleWidth = maxWidth * 0.85
            let timeLabelWidth: CGFloat = message.isIncoming ? 70 : 85
            let availableTextWidth = maxBubbleWidth - horizontalPadding * 2 - timeLabelWidth

            let font = ChatMessageTextView.getTextFont()
            let constraintBox = CGSize(width: availableTextWidth, height: CGFloat.greatestFiniteMagnitude)

            let boundingBox = text.text.boundingRect(
                with: constraintBox,
                options: .usesLineFragmentOrigin,
                attributes: [.font: font],
                context: nil
            )

            let textHeight = ceil(boundingBox.height)
            return textHeight + verticalPadding * 2 + timeHeight
        case .transaction:
            return 130
        default:
            return 44 // дефолт
        }
    }

}

extension ChatController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
}
