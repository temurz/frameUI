//
//  ChatRouter.swift
//  Tedr
//
//  Created by Kostya Lee on 11/06/25.
//

import UIKit
final class ChatRouter: PresenterToRouterChatProtocol {
    static func createModule(with chat: Chat) -> ChatController {
        let controller = ChatController()
        let presenter = ChatPresenter(chat: chat)
        let interactor = ChatInteractor()
        let router = ChatRouter()
        
        controller.presenter = presenter
        presenter.view = controller
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return controller
    }
    
    func popViewController(navigationController: UINavigationController?) {
        navigationController?.popViewController(animated: true)
    }
    
    func present(viewController: UIViewController, from vc: UIViewController) {
        viewController.modalPresentationStyle = .overCurrentContext
        vc.present(viewController, animated: true)
    }
}
