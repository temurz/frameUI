//
//  Router.swift
//  Tedr
//
//  Created by Kostya Lee on 03/06/25.
//

import UIKit
final class ChatListRouter: PresenterToRouterChatListProtocol {
    static func createModule() -> ChatListController {
        let view = ChatListController() // пока не определен
        let presenter = ChatListPresenter()
        let interactor = ChatListInteractor()
        let router = ChatListRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter

        return view
    }

    func navigateToChat(from vc: ChatListController, chat: Chat) {
        let chatVC = ChatRouter.createModule(with: chat)
        vc.navigationController?.pushViewController(chatVC, animated: true)
    }
    
    func navigateToCreateChat(controller: ChatListController) {
        let createChatVC = CreateChatRouter.createModule(delegate: controller)
        controller.present(createChatVC, animated: true)
    }
}
