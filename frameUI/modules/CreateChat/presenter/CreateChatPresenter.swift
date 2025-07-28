//
//  CreateChatPresenter.swift
//  Tedr
//
//  Created by Temur on 09/07/2025.
//  
//

import Foundation

class CreateChatPresenter: ViewToPresenterCreateChatProtocol {

    // MARK: Properties
    weak var view: PresenterToViewCreateChatProtocol?
    var interactor: PresenterToInteractorCreateChatProtocol?
    var router: PresenterToRouterCreateChatProtocol?
    weak var delegate: CreateChatModalViewDelegate?
    
    func viewDidLoad() {
        interactor?.fetchContacts()
    }
    
    func startChat() {
        delegate?.createChat()
    }
}

extension CreateChatPresenter: InteractorToPresenterCreateChatProtocol {
    func didFetchContacts(_ sections: [ContactSection]) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            view?.showContacts(sections)
        }
    }
}
