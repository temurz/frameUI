//
//  CreateChatProtocols.swift
//  Tedr
//
//  Created by Temur on 09/07/2025.
//  
//

import Foundation

protocol CreateChatModalViewDelegate: AnyObject {
    func createChat()
}


// MARK: View Output (Presenter -> View)
protocol PresenterToViewCreateChatProtocol: AnyObject {
    func showContacts(_ sections: [ContactSection])
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterCreateChatProtocol {
    
    var view: PresenterToViewCreateChatProtocol? { get set }
    var interactor: PresenterToInteractorCreateChatProtocol? { get set }
    var router: PresenterToRouterCreateChatProtocol? { get set }
    var delegate: CreateChatModalViewDelegate? { get set }

    func viewDidLoad()
    func startChat()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorCreateChatProtocol {
    
    var presenter: InteractorToPresenterCreateChatProtocol? { get set }
    
    func fetchContacts()
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterCreateChatProtocol: AnyObject {
    func didFetchContacts(_ sections: [ContactSection])
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterCreateChatProtocol {
    
}
