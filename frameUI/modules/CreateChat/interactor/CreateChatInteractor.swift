//
//  CreateChatInteractor.swift
//  Tedr
//
//  Created by Temur on 09/07/2025.
//  
//

import Foundation

class CreateChatInteractor: PresenterToInteractorCreateChatProtocol {

    // MARK: Properties
    weak var presenter: InteractorToPresenterCreateChatProtocol?
    
    var mockContacts: [ContactSection] = [
        ContactSection(title: "A", contacts: [
            Contact(imageURL: "https://randomuser.me/api/portraits/men/1.jpg", firstName: "Anthony", lastName: "Walker", username: "@anthony"),
            Contact(imageURL: "https://randomuser.me/api/portraits/women/1.jpg", firstName: "Alexandra", lastName: "Smith", username: "@alexandra")
        ]),
        ContactSection(title: "B", contacts: [
            Contact(imageURL: "https://randomuser.me/api/portraits/men/2.jpg", firstName: "Barry", lastName: "Wine", username: "@barry"),
            Contact(imageURL: "https://randomuser.me/api/portraits/women/2.jpg", firstName: "Black", lastName: "Sea", username: "@blacksea")
        ]),
        ContactSection(title: "C", contacts: [
            Contact(imageURL: "https://randomuser.me/api/portraits/men/3.jpg", firstName: "Chris", lastName: "Prett", username: "@prett")
        ])
    ]
    
    func fetchContacts() {
        presenter?.didFetchContacts(mockContacts)
    }
}
