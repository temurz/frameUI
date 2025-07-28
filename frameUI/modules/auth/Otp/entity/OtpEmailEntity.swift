//
//  OtpEmailEntity.swift
//  Tedr
//
//  Created by Kostya Lee on 09/05/25.
//

import Foundation
class OtpEmailEntity {
    var title: String
    var subtitle: String
    var email: String
    var spamMessage: String
    var timerDuration: Int
    
    init(title: String, subtitle: String, email: String, spamMessage: String, timerDuration: Int) {
        self.title = title
        self.subtitle = subtitle
        self.email = email
        self.spamMessage = spamMessage
        self.timerDuration = timerDuration
    }
}
