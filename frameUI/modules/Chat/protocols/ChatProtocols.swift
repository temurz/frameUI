//
//  ChatProtocols.swift
//  Tedr
//
//  Created by Kostya Lee on 11/06/25.
//

import Foundation
import UIKit
protocol ViewToPresenterChatProtocol: AnyObject {
    var messages: [ChatMessageRow] { get }
    func viewDidLoad()
    func popViewController(navigationController: UINavigationController?)
    func didSearchText(_ text: String)
    func didTapCall(controller: UIViewController)
}

protocol PresenterToViewChatProtocol: AnyObject {
    func showMessages(_ messages: [ChatMessageRow])
    func updateSearchResultText(text: String)
}

protocol PresenterToInteractorChatProtocol: AnyObject {
    func fetchMessages()
}

protocol InteractorToPresenterChatProtocol: AnyObject {
    func didFetchMessages(_ messages: [ChatMessageRow])
}

protocol PresenterToRouterChatProtocol: AnyObject {
    static func createModule(with chat: Chat) -> ChatController
    func popViewController(navigationController: UINavigationController?)
    func present(viewController: UIViewController, from vc: UIViewController)
}
