//
//  Contact.swift
//  Tedr
//
//  Created by Temur on 10/07/2025.
//

class Contact {
    let imageURL: String
    let firstName: String
    let lastName: String
    let username: String
    var isSelected: Bool
    
    var fullName: String {
        firstName + " " + lastName
    }
    
    init(imageURL: String, firstName: String, lastName: String, username: String, isSelected: Bool = false) {
        self.imageURL = imageURL
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
        self.isSelected = isSelected
    }
}
