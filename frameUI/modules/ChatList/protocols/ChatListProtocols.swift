//
//  ChatListProtocols.swift
//  Tedr
//
//  Created by Kostya Lee on 03/06/25.
//

import Foundation
import UIKit

// MARK: View <-> Presenter
protocol ViewToPresenterChatListProtocol: AnyObject {
    var view: PresenterToViewChatListProtocol? { get set }
    var interactor: PresenterToInteractorChatListProtocol? { get set }
    var router: PresenterToRouterChatListProtocol? { get set }

    var chats: [Chat] { get set }
    var stories: [Story] { get set }
    var searchResult: [SearchResultSection: [ChatSearchResult]] { get set }
    
    func viewDidLoad()
    func didSearch(with text: String)
    func navigateToChat(from view: ChatListController, index: Int)
    func showPreviewChat(from chat: Chat)
    func showAddChat(controller: ChatListController)
}

protocol PresenterToViewChatListProtocol: AnyObject {
    func showFocusedChat(_ messages: [ChatMessageRow])
    func showChats(_ chats: [Chat])
    func showSearchResult(_ result: [SearchResultSection: [ChatSearchResult]])
    func showStories(_ stories: [Story])
    func showConfig(_ config: String)
    func showError(_ error: String)
}

// MARK: Presenter <-> Interactor
protocol PresenterToInteractorChatListProtocol: AnyObject {
    var presenter: InteractorToPresenterChatListProtocol? { get set }

    func fetchChats()
    func fetchSearchResult(_ text: String)
    func fetchStories()
    func fetchAppConfig()
    func fetchMessages(for chat: Chat)
}

protocol InteractorToPresenterChatListProtocol: AnyObject {
    func didFetchMessages(_ messages: [ChatMessageRow])
    func didFetchChats(_ chats: [Chat])
    func didFetchSearchResult(_ result: [SearchResultSection: [ChatSearchResult]])
    func didFetchStories(_ stories: [Story])
    func didFetchAppConfig(_ config: String)
    func didFail(with error: String)
}

// MARK: Presenter <-> Router
protocol PresenterToRouterChatListProtocol: AnyObject {
    static func createModule() -> ChatListController
    func navigateToChat(from vc: ChatListController, chat: Chat)
    func navigateToCreateChat(controller: ChatListController)
}
