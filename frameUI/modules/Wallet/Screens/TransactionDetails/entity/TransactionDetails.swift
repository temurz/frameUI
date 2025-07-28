//
//  TransactionDetails.swift
//  Tedr
//
//  Created by Temur on 30/05/2025.
//

struct TransactionDetails {
    var recipient: User
    var address: String
    var memo: String
    var network: String
    var fee: String
    var amountToBeSent: String
    var total: String
}


struct User {
    var name: String
    var imageURL: String
}
