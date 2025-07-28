//
//  ChatPresenter.swift
//  Tedr
//
//  Created by Kostya Lee on 11/06/25.
//

import UIKit
final class ChatPresenter: ViewToPresenterChatProtocol {
    weak var view: PresenterToViewChatProtocol?
    var interactor: PresenterToInteractorChatProtocol?
    var router: PresenterToRouterChatProtocol?
    
    private(set) var messages: [ChatMessageRow] = []
    private let chat: Chat

    init(chat: Chat) {
        self.chat = chat
    }

    func viewDidLoad() {
        interactor?.fetchMessages()
    }
    
    func popViewController(navigationController: UINavigationController?) {
        router?.popViewController(navigationController: navigationController)
    }
    
    func didSearchText(_ text: String) {
        guard !text.isEmpty else {
            view?.showMessages(messages)
            view?.updateSearchResultText(text: "")
            return
        }

        // Поиск в текстовом контенте
        let result = messages.filter {
            if case let .text(textContent) = $0.content {
                return textContent.text.lowercased().contains(text.lowercased())
            }
            return false
        }

        var searchResultText = ""

        if result.isEmpty {
            searchResultText = "No results"
        } else {
            searchResultText = "Found \(result.count) of \(messages.count)"
        }

        view?.showMessages(result)
        view?.updateSearchResultText(text: searchResultText)
    }
    
    func didTapCall(controller: UIViewController) {
        
    }
}

extension ChatPresenter: InteractorToPresenterChatProtocol {
    func didFetchMessages(_ messages: [ChatMessageRow]) {
        self.messages = messages
        view?.showMessages(messages)
    }
}
