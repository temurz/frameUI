//
//  ChatListPresenter.swift
//  Tedr
//
//  Created by Kostya Lee on 03/06/25.
//

import UIKit
final class ChatListPresenter: ViewToPresenterChatListProtocol {
    weak var view: PresenterToViewChatListProtocol?
    var interactor: PresenterToInteractorChatListProtocol?
    var router: PresenterToRouterChatListProtocol?

    var chats: [Chat] = []
    var stories: [Story] = []
    var searchResult: [SearchResultSection: [ChatSearchResult]] = [:]

    func viewDidLoad() {
        interactor?.fetchChats()
        interactor?.fetchStories()
        interactor?.fetchAppConfig()
    }

    func navigateToChat(from: ChatListController, index: Int) {
        guard let view = view as? ChatListController else { return }
        router?.navigateToChat(from: view, chat: chats[index])
    }
    
    func didSearch(with text: String) {
        interactor?.fetchSearchResult(text)
    }
    
    func showPreviewChat(from chat: Chat) {
        interactor?.fetchMessages(for: chat)
    }
    
    func showAddChat(controller: ChatListController) {
        router?.navigateToCreateChat(controller: controller)
    }
}

extension ChatListPresenter: InteractorToPresenterChatListProtocol {
    func didFetchMessages(_ messages: [ChatMessageRow]) {
        view?.showFocusedChat(messages)
    }
    
    func didFetchChats(_ chats: [Chat]) {
        self.chats = chats
        view?.showChats(chats)
    }
    
    func didFetchSearchResult(_ result: [SearchResultSection: [ChatSearchResult]]) {
        self.searchResult = result
        view?.showSearchResult(result)
    }

    func didFetchStories(_ stories: [Story]) {
        self.stories = stories
        view?.showStories(stories)
    }

    func didFetchAppConfig(_ config: String) {
        view?.showConfig(config)
    }

    func didFail(with error: String) {
        view?.showError(error)
    }
}

